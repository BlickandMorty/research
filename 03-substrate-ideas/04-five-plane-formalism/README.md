---
state: EV
lane: L1 / L2 / L5 (matrix; see below)
last-verified: 2026-05-09
---

# Five-Plane Formalism

> *State / Episodic / Assembly / Controller / Verification. Crossed with three streams (MAS / Pro / Vault), this gives the 15-cell matrix that the runtime executes inside.*

The structural decomposition of the runtime. Every other invariant in the substrate is stated in terms of *which plane* it lives in and *which stream* it ships in. **Empirically verified** by 97 canonical-consistency tests over the 15 stream-plane cells.

---

## The five planes

| Plane | Role | Examples |
|---|---|---|
| **State** | Per-step runtime state. Controller variables, KV cache, the `InterruptScore` computation. | `attention_mode` decision; per-token controller variables. |
| **Episodic** | Append-only history. Inputs, outputs, and ACS records. | The audit log; ACS claims; turn-level conversation history. |
| **Assembly** | Token-by-token attention assembly. The dynamic forward pass. | The transformer's forward pass when `attention_mode = Dynamic`. |
| **Controller** | Kernel pack and routing layer. Where kernels are invoked, scheduled, and (in Pro / Vault) opportunistically upgraded. | `ControllerKernelPack`; `PacketRouter1bit`; the Mamba2 shaders. |
| **Verification** | The audit boundary. Source-lint contracts, doctrine-lint gates, the canonical-consistency suite. | The `StaticFallbackAcknowledged` enforcement; the `ClaimKind` schema check. |

The Verification plane is *not* observability — it is a hard contract. Emissions that cross it must satisfy the schema; otherwise, source-lint rejects.

---

## The three streams

| Stream | Role | Policy |
|---|---|---|
| **MAS** | App Store-bounded build | Interrupt-first attention with static 9:1 fallback when dynamic signals are unavailable. Bounded execution surface. Review-safe. Ships agent + tools + local + cloud models. |
| **Pro** | Full-autonomy build | Full interrupt scoring + LocalRecallIsland policy. Shell + Docker + CLI reuse. Long-horizon. |
| **Vault** | Experimental / vault-only | 1-bit `PacketRouter`, `ConnectomeAlarm`. Modifies inference path; never modifies a running runtime in MAS. |

The streams are *deployment lanes*, not user tiers. MAS and Pro are *different builds* of the same codebase, with `#[cfg(feature = "pro-build")]` / `#if PRO_BUILD` gating the Pro-only features. The Vault stream is research-tier.

---

## The 15-cell matrix

Stream × plane = 15 cells. Per-cell policy is encoded in `epistemos-research/src/v6_1_execution_policy.rs`. Each cell has:

- A canonical *what runs here* (e.g., MAS × Verification = the source-lint contract).
- A canonical *what does NOT run here* (e.g., MAS × Assembly does not run runtime active-rank-one — that is L5, Vault).
- A canonical-consistency test that exercises the cell.

The 97 canonical-consistency tests at the V6.1 lock cover the full 15-cell matrix, with overlap on the cross-cutting invariants (ACS placement, the `attention_mode` field, the static-fallback acknowledgement contract).

---

## Why five and not four or six

Five is a structural choice with three load-bearing reasons:

1. **State and Episodic must be separate.** State is per-step and bounded; Episodic is append-only and grows. Conflating them produces a runtime that cannot bound its own working set.

2. **Assembly and Controller must be separate.** Assembly is the per-token forward pass; Controller is the kernel-and-routing layer. Conflating them produces a runtime that cannot opportunistically upgrade kernels without changing the per-token semantics.

3. **Verification must be its own plane.** The audit is *not* observability of State, Episodic, Assembly, or Controller. It is a contract that crosses all four. Putting Verification "inside" any of the other four planes would let emissions bypass it through the other planes.

A four-plane formalism merges State/Episodic or Assembly/Controller; either merge produces a substrate that cannot satisfy the audit contract. A six-plane formalism splits one of the existing planes (typically by separating Tools as their own plane); that is a future research direction, not a canonical commitment.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker constructs a runtime path that emits *without* crossing the Verification plane (e.g., a "fast path" that skips the audit gate). **Defense:** the source-lint contract requires every emission path to terminate at a Verification-plane gate. A path that skips Verification is rejected at compile time. The five-plane formalism gives this contract its target — emissions must be classified into one of the five planes, and Verification is the only one that admits boundary-crossing emissions.

> **Adversarial attack (subtler):** an attacker constructs a tool call that *does* cross Verification but produces a side effect that bypasses the audit contract (e.g., writes to long-term memory without a `MemoryWrite` claim). **Defense:** the Verification gate's contract is per-`ClaimKind`. A tool call that produces a `MemoryWrite` side-effect without the corresponding claim fails the source-lint gate for the *new* invariant — the formalism is extensible to new claim types as new side effects become first-class.

---

## Citation lineage

- The five-plane decomposition is internal-canonical — there is no published prior art that maps cleanly. The closest analogues:
  - **Erlang's process / message / mailbox decomposition** — operationally similar, but no Verification plane.
  - **Operating-system kernel / userspace / hypervisor decomposition** — adjacent; doesn't carry the audit-by-construction discipline.
  - **Service-oriented architectures with a separate audit log** — adjacent; treats audit as a side service rather than a co-equal plane.

The formalism is novel as a stated decomposition. Any of its component ideas have prior art.

---

## Lane and downstream impact

The formalism *is* the lane assignment. Every invariant in the substrate is stated in terms of which plane and which stream. Without the formalism, the L1 / L2 / L3 / L4 / L5 lane register would have nothing to refer to.

Downstream: the audit-grade `attention_mode`, the `StaticFallbackAcknowledged` contract, the ACS placement, the kernel target list — all are stated in terms of plane and stream. The formalism is the substrate of all four.
