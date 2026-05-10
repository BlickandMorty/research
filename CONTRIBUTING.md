# Contributing — Discipline Rules

This is a single-author research notebook, but the discipline rules apply to me as much as to anyone else. **The rules exist because the alternative — overclaiming — is the failure mode this body of work is designed to refuse.**

If you fork this and want to ship a derivative, the same rules apply.

---

## The five rules (mandatory)

### Rule 1 — Every claim has a status tag
No theorem, kernel, protocol, or runtime invariant lands without a frontmatter `state:` tag. The five values are defined in [`STATUS_LEGEND.md`](./STATUS_LEGEND.md).

```yaml
---
state: P
sorry-budget: ≤ 7 (current: 5)
falsifier: see ./protocol.md
last-verified: 2026-05-09
---
```

A claim without a status tag is treated as `speculative` and moved to [`speculative/`](./speculative/).

### Rule 2 — Every claim has a falsifier or it is not a claim
The falsifier is a *named protocol* with numerical thresholds, target hardware, and a reference oracle (where applicable). "It seems to work" is not a falsifier.

If the falsifier has not been run yet, the entry is `state: P`. If it has been run and passed, `state: EV`. If it passed within stated bounds, `state: EB`.

### Rule 3 — Every claim has a paired adversarial attack and named defense
The format is:

> **Adversarial attack:** *concrete way to break the claim*. **Defense:** *concrete mitigation*.

A claim with no attack is incomplete. A claim with no defense is dropped.

### Rule 4 — Every citation has a verification date
See [`REFERENCES.md`](./REFERENCES.md). When citing in an entry, use the short tag (e.g., `Bushnaq-Braun-Sharkey 2026`) and link back. Add the citation to `REFERENCES.md` *before* using it in an entry.

### Rule 5 — Sorry-budget is published
If your entry has a Lean anchor, the file's sorry-budget is declared in the entry frontmatter and tracked. Promoting `P → EV` requires the budget to be either zero or to have a documented reduction plan.

---

## Promotion checklist

When promoting an entry from one status to another, work through this checklist:

### W → R (markdown → machine-readable)
- [ ] A `.lean` stub exists with the theorem statement and a `sorry`.
- [ ] If runtime-relevant, a Rust property test or trait signature exists.
- [ ] The frontmatter's `last-verified` is updated.

### R → V (machine-readable → verified)
- [ ] Falsifier protocol is fully specified (hardware, thresholds, oracle).
- [ ] Run log added to the entry: hardware ID, date, command, output, pass/fail.
- [ ] Reproducibility check: someone else can re-run it from the entry alone.

### P → EB / EV
- [ ] Falsifier ran successfully.
- [ ] Run log linked from the entry.
- [ ] If EB, the bounds are *named* in the entry title or first paragraph.
- [ ] `state:` tag updated.

### Anything → DROP
- [ ] The entry is moved to [`archive/`](./archive/).
- [ ] The reason for demotion is documented.
- [ ] If a successor entry exists, link to it.

---

## What lives where

### `00-spine/`
Cross-cutting docs: thesis, methodology, anything that informs *how* the rest is structured. Adding a doc here changes the rules for everything downstream — propose carefully.

### `01-helios/`, `02-eml/`, `03-substrate-ideas/`
The three pillars. Each has its own README that defines what belongs there. New entries go under the pillar that matches their thesis. If an idea cuts across, it goes in the spine, not in two pillars.

### `lean/`
The Lean substrate. Every theorem stub has a corresponding markdown entry; markdown is the human-readable face, Lean is the machine-readable face. They must agree on the statement.

### `falsifiers/`
Cross-pillar falsifier infrastructure (the M2 Pro 16 GB rig spec, harness scripts, etc.). Per-entry falsifier protocols live with their entry, not here.

### `speculative/`
Ideas that are not yet ready to claim. Entries here are explicitly walled off and **must** carry a top-of-file disclaimer. Promotion out of `speculative/` requires the full status / falsifier / attack-defense / citation discipline above.

### `archive/`
DROP'd entries. Never deleted, only demoted with a reason.

---

## Style

- Markdown frontmatter for status / sorry-budget / dates.
- Inline `code` for identifiers, file paths, hardware specs.
- Block quotes for theorem statements.
- Footnotes for tangents.
- One thesis per entry. If an entry has two theses, split it.
- Plain prose, not marketing copy. The reader is a working researcher, not a buyer.
- No exclamation marks in technical claims.

---

## What does *not* belong in this repo

- Private Epistemos product code.
- Anything covered by a Mercor (or other employer) NDA.
- Model weights, datasets, or anything with license issues.
- API keys or credentials of any kind.
- Marketing prose, vision documents, "north star" essays detached from claims.

If a contribution would expose any of the above, it does not land — even if the technical content is good.
