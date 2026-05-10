---
state: C
lane: L1 (MAS-add)
last-verified: 2026-05-09
---

# ACS — In the Episodic Plane

> *The Audit Claim Substrate is not a sidecar. It lives in the Episodic plane of the five-plane formalism, audited from the Verification plane, by design.*

A short structural claim that makes the rest of the audit story coherent. ACS is *where claims that the runtime makes about its own behaviour are stored*; the Episodic plane is *where the runtime's append-only history of inputs and outputs lives*. Putting ACS in the Episodic plane makes both subjects of the same audit boundary.

---

## Statement

In the five-plane formalism (see [`../04-five-plane-formalism/`](../04-five-plane-formalism/)):

- ACS records live in the **Episodic plane**.
- ACS records are audited by the **Verification plane**.
- ACS records are *never* written from the State plane (which would let runtime state corrupt the audit history).
- ACS records are *never* read by the Assembly plane (which would let token-level computation depend on its own audit log — a source of self-referential failure modes).

The implementation lives at `epistemos-research/src/acs.rs` (private Epistemos repo). The placement is verified by canonical-consistency tests.

---

## Why this placement matters

The wrong placement is "ACS as a separate sidecar." That makes the audit substrate something the runtime *opts into* and *opts out of*. The right placement is "ACS as a co-located plane resident." That makes the audit substrate something the runtime *cannot bypass* — to skip an ACS write, you'd have to skip writing to the Episodic plane, which would skip the input/output append. In practice, the runtime can't emit without writing to Episodic; therefore it can't emit without writing to ACS.

This is the structural version of "honesty-by-construction" — the audit is in the same plane as the conversation, not in a parallel observability layer.

---

## What ACS records

(Brief — the full `ClaimKind` enum is in the runtime crate. This is the public summary.)

| ClaimKind | Records | Audit role |
|---|---|---|
| `StaticFallbackAcknowledged` | The runtime fell back to a static path | Required when `attention_mode = StaticFallback`; absence fails source-lint |
| `ToolUseDeclared` | The runtime invoked a tool | Tool calls cross the Verification boundary; declaration is required |
| `MemoryWrite` | The runtime wrote to long-term memory | Writes outside the active turn cross a stronger audit boundary |
| `RefusalEmitted` | The runtime declined to act | Refusal is a positive claim, not a silent absence |
| (others) | various | each with a documented audit role |

The full enum's stability is part of the canonical-consistency suite — adding or removing a variant requires the audit gate updates.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker constructs a runtime path that emits without writing to the Episodic plane (e.g., by short-circuiting through a fast path that skips the audit write). **Defense:** the source-lint contract requires every emission path to terminate at an Episodic-plane append. A path that skips Episodic is rejected at compile time. An attacker who patches around the source-lint is operating outside the runtime's discipline; the runtime makes no claims about that adversary, and the audit log records the *runtime's* behaviour — not a malicious replacement of the runtime.

> **Adversarial attack (subtler):** an attacker corrupts an ACS record after it is written, claiming the audit log is unreliable. **Defense:** the Episodic plane is append-only with hash-chained entries; tampering breaks the chain. The audit log records *integrity violations* as their own ACS records, so an attacker who corrupts the log produces an audit trail of the corruption — not a clean log.

---

## Lane and downstream impact

- **Lane:** L1 (MAS-add). ACS ships in the bounded App Store build. Without it, `StaticFallbackAcknowledged` has nothing to record into.
- **Downstream:** ACS is the *target* of the source-lint contract from [`../03-honesty-by-construction/`](../03-honesty-by-construction/). Without ACS, the contract has no surface to enforce against.

This is what "structural" means in this work: the placement of ACS in the Episodic plane is not a deployment detail. It is what makes the rest of the audit story coherent.
