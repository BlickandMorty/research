---
state: C (canonical, definition)
last-verified: 2026-05-09
---

# The Operator

> `eml(x, y) = exp(x) − ln(y)`

The single binary operator EML is built on. **This is a definition, not a claim.** Its load-bearing role is downstream: in [`../02-grammar/`](../02-grammar/) where it generates a recursive grammar, and in [`../03-density/`](../03-density/) where the grammar is shown dense.

---

## Definition

For real `x` and positive real `y`:

```
eml : ℝ × ℝ_{>0} → ℝ
eml(x, y) = exp(x) − ln(y)
```

The domain restriction `y > 0` is required by `ln`. Practical implementations clamp `y` away from zero and report the clamping in the audit log.

---

## Why this operator

Three reasons, none of which is sufficient on its own:

1. **It mixes the two transcendental scales.** `exp` is the multiplicative-to-additive direction; `ln` is the additive-to-multiplicative direction. A single operator that combines both gives the recursive grammar enough expressive power to land in coordinates, conjugates, and constants — the three Stone-Weierstrass hypotheses.

2. **It has a tight ULP-bounded falsifier.** Both `exp` and `ln` are well-studied transcendentals with established ULP-bounded reference implementations. The `F-ULP-Oracle` builds on these.

3. **It is non-commutative.** `eml(x, y) ≠ eml(y, x)` in general. Non-commutativity is necessary for the grammar's expressive power; a commutative operator over `(ℝ, +)` would not generate the function space.

---

## What this operator is not

- It is not the *only* primitive that has these three properties. Other operators are also dense, falsifiable, and non-commutative. EML's claim is *not* uniqueness.
- It is not a claim about hardware-friendly arithmetic. The operator is mathematically clean; the kernel implementation (`morph_eval_reduced.metal`) is a separate concern.
- It is not unrelated to `add` and `mul` in disguise. `eml` cannot be reduced to a fixed combination of `add` and `mul` because the transcendentals `exp` and `ln` are not algebraic. The grammar's density is *because* of this.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker constructs an input pair where the underlying floating-point implementation of `exp` or `ln` produces a result that violates the ULP bound. **Defense:** the falsifier in [`../06-f-ulp-oracle/`](../06-f-ulp-oracle/) explicitly tests both `exp` and `ln` to their reference oracles before composing them. A failure in the underlying transcendental shows up as a falsifier failure on the simplest grammar form `eml(x, y)`, before any composition is attempted.

> **Adversarial attack (subtler):** an attacker chooses `y` very close to zero, forcing `ln(y)` toward `−∞` and making the operator numerically unstable. **Defense:** the implementation clamps `y ≥ y_min` for a documented `y_min`, and the audit log records every clamp event. A clamping event is *not* a silent fix — it is a recorded boundary case.

---

## Implementation pointers

- Reference oracle: `oxieml::EmlTree::eval_real` (vendored — see [`../04-implementations/`](../04-implementations/)).
- Lean encoding: see [`../../lean/ResearchCanon/Eml/Operator.lean`](../../lean/ResearchCanon/Eml/Operator.lean).
- Metal kernel target: `morph_eval_reduced.metal v0.1` — see [`../05-morph-eval-reduced/`](../05-morph-eval-reduced/).

---

## A note on the comment in source

An earlier internal note had the comment `eml(x, y) = exp(x) − ln(y) + 1`. The `+ 1` is **not** part of the definition. It was a note about a side-construction that has since been removed. Per the V6.1 Foundation Intake, the accepted operator is exactly `exp(x) − ln(y)`.
