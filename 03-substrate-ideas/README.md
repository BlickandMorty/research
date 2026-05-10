---
state: index — pillar overview
last-verified: 2026-05-09
---

# Substrate Ideas

> *Smaller high-signal ideas that do not need a whole pillar of their own — but are load-bearing for HELIOS, EML, or both.*

Three independent ideas, each running in the same discipline as the larger pillars: status tag, falsifier protocol, attack-with-defense, citation lineage.

| Subdirectory | Idea | Status |
|---|---|---|
| [`01-storage-disaggregated-E3/`](./01-storage-disaggregated-E3/) | **SSD as a RAM extension.** Resident memory scales with active patches, not total archive size. | EV (the runtime invariant; the underlying mmap proof is implemented and tested) |
| [`02-acs-episodic-plane/`](./02-acs-episodic-plane/) | **ACS in the Episodic plane.** Where the Audit Claim Substrate lives in the five-plane formalism. | C |
| [`03-honesty-by-construction/`](./03-honesty-by-construction/) | **`StaticFallbackAcknowledged` contract.** Silent fallback is a compile error. | EV |
| [`04-five-plane-formalism/`](./04-five-plane-formalism/) | **State / Episodic / Assembly / Controller / Verification.** The plane×stream matrix. | EV |
| [`05-data-as-lattice/`](./05-data-as-lattice/) | **Data as lattice — shared ontology across game systems.** The gaming application of the substrate's sheaf-consistency / lattice-coder machinery. | P (provisional) |

The first four are *substrate-foundational* in a different sense than HELIOS's E1–E7. They are not theorems in the strict sense — they are *runtime invariants* that the runtime is built to satisfy. The verification is in the runtime tests, not in a Lean proof. The fifth (data-as-lattice) is a *gaming-application* avenue and is provisional until a prototype demonstrates it.

---

## Why these are in their own pillar

A reader who only cares about safety theorems can stop at HELIOS's Parameter Connectome Family. A reader who only cares about EML can stop at the F-ULP-Oracle. But the *shape* of the runtime — how memory is budgeted, where ACS lives, why honesty-as-a-compile-error is enforceable — informs both pillars and stands on its own.

These ideas also compose differently with each other than with HELIOS or EML:

- The five-plane formalism is the *frame* in which `StaticFallbackAcknowledged` is enforceable.
- Storage-disaggregation is what makes the Episodic plane (where ACS lives) cheap enough to be the default audit substrate, not an opt-in.
- ACS, in turn, is what makes `StaticFallbackAcknowledged` *meaningful* — it gives the source-lint contract something to lint against.

So: the four substrate ideas form a connected web that the larger pillars sit on top of.

---

## Reading order

For the runtime substrate (the first four):

1. [`04-five-plane-formalism/`](./04-five-plane-formalism/) — read this first; it sets the frame.
2. [`02-acs-episodic-plane/`](./02-acs-episodic-plane/) — what ACS is and where it lives.
3. [`03-honesty-by-construction/`](./03-honesty-by-construction/) — the `StaticFallbackAcknowledged` contract.
4. [`01-storage-disaggregated-E3/`](./01-storage-disaggregated-E3/) — the storage discipline that makes the rest cheap.

For the gaming application:

5. [`05-data-as-lattice/`](./05-data-as-lattice/) — independent avenue. The same machinery that gives the parameter connectome its sheaf-consistency structure (T32) gives game systems their ontological consistency. Read this when you want to see the substrate's reach outside the post-transformer-runtime context.

---

## What is verified

Per the V6.1 Lean Reality Matrix (2026-05-06):

| Surface | Evidence | Status |
|---|---|---|
| `AnswerPacket.attention_mode` (Rust + Swift) | `agent_core/src/scope_rex/answer_packet.rs`; `Epistemos/Models/AnswerPacket.swift`; W1 falsifier | EV |
| `ClaimKind::StaticFallbackAcknowledged` source-lint contract | doctrine linter gate 6.1 | EV |
| Goodfire VPD precision (9972/205/2.1%) | `epistemos-research/src/goodfire_vpd_specs.rs`; canonical-consistency tests | EV |
| Five-plane discipline (15-cell stream-plane matrix) | `epistemos-research/src/v6_1_stream_surface.rs`; `v6_1_execution_policy.rs` | EV (97 canonical-consistency tests pass) |
| ACS plane placement | `epistemos-research/src/acs.rs` | EV |
| MAS / Pro / Vault execution policy | `epistemos-research/src/v6_1_execution_policy.rs` | EV |
| SSD/RAM mmap substrate | `agent_core/src/arena/mod.rs`; `agent_core/tests/arena_budget.rs` | EV (real `MAP_SHARED` arena, producer/consumer/reopen tested) |

The verification artifacts live in the private Epistemos repo. This public repo states the invariants and references the verification commands; the actual code is not exposed.
