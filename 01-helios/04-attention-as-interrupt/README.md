---
state: C (canonical) for the formalism; EV for the AnswerPacket audit substrate; P for the Metal kernel target
sorry-budget: not load-bearing here — see ../03-parameter-connectome-T25-T34/ for theorem files
last-verified: 2026-05-09
---

# Attention as Interrupt

> *The single highest-signal idea in HELIOS. The thesis in one paragraph: attention is not a softmax pass — it is an interruptible computation routed by an audit-grade signal, with a static fallback that the runtime must acknowledge.*

The flagship of HELIOS V6.1. The formalism, the audit substrate, and the kernel target are listed below. The first two are empirically verified; the third is target-only and labeled accordingly.

---

## Why this matters

Most safety work treats attention as a black box and bolts safety on as a downstream filter — refusal classifiers, hard-coded refusal templates, post-hoc red-team patches. That places the safety property in the *wrong* layer. The forward pass already happened. The model already decided. The classifier is a janitor.

Attention-as-interrupt moves the question one layer down. *Before* the softmax pass executes, an `InterruptScore` is computed. The score is not a refusal classifier — it is a runtime invariant that decides whether the dynamic attention pathway should run, whether to fall back to a deterministic static path, or whether the attention computation is structurally unavailable for this token.

Whatever the model emits, the `AnswerPacket` records *which path was taken*. A static fallback that is not acknowledged fails source-lint. Silent fallback is unrepresentable.

That is the position. The rest of this doc is the substrate.

---

## The formalism

### Five-plane runtime

The runtime is decomposed into five planes:

| Plane | Role | Where attention-as-interrupt lives |
|---|---|---|
| **State** | Per-step runtime state, controller variables | The `InterruptScore` is computed here |
| **Episodic** | Append-only log of inputs, outputs, fallbacks | `attention_mode` is logged here |
| **Assembly** | The token-by-token attention assembly itself | Dynamic vs. static path selection happens here |
| **Controller** | The kernel pack and routing layer | `ControllerKernelPack` (target) lives here |
| **Verification** | The audit boundary | Source-lint contract enforced here |

The Verification plane is *not* observability. It is a hard contract: emissions that cross it must satisfy the `ClaimKind` schema, including the static-fallback-acknowledgement rule.

→ See [`../../03-substrate-ideas/04-five-plane-formalism/`](../../03-substrate-ideas/04-five-plane-formalism/).

### Three streams

Plane × stream defines a 15-cell matrix. The streams are:

- **MAS** — App Store-bounded build. Interrupt-first policy with static 9:1 fallback when dynamic signals are unavailable.
- **Pro** — full-autonomy build. Full interrupt scoring + LocalRecallIsland policy.
- **Vault** — experimental / vault-only. Adds `PacketRouter1bit` and `ConnectomeAlarm` policy.

Per-stream policy is encoded in `epistemos-research/src/v6_1_execution_policy.rs` (status: EV).

---

## The audit substrate (EV)

### `AnswerPacket.attention_mode`

Every emission carries a discriminated tag:

```rust
pub enum AttentionMode {
    Dynamic,
    StaticFallback,
    Unavailable,
}
```

The default is `Unavailable`. A runtime that fails to set the field fails the schema check. A runtime that emits `StaticFallback` without a paired `ClaimKind::StaticFallbackAcknowledged` claim fails the source-lint contract.

This makes attention-routing a *first-class safety invariant*. You cannot run a system that produces an emission without recording how the attention path resolved.

### `ClaimKind::StaticFallbackAcknowledged`

The source-lint contract:

> An `AnswerPacket` with `attention_mode = StaticFallback` MUST be paired with a `ClaimKind::StaticFallbackAcknowledged` claim. Emissions that violate this constraint are rejected at the source-lint layer.

In other words: **honesty-as-a-compile-error.**

### What this gives you

- Auditing whether the model fell back to a deterministic path on harmful prompts becomes a database query, not a hand inspection.
- Refusal-quality regressions are *observable* — you can correlate `StaticFallback` rate with prompt-distribution shifts.
- Adversaries that "trick" the model into using the dynamic pathway when the static would have refused are detectable in the audit log.

---

## The kernel target (P — target only)

### `InterruptScore.metal`

