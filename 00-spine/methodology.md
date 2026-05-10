# Methodology

> *How research entries are written, promoted, and demoted in this repo.*

---

## Falsifier-first

A research claim that cannot be disproved is not a research claim. Every entry begins with the falsifier:

- What hardware?
- What inputs?
- What thresholds?
- What reference oracle?
- What is the pass criterion?

Default target hardware: M2 Pro 16 GB. Deviations are explicit. (The original HELIOS work was specified against M2 Max; V6.2 retags to M2 Pro 16 GB as the shippability lock and treats M2 Max as scale-validation only.)

The falsifier is *not* "I tried it and it seemed to work." The falsifier is a protocol someone else can run. If they cannot, the claim is `state: P` (provisional) at best.

---

## Attack with defense

Every claim ships with a paired adversarial attack and named defense:

> **Adversarial attack:** *concrete way to break the claim — input distribution, parameter regime, or worst-case construction.* **Defense:** *concrete mitigation — bound check, type-level restriction, runtime invariant, or sample-time guard.*

A claim with no attack is incomplete. A claim with no defense is dropped.

This is the same posture I apply at Mercor: every claimed weakness paired with a reproducible falsifier and a named mitigation. The repo holds my own work to the same bar.

---

## The Write / Read / Verify (WRV) ladder

| Stage | Form | Audit |
|---|---|---|
| **W**rite | Markdown entry with statement, falsifier, citations | Self-review against the five rules |
| **R**ead | Lean stub or runtime invariant — machine-readable form | The form is *valid syntax* and the statement matches the markdown |
| **V**erify | Falsifier run on hardware, log committed | Reproducible by a third party from the entry alone |

A claim's *status* (C / EV / EB / P / DROP) and a claim's *stage* (W / R / V) are independent axes. Mixing them deliberately is the point: it forces honesty about *which kind* of incompleteness an entry has.

---

## Literature collision check

Every entry checks the literature before claiming novelty:

- A search for prior art with the named keywords.
- A check of the closest hits' arXiv IDs and conference names.
- A short paragraph in the entry: "Closest literature: …; this work differs because …".

If the collision check finds a hit that *makes the claim*, the entry is reframed as a verification or extension, not a new claim. If the collision check finds a hit that *contradicts* the claim, the contradiction is recorded and the entry is demoted until the contradiction is resolved.

---

## Sorry-budget discipline

Lean entries declare a sorry-budget cap in the file frontmatter:

```yaml
sorry-budget: ≤ 7 (current: 5)
```

Promoting an entry from P to EV requires one of:

- The current sorry count drops to zero, or
- A documented reduction plan exists with target dates and partial proofs in flight.

The published budget is itself a research artifact. It is more honest to say "37 tracked sorries" than "we are mostly done" without numbers.

---

## What gets demoted

An entry moves to `archive/` (DROP) when one or more of:

1. The falsifier *was run* and *failed*, and no fix path is in flight.
2. A literature collision *makes the claim* and reduces the entry to a restatement.
3. A successor entry supersedes it.
4. The author can no longer state the claim precisely.

Quiet deletion is forbidden. The reason for demotion is recorded so the same idea is not re-invented and re-rejected later.

---

## What does not count as research output

- "Interesting prose."
- "I asked an LLM and it agreed with me."
- "Other people have not written about this."
- "The math looks right."
- "It compiles."

These can be *steps toward* an entry, but none of them is sufficient on its own. The entry needs the falsifier, the attack-with-defense, the literature collision, and the citation tags before it stops being a draft.

---

## What this methodology is for

Two things:

1. **Self-discipline.** The methodology is the structure that prevents the work from drifting into AI-augmented prose unmoored from proof.
2. **External verifiability.** Anyone reading the repo can tell, at a glance, what is canonical, what is empirically verified, what is provisional, and what is speculative — and check the falsifier themselves.

Both reasons matter. The first protects the work; the second protects the reader.
