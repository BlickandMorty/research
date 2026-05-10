---
state: P (Provisional, Candidate)
lane: L5 (Vault)
sorry-budget: ≤ 7
last-verified: 2026-05-09
lean: ../../lean/ResearchCanon/Helios/Connectome/T29EditSafetyBound.lean
---

# T29 — Component Edit Safety Bound

> *Editing a component subset S of size ≤ s_max bounds downstream perplexity drift on out-of-edit prompts by O(s_max · σ_max(W_edit)).*

The flagship safety theorem of the Parameter Connectome Family. Encodes the intuition that **bounded edits to a sparse, faithful component decomposition must produce bounded behavioural drift on inputs unrelated to the edit**.

---

## Statement

Let `M` be a model with a sparse component decomposition `M = ⊕_i C_i` faithful in the SPD sense (Bushnaq-Braun-Sharkey 2026). Let `S ⊂ {C_i}` be a subset of components with `|S| ≤ s_max`. Let `W_edit` be the parameter-space edit applied to the components in `S`, and let `σ_max(W_edit)` be its largest singular value.

Then for any prompt `x` whose forward pass does *not* meaningfully activate any component in `S`,

```
|PPL_M_edit(x) − PPL_M(x)| ≤ K · s_max · σ_max(W_edit) + o(1)
```

for a constant `K` that depends only on the model architecture and the SPD reconstruction precision, not on the specific edit `W_edit`.

The hypothesis "x does not meaningfully activate any component in S" is made precise by a `pre_activation_threshold(C_i, x) < τ` predicate; the choice of `τ` is itself a parameter of the bound.

---

## Why this is a safety theorem

The natural objection to interpretability-driven safety edits is: *if you edit one component, you cannot prove the rest of the model still works.* T29 names a bound that addresses exactly that objection, in the regime where the decomposition is faithful and the edit is bounded. It does not claim to be unconditionally safe — it claims that the *out-of-edit* behaviour is bounded *as a function of the edit's size and operator norm*.

This is the difference between "we hope the edit doesn't break anything" and "we bound the breakage by `K · s_max · σ_max(W_edit)`."

---

## Falsifier protocol

**Hardware:** M2 Pro 16 GB. (V6.2 retag from M2 Max original.)

**Procedure (Goodfire-style emoticon edit):**

1. Take a 4-layer transformer with a known SPD decomposition.
2. Apply an emoticon-style component edit per Goodfire's published research methodology.
3. Run a held-out evaluation set of out-of-edit prompts (prompts that do not invoke the emoticon-related components).
4. Measure off-distribution PPL drift.

**Pass criterion:** off-distribution PPL drift `≤ 1.0` for the emoticon-edit canonical setup.

**Reference oracle:** Goodfire VPD atlas, https://www.goodfire.ai/research/interpreting-lm-parameters. Atlas table values revalidated 2026-05-07 (total 38912 / alive 9972 / mean L0 205.0 / activity fraction 0.021).

**Run log:** *not yet run on the M2 Pro 16 GB rig — status remains P.*

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker constructs an "edit" `W_edit` with a small `σ_max` but a large total Frobenius norm, hoping to slip catastrophic behavioural change past the operator-norm bound. **Defense:** the bound is stated in operator norm because operator norm is the right one for behavioural drift on out-of-edit prompts — Frobenius would over-penalize edits that act on irrelevant subspaces. The bound is also stated only on *out-of-edit* prompts, where "out-of-edit" is made precise by the pre-activation threshold. Edits that look small in operator norm but act broadly fail the *out-of-edit* hypothesis on most prompts, and the bound does not apply.

> **Adversarial attack (subtler):** an attacker chooses an edit that satisfies `σ_max(W_edit) < ε` but produces meaningful behavioural change *on prompts that are technically out-of-edit* by the threshold predicate. **Defense:** the threshold `τ` is itself a parameter; the bound is parameterized by τ, and downstream tooling that uses the bound must declare the threshold it is bounding against. A bound that hides its threshold is invalid by the discipline of [`../../STATUS_LEGEND.md`](../../STATUS_LEGEND.md).

---

## Lean anchor

The Lean stub lives at [`../../lean/ResearchCanon/Helios/Connectome/T29EditSafetyBound.lean`](../../lean/ResearchCanon/Helios/Connectome/T29EditSafetyBound.lean). The theorem signature is declared with explicit hypotheses on faithfulness, threshold, and operator norm; the `sorry` proof obligation is the bulk of the work.

Sorry-budget ≤ 7. Promotion from P to EV requires either:

- A passing run log on the M2 Pro 16 GB rig, plus a declared (not necessarily zero) sorry-budget reduction, or
- A formal proof closing the bound (sorry → 0) and a passing run that meets the bound.

---

## Literature collision

- **Goodfire's component-editing research** (https://www.goodfire.ai/research/interpreting-lm-parameters) is the canonical empirical study of edits at the component-cluster level. T29 is the *bound* implied by their methodology, not a new methodology.
- **Component-localized model editing** (multiple groups, 2023–2025) — broadly compatible; T29 differs by stating the bound in operator-norm and making the out-of-edit hypothesis explicit.
- **Constitutional AI and RLHF refusal-quality fine-tuning** are *complementary*, not competing — they target different parts of the model and different parts of the failure space.

---

## Lane and downstream impact

- **Lane:** L5 (Vault). The active component-editing pipeline modifies the model file, not a live runtime. MAS impact: zero.
- **Downstream:** when L5 produces an edited model file, that file may ship as a Tier-2 release in a future MAS build, but only after a compliance audit that includes T29's falsifier check.

The lane assignment is itself a safety property: the runtime in the bounded App Store build *cannot* invoke component-level edits, so the MAS attack surface is unchanged whether T29 holds or not. T29's value is downstream — for the alternate model files that the Vault path produces.
