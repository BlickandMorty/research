---
state: P (target only — kernel not implemented)
last-verified: 2026-05-09
---

# `morph_eval_reduced.metal v0.1` — Kernel Spec

> *The single Metal kernel that evaluates expressions in the EML grammar `S → 1 | eml(S, S)` to within 2 ULP fp16 of the reference oracle.*

**Status: P (provisional, target only).** The kernel is *specified* below. It is not implemented in this repo, and the falsifier ([`../06-f-ulp-oracle/`](../06-f-ulp-oracle/)) has not been run on a published artifact. The contract is public so that, when the kernel lands, the falsifier protocol is already named and the verification surface is unchanged.

---

## Contract

The kernel must:

1. **Evaluate any sentence `s ∈ S` of bounded depth on M2 Pro 16 GB.** Bound: ≤ 90 s wall-clock for the F-ULP-Oracle's 412 K log-sampled point set.
2. **Agree with `oxieml::EmlTree::eval_real` to 2 ULP fp16** inside the canonical input window `[0.5, 2.0]`.
3. **Report all clamping events** (any `y < y_min` clamping in the underlying `ln` evaluation) to the audit log.
4. **Produce a deterministic output** for a given seed and input — no nondeterministic ordering of operations across runs.

---

## Why it is target-only

The honest answer: the `oxieml` and `eml-lean` upstream dependencies have not been vendored end-to-end, and no Metal kernel has been written and bit-exact-checked against the reference oracle. The contract is the work product *that must be true* once the kernel lands; calling it EV before that would be an overclaim.

When the kernel is implemented:

1. Run F-ULP-Oracle ([`../06-f-ulp-oracle/`](../06-f-ulp-oracle/)).
2. Commit the run log to this directory.
3. Update the status frontmatter from `P` to `EV`.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker constructs an input outside the `[0.5, 2.0]` canonical window where the kernel produces a result that disagrees with `oxieml::EmlTree::eval_real` by more than 2 ULP. The attacker claims the kernel is broken. **Defense:** the contract is stated *inside* the canonical window. Behaviour outside is documented as a separate open question (extending the canonical window). A failure outside the window is not a contract violation; it is the boundary at which the contract is silent.

> **Adversarial attack (subtler):** an attacker exploits a kernel implementation that uses a different `exp` or `ln` than the reference oracle, producing systematic disagreement at the 1-ULP level that compounds across deep grammar expressions. **Defense:** the contract is *2 ULP at the operator level*; depth-of-grammar amplification is bounded by the oracle protocol's repeat structure. If the compounding pushes the result outside 2 ULP at a fixed depth, the falsifier fails — that is the right answer.

---

## File structure (when kernel lands)

```
05-morph-eval-reduced/
├── README.md                 ← this file
├── kernel-spec.md            ← detailed kernel-level spec (when authored)
├── morph_eval_reduced.metal  ← the kernel itself (target)
├── runlog/                   ← F-ULP-Oracle run logs, dated
└── precision-bounds.md       ← detailed precision analysis (when authored)
```

Until the kernel lands, only this README exists. Adding artifacts requires updating the status from `P` to `EV` (or `EB` for partial verification).

---

## Open questions

- Extending the canonical window beyond `[0.5, 2.0]` — at what cost to the precision bound?
- Whether a CPU-canonical reference implementation should ship alongside the Metal kernel for cross-validation. Pattern-matching to HELIOS V6.2's `InterruptScore` (Swift CPU canonical) suggests yes.
- Whether the `morph_eval_reduced` naming should be promoted to a stable kernel name once V0.1 is verified, or remain at `v0.1` as a research artifact.
