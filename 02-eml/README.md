---
state: index — pillar overview
last-verified: 2026-05-09
---

# EML — Reconceptualizing Computation

> *Elementary scientific computation reduces to a single binary operator: `eml(x, y) = exp(x) − ln(y)`. The grammar `S → 1 | eml(S, S)` is dense in the continuous functions over compact domains. The kernel design problem becomes a Stone-Weierstrass density argument plus an ULP-bounded equivalence check.*

EML is a parallel research program to HELIOS. It does not depend on HELIOS, and HELIOS does not depend on it. It is the *second* flagship pillar of this repo because it is the most opinionated reconceptualization in the work.

---

## The thesis in one paragraph

The standard story about kernel design is "implement the math, hope the precision works out, accept that floating-point error is endemic, write a thousand fused kernels for a thousand math operations." EML proposes a different story. Define a single binary operator, `eml(x, y) = exp(x) − ln(y)`. Build a recursive grammar `S → 1 | eml(S, S)` from it. Show — by Stone-Weierstrass — that this grammar is dense in the continuous functions over compact domains. Then the kernel design problem becomes:

1. **Implement *one* kernel.**
2. **Verify it against an ULP-bounded oracle.**
3. **Compose larger computations from this single primitive.**

The `F-ULP-Oracle` is the falsifier: 412,000 log-sampled points, 2 ULP fp16 tolerance, ≤ 90 s wall-clock on M2 Pro 16 GB, with `oxieml::EmlTree::eval_real` as the reference oracle.

If the operator is right, every elementary scientific computation has a single well-defined verification target.

---

## Reading order

1. [`01-operator/`](./01-operator/) — the operator: `eml(x, y) = exp(x) − ln(y)`. The most basic claim.
2. [`02-grammar/`](./02-grammar/) — the grammar: `S → 1 | eml(S, S)`. Why the terminal `1` is required.
3. [`03-density/`](./03-density/) — the Stone-Weierstrass density argument with explicit hypotheses and a literature collision check.
4. [`06-f-ulp-oracle/`](./06-f-ulp-oracle/) — **the flagship falsifier.** This is the read for someone who wants to know whether EML is engineering or fantasy.
5. [`04-implementations/`](./04-implementations/) — vendor notes for `oxieml` (Rust) and `eml-lean` (Lean).
6. [`05-morph-eval-reduced/`](./05-morph-eval-reduced/) — Metal kernel spec, target-only.
7. [`07-open-questions/`](./07-open-questions/) — what is open and why.

---

## Status — at a glance

| Component | Status | Notes |
|---|---|---|
| Operator definition `eml(x, y) = exp(x) − ln(y)` | C (canonical) | Definition, not claim |
| Grammar `S → 1 | eml(S, S)` with terminal `1` required | C (canonical) | Definition; no terminal `1` is rejected |
| Stone-Weierstrass density (over compact `K`, with coordinates + conjugation + constants) | C | Standard result, applied |
| Constant-free universal EML generation | open | See [`07-open-questions/`](./07-open-questions/) |
| Monnerot `eml*` formulation as citable canon | DROP | Demoted until independently verified |
| Single-2-cell ZX/ZH Sheffer stroke | DROP | Demoted from a commitment |
| Single-generator Clifford universality | DROP | Demoted from a commitment |
| `oxieml` Rust library | C (vendored, read-only) | Reference oracle |
| `eml-lean` Lean library | C (vendored, read-only) | Claimed zero `sorry` / `admit` posture, to verify |
| `morph_eval_reduced.metal v0.1` Metal kernel | P (target only) | Falsifier specified, kernel not implemented |
| `F-ULP-Oracle` falsifier protocol | C (specified); EV (when implemented and run) | Currently P-passing-design |

---

## Why this is a research program, not a kernel project

The temptation is to read EML as "they want one kernel instead of many." That is technically what it is, but reducing it to that misses the point.

What EML *actually* claims is that **the math primitives our runtimes expose to higher layers are the wrong ones**. We have `add`, `mul`, `exp`, `ln`, `softmax`, `tanh`, `relu`, etc., each with its own implementation, its own precision quirks, its own kernel. The library surface is wide and brittle. EML asks: what if the right primitive is a single non-commutative binary operator that is provably dense over a compact domain? Then the library surface is *one operator*. The verification surface is *one falsifier*. The composition story is *one grammar*.

That is not a kernel project. It is a reconceptualization of what an elementary scientific computation *is*.

---

## What this is not

- It is not a claim that `eml` is the *unique* primitive that does this. Other primitives are dense too. EML's claim is that this *particular* primitive is dense, has a tight ULP-bounded falsifier, and admits a clean recursive grammar.
- It is not a claim that all of practical numerical computation should be rebuilt around `eml`. The claim is bounded to *elementary scientific computation* — the operations a calculator can do.
- It is not a claim that this work has been published. EML's grammar and density argument are stated and falsifiable; they are not yet peer-reviewed.
- It is not a claim that the constant-free universal formulation works. That is open and labeled.

---

## Citation lineage

- The Stone-Weierstrass density argument is the standard one (Stone 1948). Applied to a compact subset `K` with the necessary coordinates + conjugation + constants hypotheses.
- The `oxieml` library is a vendored Rust implementation; the `eml-lean` library is the Lean side. Vendoring is read-only with credit; both are tracked in [`04-implementations/`](./04-implementations/).
- The Monnerot `eml*` formulation is *not* citable canon at this lock; it is recorded for forensic completeness only.
