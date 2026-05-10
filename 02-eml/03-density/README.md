---
state: C (canonical) — the Stone-Weierstrass density argument is a standard result, applied here
last-verified: 2026-05-09
---

# Density (Stone-Weierstrass)

> *The grammar `S → 1 | eml(S, S)` is dense in the continuous functions over compact domains, by Stone-Weierstrass — coordinates + conjugation + constants.*

The mathematical engine of EML. **This is the application of a standard result, not a new theorem.** Its role is to license the kernel-design reframing in [`../README.md`](../README.md).

---

## The argument (sketch)

Stone-Weierstrass says: a subalgebra `A` of `C(K, ℂ)` is dense iff `A` separates points, contains constants, and is closed under conjugation.

Apply to `S`:

1. **Constants.** The terminal `1 ∈ S` is a non-zero constant. Closure of the function-evaluations of `S` under pointwise operations gives all real constants. ✓

2. **Coordinates.** Sufficiently deep grammar expressions produce sentences that, under pointwise function evaluation on `K`, separate any two distinct points. Concretely: pick any two `p ≠ q` in `K`; there exists a sentence `s ∈ S` whose evaluated value at `p` differs from its evaluated value at `q`. The non-commutativity of `eml` and the unbounded depth of the grammar give enough freedom to construct such an `s`. ✓

3. **Conjugation.** For real-valued grammars (the default), conjugation is the identity and the hypothesis is satisfied trivially. For complex-valued extensions of the grammar (not load-bearing here), conjugation must be added explicitly. ✓

The standard Stone-Weierstrass conclusion then says: the closure of the grammar's function-evaluations under uniform convergence on `K` is *all* of `C(K, ℝ)` (resp. `C(K, ℂ)` in the complex case).

---

## What density does and does not give

Density gives:

- **For every continuous `f : K → ℝ` and every ε > 0, there exists a sentence `s ∈ S` whose function-evaluation `s(·) : K → ℝ` satisfies `‖s − f‖_∞ ≤ ε`.**

Density does *not* give:

- A bound on the *depth* of `s` as a function of ε. The grammar may need very deep sentences to ε-approximate a complicated `f`. This is the standard Stone-Weierstrass caveat.
- A *constructive* recipe for finding `s`. The result is existential.
- Density in non-uniform norms (e.g., `L²`). Stone-Weierstrass is a uniform-convergence result.
- Density on non-compact domains. The hypothesis `K compact` is essential.

---

## Why this matters for EML

The density result is what licenses the reframing in [`../README.md`](../README.md). Specifically:

- *If* the grammar is dense, then *every* elementary scientific computation can in principle be expressed (to ε precision) as a sentence in `S`.
- *If* every such sentence can be evaluated by composing a single kernel (`morph_eval_reduced.metal v0.1`), then *every* elementary computation reduces to that one kernel composed appropriately.
- *If* the kernel passes the `F-ULP-Oracle` falsifier, then the composition path is ULP-bounded.

The chain holds at the limit. The *practical* question is the depth-vs-error trade-off — open and recorded in [`../07-open-questions/`](../07-open-questions/).

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker points out that Stone-Weierstrass applies to *any* subalgebra that separates points and contains constants, and concludes EML's density is "trivial." **Defense:** the density of the *EML grammar specifically* is exactly what is claimed. The non-trivial content is *not* the density theorem itself — it is the operator choice (`exp(x) − ln(y)`) that makes the grammar both dense *and* admit a tight ULP-bounded falsifier. Density alone does not buy the ULP bound; a different dense subalgebra might not have the same precision properties.

> **Adversarial attack (subtler):** an attacker observes that the depth-required-for-ε-approximation may be unbounded for a complicated `f`, making the practical reframing impossible. **Defense:** that observation is correct and is recorded as the depth-vs-error open question. The density argument is what holds; the practicality of the reframing is an empirical question that depends on the depth distribution of expressions in real numerical workloads.

---

## Literature collision

- **Stone, M. H.** (1948). *The Generalized Weierstrass Approximation Theorem*. Mathematics Magazine 21:167-184, 237-254. The canonical reference. `[VERIFIED-PRINT-1948]`.
- The application of Stone-Weierstrass to a recursive grammar of a single non-commutative binary operator is, to the best of my literature collision check, novel — but the *theorem* applied is standard.
- **No published prior art** for the specific claim that the EML grammar is dense; this is recorded as a literature gap, *not* a novelty claim. (The novelty argument requires a peer-reviewed venue, which this work does not have.)

---

## Implementation pointers

- Lean stub: see [`../../lean/ResearchCanon/Eml/Density.lean`](../../lean/ResearchCanon/Eml/Density.lean) for the theorem signature; the sorry-budget is non-trivial (the Stone-Weierstrass machinery in mathlib4 is at `Mathlib.Topology.Algebra.StoneWeierstrass`).
