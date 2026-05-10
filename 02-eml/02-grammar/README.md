---
state: C (canonical, definition)
last-verified: 2026-05-09
---

# The Grammar

> `S → 1 | eml(S, S)`

A two-rule recursive grammar over the operator from [`../01-operator/`](../01-operator/). Every elementary expression is either the constant `1` or an application of `eml` to two sub-expressions, each itself in `S`.

---

## Definition

```
S ::= 1
    | eml(S, S)
```

Reading: a sentence in `S` is either the literal `1` or an application of `eml` whose two arguments are themselves sentences in `S`.

The terminal `1` is **required**. A grammar without a terminal symbol generates no closed expressions; the recursion has no base case.

---

## Why the terminal `1` is required

The Stone-Weierstrass density argument requires *constants* in the function space being approximated. The grammar `S → eml(S, S)` without a terminal generates only open expressions and cannot represent any function. Adding `1` gives the grammar:

- A base case (so the recursion terminates).
- A constant function (so Stone-Weierstrass's "constants" hypothesis holds).
- A starting value for any compositional expression.

The constant-free universal-EML question — *is there a grammar with no terminal that is still dense?* — is **open** and is recorded in [`../07-open-questions/`](../07-open-questions/).

---

## What this grammar generates

Some examples of expressions in `S`:

| Expression | Reading | Numerical value (where applicable) |
|---|---|---|
| `1` | constant 1 | `1` |
| `eml(1, 1)` | `exp(1) − ln(1)` | `e − 0 = e ≈ 2.71828` |
| `eml(1, eml(1, 1))` | `exp(1) − ln(e)` | `e − 1 ≈ 1.71828` |
| `eml(eml(1, 1), 1)` | `exp(e) − ln(1)` | `e^e − 0 ≈ 15.1543` |
| `eml(eml(1, 1), eml(1, 1))` | `exp(e) − ln(e)` | `e^e − 1 ≈ 14.1543` |

The expressive power compounds quickly. By depth 3 or 4 the grammar generates a wide range of numerical values; by the Stone-Weierstrass argument in [`../03-density/`](../03-density/), arbitrary continuous functions over compact `K` can be ε-approximated by some sentence in `S`.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker observes that the grammar in isolation cannot directly represent the additive identity `0`, since `0` is not in the trivial-depth set and would require a deep recursive expression to approximate. The attacker claims the grammar is *too coarse* to be useful. **Defense:** the grammar's role is *generative*, not direct. It is dense in the continuous functions over compact `K`; arbitrary numerical values appear as the grammar deepens. "Cannot represent `0` at depth 0" is correct and not a problem; "cannot ε-approximate any continuous function" would be a problem, and is what the density argument refutes.

> **Adversarial attack (subtler):** an attacker constructs a continuous function on `K` that requires extremely deep grammar expressions to approximate. The attacker claims this makes the grammar impractical. **Defense:** the grammar's *theoretical* density does not bound the depth required for a given ε. The depth-vs-error trade-off is a separate question. Practical implementations will need to evaluate this trade-off empirically — that work is recorded in [`../07-open-questions/`](../07-open-questions/).

---

## Implementation pointers

- Reference oracle: `oxieml::EmlTree` (the data type that represents a parsed grammar expression).
- Lean encoding: see [`../../lean/ResearchCanon/Eml/Grammar.lean`](../../lean/ResearchCanon/Eml/Grammar.lean) for the inductive type and recursion principle.

---

## What this grammar is not

- It is not a programming language. It is a recursive function-construction grammar.
- It is not a claim about *parsing* arbitrary numerical expressions. The grammar generates a function space; it does not provide an algorithm to parse arbitrary input expressions into `S`.
- It is not closed under inverse operations. `eml` is non-commutative and has no general inverse in `S`. That is fine — Stone-Weierstrass does not require an algebra structure, only an algebra of functions in the analytic sense.
