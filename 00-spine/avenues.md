# Avenues

> *The same substrate expressed across the avenues it actually shows up in. One body of work, seven entry points.*

The three pillars of this repo (HELIOS, EML, substrate ideas) are *not* topic clusters. They are different angles on a single position: build the substrate so that bounded harm, bounded faithfulness, and bounded computation cost are first-class invariants of the runtime. Different readers care about different *consequences*. This file maps the work to the avenue you came in on.

---

## 1. Safety

**Thesis:** safety is a property of the latent and parameter subspaces, not a downstream classifier.

The clearest exposition is the [Parameter Connectome Family (T25–T34)](../01-helios/03-parameter-connectome-T25-T34/) — specifically:

- [**T29 — Component Edit Safety Bound**](../01-helios/03-parameter-connectome-T25-T34/T29-edit-safety-bound.md). Edits to a sparse, faithful component decomposition bound out-of-edit perplexity drift by `O(s_max · σ_max(W_edit))`. Falsifier: Goodfire-style emoticon edit, off-distribution PPL drift ≤ 1.0.
- [**Attention as Interrupt**](../01-helios/04-attention-as-interrupt/). The audit substrate: every emission carries `attention_mode ∈ {dynamic, static_fallback, unavailable}`; static fallback that is not acknowledged fails the source-lint contract.
- [**Honesty-by-construction**](../03-substrate-ideas/03-honesty-by-construction/). `ClaimKind::StaticFallbackAcknowledged` makes silent fallback a compile error.

The point is not "we trained a safety classifier." The point is that the runtime's audit substrate makes harmful emissions *observable*, and the parameter-space bounds make safety *editable* — both as first-class properties.

For the **architectural-ambition** version of the safety thesis — "cognition itself must be constitutive geometry, not just safety" — see [`04-cms-x/`](../04-cms-x/) and especially [`04-cms-x/02-five-force-laws.md`](../04-cms-x/02-five-force-laws.md) (Neural Barrier Function as `F_constraint`). CMS-X is theoretical at this lock; the operational pieces above (T29, attention-as-interrupt, honesty-by-construction) are the ones that ship.

---

## 2. Performance

**Thesis:** the kernel pack and the storage discipline together determine ship-rig performance; both are stated as falsifier protocols on commodity hardware (M2 Pro 16 GB).

- [**E3 — Storage-Disaggregated Morph Field**](../03-substrate-ideas/01-storage-disaggregated-E3/). Resident memory scales with active patches, not total archive size. Verified empirically with a `MAP_SHARED` arena producer/consumer test. PagedAttention (Kwon et al. arXiv:2309.06180) is the closest literature collision.
- [**Kernel targets (PageGather, ControllerKernelPack, etc.)**](../01-helios/05-kernels-targets/). Six load-bearing Metal kernels with named falsifier thresholds (e.g., PageGather: ≥ 70% of *measured* `BW_baseline_M2Pro` 63–73 GB/s sustained, not 70% of the 200 GB/s theoretical peak). All target-only at this lock — the discipline is to be honest about what is implemented vs. what is contracted.
- [**Falsifiers infrastructure**](../falsifiers/). Run-log discipline: hardware ID, date, kernel revision, oracle revision, pass/fail per criterion. Reproducible by a third party from the entry alone.

The performance story is *not* "ours is faster." It is "every performance claim is paired with a falsifier protocol on a named hardware rig." Speed without a verifiable bound is marketing.

---

## 3. Sparsity

**Thesis:** sparsity is what makes the runtime *bounded*; without sparsity, none of the safety bounds or the storage budget hold.

- [**T33 — Active Rank-One Execution**](../01-helios/03-parameter-connectome-T25-T34/) (in the family README). Per inference step, only the rank-one subcomponents whose pre-activation magnitude exceeds threshold τ contribute meaningfully — at least `(1 − δ)` of the output norm comes from a sparse subset.
- [**T28 — Interpretability-to-Runtime Transfer**](../01-helios/03-parameter-connectome-T25-T34/T28-runtime-transfer.md). The lift: SPD-faithful decomposition → active-rank-one runtime path with bounded perplexity drift. SPD references: Bushnaq-Braun-Sharkey arXiv:2506.20790; Braun et al. arXiv:2501.14926.
- [**T31 — Dual Decomposition Completeness**](../01-helios/03-parameter-connectome-T25-T34/) (in the family README). A dual decomposition combining parameter-space (SPD) and activation-space (SAE) is *more faithful* than either alone.
- The kernel target list ([01-helios/05-kernels-targets/](../01-helios/05-kernels-targets/)) reflects sparsity discipline: SemiseparableBlockScan, PacketRouter1bit, etc. — the kernels that operationalize sparsity at runtime.

Sparsity in this work is not a benchmark; it is a *substrate property*. T28 and T29 are bounds *because* the decomposition is sparse and faithful.

---

## 4. Local inference (Apple Silicon)

**Thesis:** the shippability lock is M2 Pro 16 GB. If a claim cannot be falsified on the ship rig, it is research-tier — not product-tier.

