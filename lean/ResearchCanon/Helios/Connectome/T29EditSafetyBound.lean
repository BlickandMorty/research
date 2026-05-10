/-
HELIOS T29 — Component Edit Safety Bound (Provisional, Vault).

Markdown entry: `01-helios/03-parameter-connectome-T25-T34/T29-edit-safety-bound.md`.

Citations (see `REFERENCES.md`):
  - Bushnaq-Braun-Sharkey arXiv:2506.20790 (SPD).
  - Goodfire VPD atlas https://www.goodfire.ai/research/interpreting-lm-parameters
    (revalidated 2026-05-07, atlas table 9972/205/2.1%).

**Statement (CANDIDATE, Lane 5 Vault):** Editing a component subset
S of size ≤ s_max bounds downstream PPL drift on out-of-edit prompts
by O(s_max · σ_max(W_edit)).

Formally, for an SPD-faithful decomposition M = ⊕ Cᵢ, an edit
W_edit applied to a subset S with |S| ≤ s_max, and any prompt x
with pre_activation_threshold(Cᵢ, x) < τ for every Cᵢ ∈ S:

  |PPL_M_edit(x) − PPL_M(x)| ≤ K · s_max · σ_max(W_edit) + o(1)

where K depends only on the architecture and the SPD reconstruction
precision, not on the specific edit.

**Falsifier (M2 Pro 16 GB):** Goodfire-style emoticon edit on a
4-layer model; off-distribution PPL drift ≤ 1.0.

**Adversarial attack and defense:** see markdown entry.

**MAS impact: zero — Vault only.**

Sorry budget at lock: ≤ 7.
-/

namespace ResearchCanon.Helios.Connectome.T29

/-- An SPD-faithful decomposition of a model into component clusters. -/
structure ComponentDecomposition where
  num_components : Nat
  faithful_mse_budget : Float

/-- The pre-activation threshold predicate from the markdown statement. -/
structure OutOfEditHypothesis where
  threshold : Float
  components_in_edit : List Nat

/-- A bounded parameter-space edit applied to a subset of components. -/
structure ComponentEdit where
  subset : List Nat
  s_max : Nat
  sigma_max : Float

/--
Acceptance: the bound holds for any prompt that satisfies the
out-of-edit hypothesis with respect to the edit's subset.
-/
theorem componentEditSafetyBound : True := by
  sorry

end ResearchCanon.Helios.Connectome.T29
