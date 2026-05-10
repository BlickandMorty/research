---
state: index — sub-section overview
last-verified: 2026-05-09
---

# Parameter Connectome Family — T25 through T34

> *Mathematical safety primitives in the parameter subspace. The thesis: a sparse, faithful decomposition of model parameters lifts to runtime as an active-rank-one execution path; component-level edits bound out-of-edit perplexity drift; the connectome over component clusters carries a cellular sheaf whose global sections coincide with consistent multi-component computations.*

This subdirectory holds the ten Parameter Connectome Family theorems (T25–T34). All ten are status `P` (Provisional, Candidate) at the lock, with sorry-budgets ≤ 7 each, falsifier protocols on M2 Pro 16 GB (V6.2 retag from M2 Max), and named adversarial attacks paired with named defenses.

---

## The flagship trio for the safety thesis

Three of the ten do most of the safety-pillar work:

| ID | Title | Role |
|---|---|---|
| **T28** | [Interpretability-to-Runtime Transfer](./T28-runtime-transfer.md) | The lift: SPD-faithful decomposition → active-rank-one runtime with bounded drift. |
| **T29** | [Component Edit Safety Bound](./T29-edit-safety-bound.md) | The bound: editing components of size ≤ s_max bounds out-of-edit PPL drift by O(s_max · σ_max(W_edit)). |
| **T32** | [Parameter Connectome Sheaf Consistency](./T32-sheaf-consistency.md) | The structure: the connectome carries a cellular sheaf whose global sections are the consistent multi-component computations. |

**Read these three first.** The others (T25, T26, T27, T30, T31, T33, T34) extend the program; they are not prerequisites for understanding the safety position.

---

## All ten — short list

Per HELIOS V5 Theorem Canon (`docs/HELIOS_V5_DOC_6_THEOREM_CANON.md`, source: private Epistemos repo). Each is `state: P (Candidate)` at lock unless noted; sorry-budget ≤ 7.

| ID | Title | Lane | Sorry-budget |
|---|---|---|---|
| T25 | VPD Extraction (atlas-grade decomposition) | L3 | ≤ 7 |
| T26 | Attention Edge Assembly (QK Decomposition) | L3 | ≤ 5 |
| T27 | Parameter-to-Cortical-Packet Lift | L3 | ≤ 7 |
| T28 | Interpretability-to-Runtime Transfer | L5 | ≤ 7 |
| T29 | Component Edit Safety Bound | L5 | ≤ 7 |
| T30 | Component Cluster Compression | L3 | ≤ 5 |
| T31 | Dual Decomposition Completeness | L3 | ≤ 7 |
| T32 | Parameter Connectome Sheaf Consistency | L3 | ≤ 7 |
| T33 | Active Rank-One Execution | L5 | ≤ 7 |
| T34 | Connectome Distillation | L5 | ≤ 7 |

L5 (Vault) = produces an alternate model file; never modifies a running runtime in MAS.
L3 (Research) = research-crate work that may inform L1 (MAS) invariants downstream.

---

## What is verified vs. what is target

**Verified (EV):**

- The Goodfire VPD atlas integration (atlas table 9972 / 205 / 2.1%) has been revalidated against Goodfire's public research page on 2026-05-07, with `epistemos-research/src/goodfire_vpd_specs.rs` carrying canonical-consistency tests that prevent silent precision drift.
- The five-plane × three-stream policy matrix that determines where each connectome theorem can ship.
- The sorry-budget ledger that tracks proof debt per theorem.

**Target only (P):**

- Every T25–T34 falsifier protocol is *specified* but most have not been run end-to-end on the M2 Pro 16 GB rig.
- The active rank-one runtime path (T33) is encoded in research code; the corresponding always-on runtime invariant is not yet wired into MAS-ship code.
- The donor-distilled student (Qwen3-8B → Granite-4-H-shape) of T34 is not yet trained.

The repo's discipline forbids upgrading status from P to EV without a passing run log committed to the entry.

---

## Citation lineage

The Parameter Connectome Family sits at the intersection of three traditions:

1. **Stochastic / Attribution-based Parameter Decomposition (SPD / APD).** Bushnaq-Braun-Sharkey arXiv:2506.20790; Braun et al. arXiv:2501.14926. T28 lifts this to runtime; T31 uses it as half of the dual decomposition.
2. **Sparse Autoencoders (SAE).** Bricken et al. (Anthropic, 2023); Cunningham et al. arXiv:2309.08600. T31 uses SAE as the activation-space half of the dual decomposition.
3. **Cellular sheaves on ML substrates.** Hansen-Ghrist 2019; Bodnar et al. arXiv:2202.04579 (NeurIPS 2022, *Neural Sheaf Diffusion*). T32 directly uses the cellular-sheaf machinery.

Adjacent collisions worth a literature read:

- Buzsáki Neuron 68:362, 2010 (cell-assembly neuroscience) and Olshausen-Field Nature 381:607, 1996 (sparse coding). T27 *imports* the cell-assembly framing as a falsifiable engineering hypothesis, not a theorem.
- Modern Hopfield (Ramsauer arXiv:2008.02217) — closest published bound, but on retrieval error rather than witnessed bandwidth (relevant for E4 / WBO-7).

---

## What this is not

The Parameter Connectome Family does **not** claim:

- That sparse parameter decompositions universally exist (T28's hypothesis is faithfulness in the SPD sense — a stated assumption, not a derived one).
- That cellular sheaves are *the* right structure for arbitrary parameter spaces (T32 is bounded to component-cluster connectomes).
- That bounded edit drift implies bounded harm (T29 bounds *PPL drift on out-of-edit prompts*; harm is a separate, semantic question).
- That this work is published. Every T25–T34 entry is a candidate at lock.

The honesty about what is *not* claimed is half the point of the family. The other half is the bounds that *are* claimed — concrete, falsifiable, and named.
