---
state: P (Provisional, Candidate)
lane: L5 (Vault)
sorry-budget: ≤ 7
last-verified: 2026-05-09
---

# T28 — Interpretability-to-Runtime Transfer

> *A faithful (in the SPD sense) parameter decomposition can be transferred to runtime as an active-rank-one execution path with bounded perplexity drift δ ≤ ε.*

The lift theorem. Says that the same decomposition that gives interpretability gives a runtime path with a *named* drift bound — bridging interpretability research and inference engineering.

---

## Statement

Let `M` be a model with an SPD-faithful parameter decomposition `M ≅ ⊕_i C_i`. Let `R` be the runtime obtained by executing only the active rank-one subcomponents at each step, with the active set determined by a pre-activation threshold predicate. Then there exists a bound `ε` (depending on the SPD reconstruction precision and the threshold) such that for any prompt distribution `D`:

```
E_{x ~ D} | PPL_R(x) − PPL_M(x) | ≤ ε
```

The faithfulness hypothesis is made precise per Bushnaq-Braun-Sharkey arXiv:2506.20790: the decomposition reconstructs the original parameter tensor up to a stated MSE budget, on a stated input distribution.

---

## Why this is the lift

Most interpretability research stops at *understanding*: "we identified the components." T28 says: *if* the components are SPD-faithful, *then* you can run the model with only a sparse subset active per step, and the perplexity drift is bounded. The transfer from "interpretation" to "execution" is the lift.

If the lift holds, two things follow:

1. **Compute savings are predictable, not heuristic.** The runtime cost reduces by the active-set fraction, with the perplexity penalty bounded by `ε`.
2. **Component-edit safety bounds (T29) inherit a runtime meaning.** T29 talks about edits to a model; T28 lets you talk about edits to a *runtime* with the same bound shape.

---

## Falsifier protocol

**Hardware:** M2 Pro 16 GB.

**Procedure:**

1. Take a model with an SPD decomposition (Goodfire VPD atlas-grade or equivalent).
2. Implement the active-rank-one runtime path against a held-out evaluation set.
3. Measure end-to-end PPL drift on a Lambada subset (or equivalent).

**Pass criterion:** PPL drift `≤ 0.5` on Lambada subset versus the reference run.

**Status:** P. Not yet run on the M2 Pro 16 GB rig.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker constructs an input distribution `D'` that activates components missing from the active set at a much higher rate than the canonical distribution `D`. The bound is stated in expectation; tail behaviour can be much worse. **Defense:** the bound is *stated as expectation*, not worst-case. Downstream tooling that depends on T28 must declare the input distribution it is bounding against. A T28-derived runtime that ships without naming its assumed distribution is invalid by the discipline of [`../../STATUS_LEGEND.md`](../../STATUS_LEGEND.md).

> **Adversarial attack (subtler):** an attacker exploits the gap between SPD-faithfulness on the *training* distribution and SPD-faithfulness on the *deployment* distribution. **Defense:** SPD faithfulness is itself parameterized by the input distribution; the lift from interpretability to runtime carries the same parameter forward. The honest statement of T28 names which distribution `D` it assumes faithfulness on.

---

## Literature collision

- **Bushnaq-Braun-Sharkey arXiv:2506.20790 (SPD)** — provides the faithfulness statement T28 lifts.
- **Braun et al. arXiv:2501.14926 (APD)** — the attribution-based variant; T28 phrases the bound in a way that accepts either decomposition.
- **Goodfire VPD atlas research** — the empirical artifact most likely to instantiate the SPD-faithful decomposition T28 needs.
- **Modern Hopfield retrieval bound** (Ramsauer 2020) — adjacent: bounds retrieval error in associative memory; T28 bounds runtime perplexity drift, a related but distinct quantity.

---

## Open questions

- The constant in front of the `ε` bound is architecture-dependent. The current statement absorbs it into `ε`; a sharper version would name it explicitly.
- The relationship between T28's expectation bound and T29's per-prompt operator-norm bound is mechanically clear but not formally connected. A bridge lemma is in the speculative folder.
- Whether the active-rank-one execution path interacts safely with the `InterruptScore` interrupt-routed attention pathway (see [`../04-attention-as-interrupt/`](../04-attention-as-interrupt/)) is an open invariant.

---

## Lane and downstream impact

- **Lane:** L5 (Vault). The active-rank-one runtime is a research-tier invariant; it does not ship in MAS.
- **Downstream:** if T28 holds empirically, an L5 → L2 (Pro-tier) promotion path exists for a future opportunistic kernel upgrade, but only after a long burn-in and a compliance audit.

MAS impact: zero. This is by design.
