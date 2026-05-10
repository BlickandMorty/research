---
state: C (specification, canonical); will become EV when run on the M2 Pro 16 GB rig with a committed run log
last-verified: 2026-05-09
---

# F-ULP-Oracle — The Falsifier

> *The first hardware falsifier in the V6.1 Foundation sequence. Tests `morph_eval_reduced.metal v0.1` against `oxieml::EmlTree::eval_real` at 2 ULP fp16 over 412 K log-sampled points, in ≤ 90 s wall-clock, on M2 Pro 16 GB.*

The most concrete, most falsifiable, most load-bearing artifact in the EML pillar. **This is what makes EML engineering, not philosophy.**

---

## Specification

| Field | Value |
|---|---|
| **Sample set size** | 412,000 log-sampled points |
| **Stress points** | 2,048 |
| **Tolerance** | ≤ 2 ULP fp16 inside the canonical window `[0.5, 2.0]` |
| **Wall-clock budget** | ≤ 90 s on M2 Pro 16 GB |
| **Reference oracle** | `oxieml::EmlTree::eval_real` |
| **Kernel under test** | `morph_eval_reduced.metal v0.1` |
| **Hardware** | M2 Pro 16 GB (V6.2 retag from M2 Max original) |
| **Pass criterion** | every sample point agrees with the oracle to 2 ULP fp16 within the canonical window; total wall-clock under 90 s |

---

## Procedure

1. **Preparation.** Vendor `oxieml` at a tagged release. Vendor `eml-lean` at a tagged release (and verify the zero-`sorry` / zero-`admit` posture). Compile `morph_eval_reduced.metal v0.1` against `xcrun -sdk macosx metal -std=metal3.1`.

2. **Sample generation.** Generate 412,000 log-sampled `(x, y)` pairs with `x ∈ ℝ` and `y ∈ ℝ_{>0}`, both in the canonical window `[0.5, 2.0]`. Generate 2,048 stress points spanning the canonical window's boundaries.

3. **Oracle pass.** For each `(x, y)`, compute `z_ref = oxieml::EmlTree::eval_real(eml(x, y))`. Record the reference values.

4. **Kernel pass.** For each `(x, y)`, compute `z_kernel = morph_eval_reduced.metal(eml(x, y))` on the M2 Pro 16 GB rig. Record the kernel values and the wall-clock.

5. **Comparison.** For each `(x, y)`, compute the ULP distance `|z_ref − z_kernel|` measured in fp16 ULPs. The pass criterion is `≤ 2 ULP` for every sample point inside the canonical window.

6. **Run log.** Commit the run log: hardware ID, date, `oxieml` revision, kernel version, the four pass/fail metrics (sample-set pass rate, stress-set pass rate, max ULP distance, total wall-clock). The run log goes in [`runlog/`](./runlog/) (created on first run).

---

## Why this oracle is what it is

Three design choices, each load-bearing:

1. **412,000 log-sampled points** — large enough to make statistical luck implausible; log-sampling concentrates the test density in the regions where transcendental precision is most fragile.

2. **2 ULP fp16 in `[0.5, 2.0]`** — fp16 because that is the precision the kernel is implemented in; 2 ULP because it is the tight bound for compositional grammar expressions of bounded depth (1 ULP at each composition step accumulates).

3. **90 s wall-clock budget** — large enough to be achievable, small enough to prevent the kernel from "passing" by running slowly with absurd precision compensations. A correct kernel hits both targets at once.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker constructs a kernel that passes the 412,000-point set by interpolating from a precomputed lookup table for the canonical window, while failing on any point outside the window. **Defense:** (1) the falsifier explicitly tests *only* the canonical window; passing inside is the target. (2) the 2,048 stress-point set spans the *boundaries* of the canonical window, where lookup-table interpolation tends to fail. (3) the wall-clock budget makes a precomputed lookup table for 412,000 points size-prohibitive at the required precision.

> **Adversarial attack (subtler):** an attacker exploits the fact that the falsifier compares the kernel against `oxieml::EmlTree::eval_real` as a black-box oracle. If `oxieml` itself has a precision bug, the falsifier passes a buggy kernel that "agrees" with the buggy oracle. **Defense:** the falsifier records the `oxieml` revision used. Independent verification of `oxieml::EmlTree::eval_real` is a separate (and named) upstream verification problem; its correctness is not re-litigated here. If a defect is found upstream, the right move is to update the pinned revision and re-run.

---

## What passing this oracle gives you

If the F-ULP-Oracle passes:

- **The grammar `S → 1 | eml(S, S)` has a bit-exact-bounded runtime.** Every sentence in `S` of bounded depth evaluates to within 2 ULP fp16 of the canonical real value, in bounded time, on commodity hardware.
- **The Stone-Weierstrass density argument from [`../03-density/`](../03-density/) gets a runtime arm.** Density says every continuous `f` on `K` is ε-approximable by some sentence in `S`; passing the oracle says the *kernel* evaluates that sentence with bounded error.
- **The reframing in [`../README.md`](../README.md) becomes practical.** Reducing elementary scientific computation to a single kernel that passes a single falsifier is the entire point of EML.

If the F-ULP-Oracle fails, EML's claim that the kernel reframing is *practical* fails. The grammar density argument is independent and survives — but the practical reframing does not.

---

## Status

`state: C (specification)` — the protocol above is canonical and stable.

The protocol becomes `EV` when:

1. The kernel `morph_eval_reduced.metal v0.1` is implemented.
2. The procedure runs end-to-end on the M2 Pro 16 GB rig.
3. The run log is committed to this directory.

Until then, this is a *target* — the most concrete target in the repo.
