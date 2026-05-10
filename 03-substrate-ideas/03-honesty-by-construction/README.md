---
state: EV
lane: L1 (MAS-add)
last-verified: 2026-05-09
---

# Honesty-by-Construction — `StaticFallbackAcknowledged`

> *A static fallback that is not acknowledged is a compile error. Silent fallback is unrepresentable.*

The most concrete instance of "honesty-as-a-compile-error" in the runtime. **Empirically verified** in the source-lint pipeline.

---

## Statement

The runtime contract:

> Any `AnswerPacket` with `attention_mode = StaticFallback` MUST be accompanied by a `ClaimKind::StaticFallbackAcknowledged` claim in the Episodic plane. Emissions that violate this constraint are rejected at the source-lint layer (doctrine linter gate 6.1).

The contract is enforced *at source-lint time*, not at run time. A program that *could* emit a static fallback without acknowledging it does not compile.

---

## Why this is what honesty looks like in code

The natural way to handle static fallback is "log it somewhere, hope someone reads the log later." That treats honesty as observability — a property of the surrounding tooling, not of the runtime itself.

The contract here is structurally different. **Honesty becomes a precondition for compilation.** A runtime that emits without acknowledging fallback does not exist as a compiled artifact. The audit history is a property of the *type system*, not of an external monitoring layer.

This composition with the rest of the substrate matters:

- ACS in the Episodic plane gives the contract a *target* to write into ([`../02-acs-episodic-plane/`](../02-acs-episodic-plane/)).
- Storage-disaggregation (E3) makes the Episodic plane *cheap* enough to default to ([`../01-storage-disaggregated-E3/`](../01-storage-disaggregated-E3/)).
- The five-plane formalism gives the source-lint contract *which boundary* to enforce against ([`../04-five-plane-formalism/`](../04-five-plane-formalism/)).

Without all four pieces, honesty-by-construction is a wish. With them, it is a compile error on a missing claim.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker patches around the source-lint contract by adding a "stub" `StaticFallbackAcknowledged` claim that is never actually a true acknowledgement of fallback. **Defense:** the `StaticFallbackAcknowledged` claim's *content* records *which* static path was taken, against *which* trigger condition, with *which* downstream behaviour. A stub claim that does not match the runtime state at the kernel boundary fails a downstream consistency check; the audit log records *both* the claim and the consistency-check failure.

> **Adversarial attack (subtler):** an attacker forks the runtime, removes the source-lint contract, and ships their fork as an "alternative" runtime. **Defense:** the runtime makes no claims about derivative builds. The contract is for *this* runtime; alternative builds are alternative artifacts, and their honesty (or absence thereof) is their own concern. The repo's discipline does not extend over forks.

---

## Falsifier protocol

**Hardware:** any.

**Procedure:**

1. Construct an emission path in the runtime that *would* produce a static fallback.
2. *Omit* the `StaticFallbackAcknowledged` claim authoring code.
3. Run source-lint.

**Pass criterion:** source-lint *fails* with a clear diagnostic identifying the missing acknowledgement.

**Negative test:** if the omission compiles, the contract is broken.

**Status:** EV. The contract is enforced by doctrine linter gate 6.1 in the private Epistemos source-lint pipeline.

---

## Citation lineage

- **Liskov substitution principle / type-level invariants** (classical OO theory) — adjacent; the contract *uses* type-level invariants but goes further by enforcing them at the source-lint level (which is more strict than runtime enforcement).
- **Refinement types / liquid types** (research literature, Rondon-Kawaguchi-Jhala 2008 et al.) — the same idea at a more general level. The contract here is a project-specific refinement, not a generalized refinement-type system.
- **Effect systems** (Idris, Koka, etc.) — adjacent; effect systems track *what* a function does. The contract here tracks *what claim a function attests to*, which is closer to a witness effect.

---

## Lane and downstream impact

- **Lane:** L1 (MAS-add). The contract ships in the bounded App Store build. The same discipline applies in Pro and Vault streams.
- **Downstream:** any future runtime invariant of the form "emission path X must record claim Y" is a structural extension of this pattern. The first such invariant is the static-fallback case; subsequent invariants follow the same template.

The pattern itself is the durable contribution. The static-fallback instance is the canonical example.