- The full V6.2 hardware lock posture is in [`../01-helios/README.md`](../01-helios/README.md#v62-hardware-lock).
- All falsifier protocols target the M2 Pro 16 GB rig; M2 Max remains as scale-validation only.
- The `InterruptScore` Swift CPU implementation is canonical for V6.2 single-token use, with a P99 < 100 µs target.
- Metal kernels compile against `xcrun -sdk macosx metal -std=metal3.1`; the existing 19 `.metal` shaders in the private substrate compile cleanly.

The local-inference story matters because the alternative — *"this works at scale, just not on a laptop"* — places safety properties behind compute access, which is the opposite of what this work is trying to do.

---

## 5. Kernel architecture

**Thesis (EML):** elementary scientific computation reduces to a single binary operator. The kernel design problem becomes a Stone-Weierstrass density argument plus an ULP-bounded equivalence check.

- [**The operator**](../02-eml/01-operator/): `eml(x, y) = exp(x) − ln(y)`. Non-commutative, mixes the two transcendental scales, has a tight ULP-bounded falsifier.
- [**The grammar**](../02-eml/02-grammar/): `S → 1 | eml(S, S)`. The terminal `1` is required.
- [**Density**](../02-eml/03-density/): Stone-Weierstrass — coordinates + conjugation + constants. Standard theorem, applied.
- [**F-ULP-Oracle**](../02-eml/06-f-ulp-oracle/): the falsifier — 412,000 log-sampled points, ≤ 2 ULP fp16 in `[0.5, 2.0]`, ≤ 90 s wall-clock on M2 Pro 16 GB, oracle reference `oxieml::EmlTree::eval_real`.

The kernel-architecture story sits adjacent to performance and sparsity but is its own thesis: instead of a wide library surface of fused kernels, build *one* kernel that passes *one* falsifier, and compose larger computations from this single primitive.

---

## 6. Interpretability research

**Thesis:** sparse parameter decompositions and sparse autoencoders together constitute a *dual* substrate; neither alone is sufficient for the safety bounds we want.

- The HELIOS Parameter Connectome Family ([01-helios/03-parameter-connectome-T25-T34/](../01-helios/03-parameter-connectome-T25-T34/)) is in conversation with:
  - **SPD / APD parameter-space decomposition** (Bushnaq-Braun-Sharkey arXiv:2506.20790; Braun et al. arXiv:2501.14926).
  - **Sparse autoencoders / dictionary learning** (Bricken et al. — Anthropic 2023; Cunningham et al. arXiv:2309.08600).
  - **Cellular sheaves on ML substrates** (Hansen-Ghrist 2019; Bodnar et al. arXiv:2202.04579, NeurIPS 2022).
  - **Goodfire VPD atlas** (https://www.goodfire.ai/research/interpreting-lm-parameters; revalidated 2026-05-07: total 38912 / alive 9972 / mean L0 205.0 / activity fraction 0.021).
- T31 explicitly states the dual claim — joint reconstruction MSE strictly less than min(SPD-only, SAE-only) — and names a falsifier.
- T32 adds the sheaf-consistency structure on the parameter connectome, treating cross-component coherence as a global-section problem.

This avenue is the most direct intersection with frontier mech-interp work. The vocabulary (SPD, SAE, Goodfire, cellular sheaves) is shared with the labs publishing in this space.

For the synthesis perspective — combining mech-interp parameter decomposition with runtime trajectory monitoring (TRACED) and latent-geometry alignment diagnostics (AQI) — see [`04-cms-x/04-traced-and-aqi.md`](../04-cms-x/04-traced-and-aqi.md). CMS-X argues these two metric surfaces are complementary and necessary together; both are validated independently in the literature.

---

## 7. Gaming

**Thesis:** reimagining game data as a lattice with shared ontology makes save state, mods, procedural generation, and cross-system interaction all consequences of a single typed structure.

- [**Data-as-lattice**](../03-substrate-ideas/05-data-as-lattice/) is the formal entry. The thesis is that *all* game data — combat, inventory, narrative, AI behavior, save state — lives on a shared lattice; cross-system interactions are decidable because the lattice has well-defined meet/join operations.
- The lattice-coder / Babai quantization machinery (already a tool in the broader substrate) becomes the natural way to handle nearest-lattice-point operations: procedural generation, save versioning, mod composition.
- The Beaba RPG concept is the design playground — a hidden 3-axis alignment system (compliance, honesty, autonomy) is a literal 3D sublattice; multi-language crafting (real Python / TypeScript) becomes a lattice morphism expressed in the player's chosen language.
- Adjacent: T32 sheaf consistency on the parameter connectome and the data-as-lattice claim share machinery — both ask "when do partial structures glue into a coherent global structure?"

The gaming avenue is the most speculative of the seven and is labeled as such. It is included because the substrate ideas — lattice structure, shared ontology, sheaf-consistent gluing — apply outside the post-transformer-runtime context, and the user-facing application that demonstrates this is a playable game, not another model.

---

## How to use this map

- If you came in for **safety**, start with [Attention-as-Interrupt](../01-helios/04-attention-as-interrupt/) and T29.
- If you came in for **performance**, start with [E3](../03-substrate-ideas/01-storage-disaggregated-E3/) and the [kernel-targets honesty doc](../01-helios/05-kernels-targets/).
- If you came in for **interpretability**, start with the [Parameter Connectome Family](../01-helios/03-parameter-connectome-T25-T34/) and the [References](../REFERENCES.md).
- If you came in for **kernel architecture / numerical methods**, start with [EML](../02-eml/) end to end.
- If you came in for **local-inference / Apple Silicon**, start with [HELIOS V6.2 hardware lock](../01-helios/README.md#v62-hardware-lock).
- If you came in for **cognitive architectures / dynamical systems**, start with [CMS-X](../04-cms-x/) — and read [`05-claim-calibration.md`](../04-cms-x/05-claim-calibration.md) **before** the architecture itself.
- If you came in for **game design / structured-data**, start with [data-as-lattice](../03-substrate-ideas/05-data-as-lattice/).

Whichever entry point: the [STATUS_LEGEND](../STATUS_LEGEND.md) is the prerequisite read. Status discipline is what separates this work from "interesting prose."
