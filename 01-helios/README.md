---
state: index — pillar overview
last-verified: 2026-05-09
---

# HELIOS — Inference Substrate Canon

> *Attention is not a softmax pass. It is an interruptible computation, scored against an audit invariant, with a verifiable static fallback.*

HELIOS is the larger of the two flagship pillars. It is a multi-tier theorem canon for post-transformer sparse runtimes, organized around four ideas:

1. **Substrate-foundational invariants (E1–E7).** Density, sheaf-gluing, storage budget, master inequality, fusion, error-enriched convergence, autogenous identity. If any of these fails its falsifier, the substrate is broken.
2. **Build / canon claims (H1–H17).** Operational claims that the runtime depends on but that are not load-bearing for the substrate definition itself.
3. **Parameter Connectome Family (T25–T34).** The safety pillar — bounds on component-edit harm, faithful runtime lift of parameter decompositions, sheaf consistency over component clusters.
4. **Attention as Interrupt (V6.1).** The single highest-signal idea: attention re-rendered as an audit-grade interrupt with a static fallback that must be acknowledged.

---

## Reading order

Hiring-manager / new reader path:

1. [`04-attention-as-interrupt/README.md`](./04-attention-as-interrupt/README.md) — start here. The thesis in 1–2 minutes.
2. [`03-parameter-connectome-T25-T34/README.md`](./03-parameter-connectome-T25-T34/README.md) — the safety pillar. T29 is the flagship safety theorem.
3. [`05-kernels-targets/README.md`](./05-kernels-targets/README.md) — what is target-only vs. implemented. Read this *before* believing any kernel claim downstream.
4. [`01-foundational-E1-E7/`](./01-foundational-E1-E7/) — the substrate-load-bearing invariants (deeper read).
5. [`02-build-canon-H1-H17/`](./02-build-canon-H1-H17/) — operational claims (deepest read).

---

## What is canonical vs. target-only

The HELIOS V6.1 audit (`V6_1_LEAN_REALITY_MATRIX_2026_05_06`) is the source of truth for the verified-vs-target boundary. Briefly:

| Surface | Status |
|---|---|
| `AnswerPacket` `attention_mode` field, both Rust and Swift | EV |
| `ClaimKind::StaticFallbackAcknowledged` source-lint contract | EV |
| Goodfire VPD precision (9972 / 205 / 2.1%) | EV (revalidated 2026-05-07) |
| Five-plane discipline (State / Episodic / Assembly / Controller / Verification) | EV |
| MAS / Pro / Vault execution policy | EV |
| Lean theorem-stub substrate, sorry-budget tracker | EV |
| `SemiseparableBlockScan.metal` | P (target only) |
| `LocalRecallIsland.metal` | P (target only) |
| `PageGather.metal` | P (target only) |
| `ControllerKernelPack.metal` | P (target only) |
| `PacketRouter1bit.metal` | P (target only) |
| `InterruptScore.metal` (Metal kernel) | P (Swift CPU canonical for V6.2) |
| T35 ρ_max = 0.20 at 128 K context | P (encoded, not hardware-proven) |
| Donor-distilled student (Qwen3-8B → Granite-4-H) | P (not yet trained) |

**This honesty is part of the architecture.** The canonical *target* is named separately from the canonical *implementation*. A kernel listed as a target is not a finished claim; it is a contract for what the falsifier must check when the kernel lands.

---

## V6.2 hardware lock

V6.2 retags the verification envelope to M2 Pro 16 GB:

> *If it works on the M2 Pro 16 GB ship rig, it can ship. If it requires a workstation, it is research-tier.*

The product name remains Epistemos. **Helios remains the architecture / substrate canon name.** The V6.2 lock changes the falsifier rig, not the canon. Specifically:

- PageGather: 70% of *measured* `BW_baseline_M2Pro` (63–73 GB/s sustained) — not 70% of the 200 GB/s theoretical peak.
- LocalRecallIsland: 32 K *Core*, 128 K *Stretch*.
- SemiseparableBlockScan: 32 K *Core*, 128 K *Stretch*.
- InterruptScore: Swift CPU canonical for single-token V6.2 use; Metal shadow only for batches ≥ 64 tokens.

---

## Citation lineage (short form)

Full citations and verification dates are in [`../REFERENCES.md`](../REFERENCES.md). Headline papers HELIOS depends on:

- SPD parameter decomposition: Bushnaq-Braun-Sharkey arXiv:2506.20790, Braun et al. arXiv:2501.14926.
- Sparse autoencoders: Bricken et al. (Anthropic, 2023), Cunningham et al. arXiv:2309.08600.
- Cellular sheaves on ML substrates: Hansen-Ghrist 2019, Bodnar et al. arXiv:2202.04579 (NeurIPS 2022).
- Goodfire VPD atlas: https://www.goodfire.ai/research/interpreting-lm-parameters.
- PagedAttention storage discipline: Kwon et al. arXiv:2309.06180 (SOSP 2023).
- BitNet b1.58 / Sparse Ternary GEMM: arXiv:2504.12285, arXiv:2510.06957.
- Modern Hopfield retrieval bound: Ramsauer et al. arXiv:2008.02217.

---

## Lane assignments

HELIOS uses a 5-lane register to mark where each entry runs in the deployment matrix:

- **L1 — MAS-add.** Ships in the App Store-bounded build. Includes the `AnswerPacket` audit substrate, semantic BTM V1.5, and Tier-1 mathematically-equivalent kernel drop-ins.
- **L2 — Pro-tier.** Ships in the full-autonomy build only. Includes opportunistic kernel upgrades, T-MAC LUT, BitNet b1.58, runtime active-rank-one experiments (flagged).
- **L3 — Research.** Lives in the research crate. Includes VPD extraction, dual connectome trace, ParamAnchor library, QK edge anchors.
- **L4 — Reserved.** Unassigned at lock.
- **L5 — Vault.** Vault-only / experimental. Includes HCache/KVCrush, ModelSurgery, active rank-one runtime, connectome distillation (T34).

A claim's lane assignment is not the same as its status (C / EV / EB / P / DROP). A canonical claim can be Vault-only; a Vault-only claim can be empirically verified.
