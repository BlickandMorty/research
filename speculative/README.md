---
state: speculative — wall
last-verified: 2026-05-09
---

# Speculative

> *Ideas in this directory are not research claims. They are recorded so I do not re-invent and re-reject them later.*

Anything in `speculative/` is **explicitly walled off** from the rest of the repo. Entries here:

- Carry no `state: C / EV / EB / P / DROP` tag — they are pre-status.
- Do not have falsifier protocols (yet).
- Do not have adversarial-attack-with-defense pairs (yet).
- Are *not* cited as canonical from the pillar READMEs.

If a speculative entry develops to the point of having a precise statement, a falsifier protocol, an attack-with-defense pair, and a citation lineage, it can be promoted out of this directory into the appropriate pillar. Promotion follows the rules in [`../CONTRIBUTING.md`](../CONTRIBUTING.md).

---

## Why this wall exists

The discipline of the rest of the repo — falsifier-first, attack-with-defense, status tags — is what separates research output from interesting prose. **A research notebook needs a place for ideas that are not yet ready to claim, but also needs a wall around that place.** Without the wall, the discipline degrades: today's speculative idea quietly becomes tomorrow's "canonical" claim.

Putting speculation behind a wall is the same logic as the source-lint contract for static fallback: **honesty-by-construction.** A reader who lands here knows immediately that what follows is not a claim, and a future me who tries to cite this directory as if it were a pillar will see the wall and stop.

---

## What lives here

(Empty at lock. As speculative entries accumulate, they go here.)

Examples of the kind of thing that lives here:

- *Multi-token interrupt scoring with a different P99 budget* — currently per-token only is canonical; multi-token is a stretch. Recorded here when a precise statement exists.
- *T28 / T29 bridge lemma* — the relationship between the expectation bound (T28) and the per-prompt operator-norm bound (T29). Mechanically clear, not yet formally connected.
- *Higher sheaf-cohomology structure on the parameter connectome (H¹, H², …)* — T32 stops at H⁰; whether higher cohomology carries useful invariants is open and speculative.
- *Constant-free universal-EML grammar* — also recorded in [`../02-eml/07-open-questions/`](../02-eml/07-open-questions/), but not yet a claim.
- *EML extensions beyond the canonical `[0.5, 2.0]` window* — kernel-implementation question; speculative until the kernel lands.

When a speculative entry is *ready* to be a claim, it moves out of here. When it is *not ready*, it stays.

---

## What does NOT belong here

- Anything covered by the rules in [`../CONTRIBUTING.md`](../CONTRIBUTING.md). Speculation is a category; "violating the rules" is a different category.
- Marketing prose. Speculation is rough thinking with the discipline turned down; it is not promotional copy.
- Arguments about whether the rules should change. Those go into a meta-discussion, not into speculation about the work.

---

## Promotion path

When a speculative entry develops to readiness:

1. Write a precise statement.
2. Specify a falsifier protocol with thresholds and target hardware.
3. Add an adversarial attack and a named defense.
4. Run the literature collision check; add citations to [`../REFERENCES.md`](../REFERENCES.md).
5. Choose a status tag. (Most promotions are W → R, status `P`. Fewer go straight to `EV`.)
6. Move the file to the appropriate pillar's directory.
7. Update any pillar README that should now reference the new entry.

The promotion is an act of discipline, not a publication ceremony. The work is still the work; the location records its current readiness.
