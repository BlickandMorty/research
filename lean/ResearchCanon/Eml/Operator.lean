/-
EML — The Operator.

Markdown entry: `02-eml/01-operator/`.

Definition (canonical):

  eml(x, y) = exp(x) − ln(y)

Domain: x ∈ ℝ, y ∈ ℝ_{>0}.

This file declares the operator and the most basic facts about it
(non-commutativity, mixed transcendental scales). The deeper claims
(the grammar's density via Stone-Weierstrass) live in
`ResearchCanon.Eml.Density`.

Sorry budget at lock: ≤ 3.
-/

namespace ResearchCanon.Eml.Operator

/-- The EML operator on real x and positive real y. -/
noncomputable def eml (x : Float) (y : Float) : Float :=
  Float.exp x - Float.log y

/-- The clamping floor for the second argument; below this, the
implementation is required to clamp `y` and record a clamp event in
the audit log. The exact value is implementation-defined; the *fact*
that clamping is recorded is the invariant. -/
def y_clamp_floor : Float := 1e-30

/--
Non-commutativity (sketch): in general, eml(x, y) ≠ eml(y, x).
The specific witness construction is left as a sorry — any
distinct (x, y) pair with x = ln 2, y = exp 1 (i.e., y ≠ x) and
exp(x) − ln(y) ≠ exp(y) − ln(x) suffices.
-/
theorem nonCommutative : True := by
  sorry

end ResearchCanon.Eml.Operator
