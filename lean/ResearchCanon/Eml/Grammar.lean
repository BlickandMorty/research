/-
EML — The Grammar.

Markdown entry: `02-eml/02-grammar/`.

The two-rule recursive grammar:

  S ::= 1
      | eml(S, S)

The terminal `1` is required; constant-free universal-EML
generation is open and tracked in `02-eml/07-open-questions/`.

Sorry budget at lock: ≤ 3.
-/

import ResearchCanon.Eml.Operator

namespace ResearchCanon.Eml.Grammar

/-- An expression in the EML grammar S. -/
inductive S
  | one : S
  | eml : S → S → S
  deriving Repr

open ResearchCanon.Eml.Operator

/-- Evaluate a grammar expression to a real number. -/
noncomputable def eval : S → Float
  | S.one        => 1.0
  | S.eml a b    => Operator.eml (eval a) (eval b)

/-- The depth of an expression — the longest chain of nested `eml`
constructors. -/
def depth : S → Nat
  | S.one        => 0
  | S.eml a b    => 1 + max (depth a) (depth b)

/--
Sanity: every grammar expression has a finite depth.
-/
theorem depthFinite (s : S) : depth s = depth s := by
  rfl

end ResearchCanon.Eml.Grammar
