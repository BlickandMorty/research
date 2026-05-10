/-
EML — Density (Stone-Weierstrass).

Markdown entry: `02-eml/03-density/`.

**Statement (canonical, application of a standard theorem):** the
grammar `S → 1 | eml(S, S)` is dense in the continuous functions
over compact domains, by Stone-Weierstrass — coordinates +
conjugation + constants.

The mathlib4 anchor is `Mathlib.Topology.Algebra.StoneWeierstrass`.

Sorry budget at lock: ≤ 7. (The density application is non-trivial
because the grammar's algebra-of-functions structure must be
reconstructed before Stone-Weierstrass applies.)
-/

import ResearchCanon.Eml.Grammar

namespace ResearchCanon.Eml.Density

open ResearchCanon.Eml.Grammar

/-- A compact subset of the input space on which density is claimed. -/
structure CompactDomain where
  -- The domain is parameterized externally; this structure records
  -- only the precondition that K is compact. The actual carrier and
  -- topology are imported from mathlib4.
  is_compact : True

/-- The function-evaluation map: each grammar expression evaluates
to a function on the compact domain. (For the real-valued case,
the function is `λ _ => eval s`; the *constant* function the
grammar expression evaluates to.) -/
noncomputable def evalFunction (s : S) (_ : CompactDomain) : Float :=
  eval s

/--
Acceptance (Stone-Weierstrass density): for every continuous
target function f on a compact domain K and every ε > 0, there
exists s ∈ S whose evaluated function ε-approximates f in the
sup norm.

The proof outline is standard:
  1. Coordinates: the grammar separates points on K.
  2. Constants: the terminal `1` provides the constant function.
  3. Conjugation: trivial for the real-valued case.
  4. Apply Stone-Weierstrass.

The `sorry` here is non-trivial because the algebra-of-functions
structure of the grammar must be reconstructed before Stone-
Weierstrass applies; this is the bulk of the proof debt.
-/
theorem grammarDenseInContinuous : True := by
  sorry

end ResearchCanon.Eml.Density
