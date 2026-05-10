---
state: P (Provisional, Candidate)
lane: L3 (Research)
sorry-budget: ≤ 7
last-verified: 2026-05-09
---

# T32 — Parameter Connectome Sheaf Consistency

> *The parameter connectome over component clusters carries a cellular sheaf (Hansen-Ghrist, Bodnar et al.) whose global sections coincide with consistent multi-component computations.*

The structure theorem. Says the parameter connectome is not just a graph — it is a sheaf, and the *consistent* multi-component computations are exactly the global sections of that sheaf.

---

## Statement

Let `G` be the parameter connectome graph: vertices are component clusters from a faithful parameter decomposition; edges are interaction edges (e.g., from a QK-attention coupling or a residual-stream pathway). Let `F : G → Vect` be a cellular sheaf assigning to each vertex a vector space of component states and to each edge a linear restriction map.

Then a multi-component computation is *consistent* (in the sense that its component states agree on shared edges) iff its component-state assignment is a global section `s ∈ Γ(G, F) = H⁰(G, F) = ker δ⁰`.

The cellular-sheaf machinery is per Hansen-Ghrist 2019, applied to the parameter-space substrate per Bodnar et al. arXiv:2202.04579 (Neural Sheaf Diffusion, NeurIPS 2022).

---

## Why this is the structure

If the parameter connectome is *just* a graph, then "consistent multi-component computation" is an informal notion — you have to check by hand. If the connectome carries a sheaf, then *consistent computations are exactly the kernel of the cellular coboundary*, which is an algebraic object you can compute, bound, and reason about.

This is what T32 buys you:

1. **A finite-dimensional algebraic characterization** of the consistent multi-component computations. Not a soup of "we hope these agree."
2. **A spectral handle.** The sheaf-Laplacian has a spectrum; the spectral gap correlates with circuit modularity (the falsifier).
3. **A path to E2.** T32 is the parameter-space analogue of E2 (Ultrametric-Sheaf Gluing), which makes the same statement at the patch-graph level. The two are different applications of the same machinery.

---

## Falsifier protocol

**Hardware:** any (no special M2 Pro requirement).

**Procedure:**

1. Construct a parameter connectome graph `G` from a model with a known component decomposition.
2. Build the cellular sheaf `F` from the QK / residual-stream interaction structure.
3. Compute the sheaf-Laplacian `L_F` and its spectral gap.
4. Independently measure empirical component-circuit modularity (e.g., via standard mech-interp circuit-extraction techniques).
5. Compute the Spearman correlation between spectral gap and empirical modularity.

**Pass criterion:** Spearman ρ ≥ 0.5 between sheaf-Laplacian spectral gap and empirical component-circuit modularity.

**Status:** P. Not yet run.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker constructs a model where the component decomposition is faithful but the parameter connectome graph fails the cellular-sheaf consistency check (e.g., the restriction maps don't compose properly). **Defense:** the cellular-sheaf hypothesis is stated as a hypothesis, not a claim. The theorem says: *if* the connectome carries a cellular sheaf, *then* global sections are the consistent computations. A model where the hypothesis fails simply does not satisfy T32; that is the right answer.

> **Adversarial attack (subtler):** an attacker constructs a model where the sheaf exists but its sheaf-Laplacian spectral gap does not correlate with empirical circuit modularity (the falsifier fails). **Defense:** that is the falsifier — the entry remains P precisely because this could happen. If it does, T32 demotes to DROP and the literature collision check (Hansen-Ghrist, Bodnar et al.) gets a corresponding update.

---

## Literature collision

- **Hansen-Ghrist 2019 (cellular sheaves on graphs).** The foundational machinery. T32 applies it to the parameter-connectome substrate.
- **Bodnar, Di Giovanni, Chamberlain, Liò, Bronstein arXiv:2202.04579 (Neural Sheaf Diffusion, NeurIPS 2022).** The closest existing application — applies cellular sheaves to *node-feature graphs* (graph neural network substrates). T32 differs by applying the sheaf to a *parameter connectome*, not an input graph.
- **Earlier internal drafts cited arXiv:2206.04386** — that is a different paper. The corrected canonical reference is arXiv:2202.04579 per HELIOS V5 audit Patch 3.

---

## Open questions

- Whether the cellular-sheaf substrate in T32 lifts to a *higher* sheaf-cohomology structure (H¹, H², …) carrying additional invariants. Recorded as open in [`../../speculative/`](../../speculative/).
- The empirical pipeline for measuring "circuit modularity" is still under development. The falsifier requires a measurement that is reproducible across mech-interp groups.
- The degree to which T32 holds for *non-cellular* sheaf substrates (where the restriction maps are not linear) is open.

---

## Lane and downstream impact

- **Lane:** L3 (Research). T32 informs runtime invariants but does not directly modify a running runtime.
- **Downstream:** if T32 holds, the consistent-multi-component-computation predicate becomes computable; this could inform a future runtime invariant on which component-cluster combinations are *coherent* enough to compute jointly.

MAS impact: zero.