**Status: P (provisional, target only).** The interrupt-score equation is encoded in research code (`epistemos-research/src/v6_1_*`). The Metal kernel is *not* implemented. The Swift CPU implementation is canonical for V6.2 single-token use, with a hard P99 < 100 µs budget. A Metal shadow kernel becomes relevant only for batches ≥ 64 tokens.

The target contract:

- **CPU canonical** (Swift): P99 < 100 µs per token on M2 Pro 16 GB.
- **Metal shadow** (target): bit-exact agreement with CPU canonical at fp16 within the kernel's documented precision; activated only for batches ≥ 64 tokens.

Listing this as P (not EV) is part of the discipline. The Metal kernel is a contract, not a finished artifact.

→ See [`../05-kernels-targets/README.md`](../05-kernels-targets/README.md) for the full kernel target list.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker constructs an input that is computed under the dynamic pathway but is classified as benign — i.e., the static fallback would have refused, but the dynamic pathway emits a harmful continuation. The attacker also wants the audit log to claim the static path was used. **Defense:** the `AnswerPacket.attention_mode` is set by the runtime *at the kernel boundary*, not at the application layer. The source-lint contract rejects emissions where the application-layer claim disagrees with the kernel-layer field. A single source of truth makes this attack a runtime panic, not a silent compromise.

> **Adversarial attack (subtler):** an attacker plants a `StaticFallbackAcknowledged` claim alongside an emission that *was* dynamic, hoping to make their dynamic-pathway harm look like an honest fallback. **Defense:** the `ClaimKind` schema requires the claim to be authored by the *kernel*, not by user-facing code. Tampered claims fail the chain-of-custody check.

---

## Falsifier protocol

| Surface | Falsifier | Hardware | Result |
|---|---|---|---|
| `AnswerPacket.attention_mode` field present, both Rust and Swift | Compile-time check + W1 falsifier run | M2 Pro 16 GB | EV — passes |
| `StaticFallbackAcknowledged` enforcement | Source-lint linter run on the runtime's emission paths | Any | EV — passes |
| Five-plane discipline (15-cell stream-plane matrix) | `epistemos-research/tests/canonical_consistency.rs` | Any | EV — 97 canonical-consistency tests pass |
| Per-stream execution policy | `v6_1_execution_policy.rs` test suite | Any | EV — passes |
| `InterruptScore` Swift CPU P99 < 100 µs | Per-token timing benchmark on the M2 Pro 16 GB rig | M2 Pro 16 GB | P — benchmark designed, not yet run on the published rig |
| `InterruptScore.metal` bit-exact vs. CPU | Cartesia-style ULP-bounded comparison harness | M2 Pro 16 GB | P — kernel not implemented |

The honesty here is the point. The audit substrate is real and tested; the kernel is a target, and listed as such.

---

## Citation lineage

This work sits in conversation with several research directions:

- **Anthropic's mech-interp lineage** (Bricken et al. 2023, Goodfire VPD atlas) — for the parameter-space half of the picture; see [`../03-parameter-connectome-T25-T34/`](../03-parameter-connectome-T25-T34/).
- **PagedAttention** (Kwon et al. arXiv:2309.06180) — for the storage discipline that makes the static-fallback path *cheap enough* that it can be a real default; see [`../../03-substrate-ideas/01-storage-disaggregated-E3/`](../../03-substrate-ideas/01-storage-disaggregated-E3/).
- **Modern Hopfield** (Ramsauer et al. arXiv:2008.02217) — for the retrieval-error bound that informs the static path's worst-case behavior.

The novelty claimed here is *not* "we invented attention routing." Attention routing exists. The novelty is the *audit substrate* — the `AnswerPacket.attention_mode` field, the `StaticFallbackAcknowledged` source-lint contract, and the five-plane × three-stream matrix that pins where each invariant is enforced.

---

## Open questions

- The full V6.2 falsifier ladder for the kernel pack is sequenced in HELIOS V6.2 (Stage 0 → Stage 3). The `InterruptScore.metal` Metal kernel sits at Stage 3.
- The relationship between `InterruptScore` and the parameter-connectome safety bound (T29) — does an interrupt-routed pathway preserve the component-edit PPL bound, or is the bound only stated for the dynamic pathway? Recorded as an open question in [`../../speculative/`](../../speculative/) until formalized.
- Multi-token interrupt scoring is a separate question from per-token. The current canon is per-token. Multi-token batched scoring with a different P99 budget is on the V6.2 stretch list.
