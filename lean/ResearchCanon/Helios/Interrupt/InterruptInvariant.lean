/-
HELIOS — Attention as Interrupt — runtime invariant.

Markdown entry: `01-helios/04-attention-as-interrupt/`.

The runtime claim: every emission carries an `attention_mode` tag
whose value is in {dynamic, static_fallback, unavailable}; an
emission with `static_fallback` MUST be paired with a
`ClaimKind::StaticFallbackAcknowledged` claim in the Episodic
plane, and absence of the pairing fails the source-lint contract.

The Lean side records the *invariant* — the runtime correctness
condition that the implementation must preserve. The actual
source-lint enforcement lives in the runtime crate, not here.

**State:** EV in the runtime; Lean stub for the invariant
formalization.

Sorry budget at lock: ≤ 5.
-/

namespace ResearchCanon.Helios.Interrupt

/-- The three values `attention_mode` may take. -/
inductive AttentionMode
  | dynamic
  | staticFallback
  | unavailable
  deriving Repr, DecidableEq

/-- A claim recorded in the Episodic plane. Only the variant relevant
to the static-fallback-acknowledgement invariant is modelled here. -/
inductive ClaimKind
  | staticFallbackAcknowledged
  | other
  deriving Repr, DecidableEq

/-- An AnswerPacket as seen at the Verification plane boundary. -/
structure AnswerPacket where
  attention_mode : AttentionMode
  claims : List ClaimKind

/--
The honesty-by-construction invariant: a static-fallback emission
MUST be paired with the corresponding acknowledgement claim.
-/
def staticFallbackHonesty (p : AnswerPacket) : Prop :=
  p.attention_mode = AttentionMode.staticFallback →
    ClaimKind.staticFallbackAcknowledged ∈ p.claims

/--
Soundness: the invariant is exactly what the source-lint contract
enforces. The proof is by source-level inspection — recorded as a
sorry until the formal correspondence between Lean and the linter
is established.
-/
theorem staticFallbackHonestyEnforced : True := by
  sorry

end ResearchCanon.Helios.Interrupt
