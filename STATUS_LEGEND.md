# Status Legend

Every research entry in this repo carries a status tag in its frontmatter. **Promoting a tag has rules.** This file is the contract.

---

## The five statuses

### `C` — Canonical
A foundational definition or a load-bearing structural claim that the rest of the work assumes. Canonical entries do not require empirical falsification, but they do require:

- A precise statement.
- A named adversarial attack with a defense (or an explicit "this is a definition, not a claim").
- A literature collision check.
- (For mathematical entries) a Lean 4 anchor with a tracked sorry-budget cap.

Canonical does **not** mean "obviously true." It means "if this fails, the substrate is broken." E1–E7 are canonical because the rest of HELIOS rests on them. EML's operator definition is canonical because the entire EML grammar is built on it.

### `EV` — Empirically Verified
The claim has a hardware falsifier protocol, the protocol has been *run*, and it *passed*. Verification is hardware-pinned (M2 Pro 16 GB by default; deviations are noted explicitly).

EV requires:
- A concrete falsifier protocol with numerical thresholds.
- A reference oracle (where applicable).
- A run log with hardware identification, date, and pass/fail.
- The same adversarial-attack-with-defense pair as canonical.

### `EB` — Empirically Bounded
The claim has been verified within stated bounds, and the bounds matter. Use EB rather than EV when:
- The falsifier passed but only on a subset of the canonical input space (e.g., 32 K context not 128 K).
- The verification depends on a parameter (precision, rank, etc.) that may not generalize.
- A weaker version of the claim verified, but the stronger version did not.

EB requires explicit *named* bounds. "Verified at 32 K context, not at 128 K" is a valid EB statement. "Mostly works" is not.

### `P` — Provisional (Candidate)
The claim is designed and the falsifier is specified, but the falsifier has not been run, or it has been run and the result is inconclusive. Provisional claims are real research output — they are how the work moves forward — but they are not load-bearing for downstream conclusions.

P requires:
- A precise statement.
- A specified falsifier protocol with thresholds.
- A literature collision check.
- A named attack and a named defense.
- An explicit reason it is not yet EV (e.g., "no runtime exists yet," "M2 Max benchmark pending").

### `DROP` — Preserved-but-Vault
An idea or claim that was once active and has been demoted: superseded by a better formulation, found to be unfalsifiable as stated, or proven downstream-irrelevant. **DROP does not delete the entry** — it preserves it under [`archive/`](./archive/) with the reason for demotion, so the same idea is not re-invented and re-rejected later.

DROP requires:
- The original statement.
- The reason for demotion.
- (If applicable) the entry that supersedes it.

---

## The Write / Read / Verify (WRV) ladder

Independent of the C/EV/EB/P/DROP tag, every entry that informs a runtime invariant follows a three-stage promotion ladder:

| Stage | Meaning | Artifact required |
|---|---|---|
| **W**rite | The claim is recorded in human-readable form | Markdown entry with statement / falsifier / citations |
| **R**ead | The claim has a machine-readable form that downstream tooling can read without re-parsing prose | Lean stub, runtime invariant, or test-ready specification |
| **V**erify | The claim has been *checked* by something that is not the author | Audit log, CI pass, run log on target hardware |

A claim can be `state: C` at the W stage (canonical-but-unverified) and `state: EV` only after V. Mixing the axes is the point: it forces honesty about *which kind* of incompleteness a given entry has.

---

## Promotion rules

- **W → R** requires a machine-readable form. The Lean substrate is the default; Rust runtime invariants are also accepted.
- **R → V** requires the verification to be reproducible by a third party from the entry alone. "I ran it locally" is not V; "here is the script and the hardware" is.
- **P → EB / EV** requires a passing falsifier run. The run log goes in the entry.
- **EV → EB** is a downgrade and requires explicit named bounds (e.g., "T29 verified for s_max ≤ 8, fails the falsifier above").
- **Anything → DROP** requires a written reason. Quiet deletion is forbidden.

---

## What this is not

This legend is not a marketing tier list. EV is not "better" than C; they describe different kinds of certainty. A canonical-but-unverified definition can be more load-bearing than an empirically-bounded experimental result.

The legend exists because the alternative — pretending all entries are equally certain — is exactly the failure mode this work is designed to refuse.

---

*Last reviewed: 2026-05-09.*
