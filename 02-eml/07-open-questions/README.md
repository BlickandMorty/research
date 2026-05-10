---
state: open
last-verified: 2026-05-09
---

# Open Questions

> *What remains genuinely open in EML, written down so it does not get hidden behind enthusiasm.*

This file is part of the discipline. **A research program with no open questions is dead or dishonest.** EML has both a clear thesis and a real frontier. The frontier is here.

---

## Constant-free universal-EML generation

> *Is there a grammar `S → eml(S, S)` (no terminal `1`) whose function-evaluations are still dense on compact `K`?*

**Status:** open.

**Why it is hard:** without a terminal, the recursion has no base case at the type level. To make the grammar produce closed expressions, you have to either (a) introduce some other base case, or (b) define `S` co-inductively. Both options have technical baggage.

**Why it matters:** if a constant-free grammar is dense, EML's claim becomes "elementary computation reduces to the operator alone." Currently the claim is "elementary computation reduces to the operator plus the terminal `1`."

**What would close it:** a precise statement of a constant-free variant, plus either a density proof or a counter-example showing density fails. Either is a research output.

---

## Depth-vs-error trade-off

> *For a continuous `f : K → ℝ` and a target precision ε > 0, what is the minimum depth of a sentence `s ∈ S` whose function-evaluation ε-approximates `f`?*

**Status:** open. The Stone-Weierstrass density argument gives the *existence* of such an `s` but does not bound the depth.

**Why it matters:** EML's claim that the kernel reframing is *practical* depends on the typical depth being manageable for typical numerical workloads. If the depth is unbounded for common functions, the reframing remains theoretically sound but practically expensive.

**What would close it:** an empirical study of the depth distribution for a representative set of elementary scientific computations (the operations a calculator can do), evaluated with a depth-budgeted search over `S`.

---

## Monnerot `eml*` formulation as citable canon

> *Is the Monnerot `eml*` formulation an independent foundation, or a restatement of the standard `eml` operator?*

**Status:** demoted (DROP) at the V6.1 Foundation Intake. Recorded here for forensic completeness.

**Why it is demoted:** the Monnerot variant was cited in earlier internal drafts as if it were a separate foundation. Independent verification was not completed; the V6.1 Foundation Intake demoted it to "not citable canon until independently verified."

**What would close it:** independent verification of the Monnerot variant against the operator definition in [`../01-operator/`](../01-operator/), with a clear statement of whether they are equivalent or independent.

---

## Single-2-cell ZX/ZH Sheffer stroke

> *Is there a single-2-cell ZX/ZH Sheffer-stroke construction that is universal in the categorical sense, and how does it relate to the EML grammar?*

**Status:** demoted from a commitment at the V6.1 Foundation Intake. The relationship to EML was speculative and is not currently load-bearing.

**Why it is demoted:** the ZX/ZH categorical construction is interesting, but its connection to the EML grammar was asserted before the connection was proven. The discipline of the repo demands the connection be proven before it is claimed.

---

## Single-generator Clifford universality

> *Is there a single generator that produces the Clifford group, and is it related to the EML grammar?*

**Status:** demoted from a commitment.

**Why:** same as the ZX/ZH question — the connection was asserted, not proven.

---

## Extending the canonical window beyond `[0.5, 2.0]`

> *Can the F-ULP-Oracle's 2 ULP fp16 tolerance be maintained outside the `[0.5, 2.0]` canonical window, and at what cost?*

**Status:** open. Recorded in [`../05-morph-eval-reduced/README.md`](../05-morph-eval-reduced/README.md) as well; mirrored here for completeness.

**Why it matters:** the canonical window is small. Extending it would broaden EML's practical reach without changing the falsifier shape.

**What would close it:** a kernel implementation that extends the window, plus an updated F-ULP-Oracle run that demonstrates the precision bound holds in the extended window.

---

## What is *not* open

For symmetry, the following are *not* open — they are settled:

- The operator definition `eml(x, y) = exp(x) − ln(y)`. **Settled.** This is the canonical definition; the earlier `+ 1` comment is removed per V6.1 Foundation Intake.
- The grammar `S → 1 | eml(S, S)` with terminal `1` required. **Settled.**
- Stone-Weierstrass density of the grammar (with the terminal). **Settled** — standard application of a standard theorem.
- The F-ULP-Oracle protocol. **Settled** — the protocol is fixed; only its execution remains.

The discipline is to keep this distinction clean. What is open is open; what is settled is settled.
