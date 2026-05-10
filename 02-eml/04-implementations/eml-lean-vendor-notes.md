---
state: C (vendored, read-only — credit upstream)
last-verified: 2026-05-09
upstream: TBD (canonical upstream to be confirmed at first vendor)
pinned-revision: TBD
sorry-admit-posture: claimed-zero, awaiting independent verification
---

# `eml-lean` — Vendor Notes

The formal-verification side of EML. The Lean library is *claimed* to ship with a zero `sorry` / zero `admit` posture by upstream. This file pins the verification gate.

---

## Role

- Provides Lean 4 / mathlib4 statements of the EML grammar's structural properties (operator definition, grammar inductive type, density-related lemmas).
- Provides closed-proof anchors that the markdown-side EML pillar can cite without re-proving.
- Treated as a black-box authority for the formal-verification side of EML, paralleling `oxieml`'s role on the runtime side.

---

## Vendoring posture

**Read-only.** Modifications go upstream. Vendoring is at a tagged release; the pinned revision is recorded here when the vendor lands.

---

## Verification gate

Before depending on `eml-lean`'s lemmas in a load-bearing way (i.e., before citing them as proof anchors in our pillar entries), the foundation gate sequence requires:

1. Vendor `eml-lean` at a tagged release.
2. Run `lake update` and inspect the dependency graph for compatibility with this repo's mathlib4 v4.16.0 pin.
3. Run `lake build` from `eml-lean`'s root.
4. Inspect the build for `sorry` / `admit` instances:
   ```bash
   grep -rn '^[[:space:]]*sorry' --include='*.lean'
   grep -rn '^[[:space:]]*admit' --include='*.lean'
   ```
5. Record the result in this file.
6. If the zero-`sorry` posture holds, the verification gate passes; pillar entries may cite `eml-lean` lemmas.
7. If `sorry` / `admit` instances exist, record the count and decide whether each is acceptable. The zero-claim is downgraded to a precise non-zero claim.

**Status at this lock:** the verification gate has not been run. `eml-lean` is recorded as a target dependency.

---

## Mathlib compatibility note

This repo's Lean toolchain pin is `leanprover/lean4:v4.16.0` with mathlib4 `v4.16.0`. If `eml-lean` pins a different mathlib release, the vendor needs:

- A compatibility rebase against this repo's mathlib pin, or
- A documented divergence with both pins recorded and the build matrix expanded to cover both.

The discipline forbids silently using `eml-lean` against a mismatched mathlib.

---

## Pinning checklist (when first vendored)

- [ ] Confirm canonical upstream URL.
- [ ] Identify the latest tagged release.
- [ ] Confirm mathlib pin compatibility; document any rebase.
- [ ] Pin SHA in this file.
- [ ] Run the verification gate (steps 2–5 above).
- [ ] Record the `sorry` / `admit` count.
- [ ] Update [`./README.md`](./README.md) status table to reflect the pin and the verification gate's outcome.

---

## Adversarial attack and defense

> **Attack:** an attacker argues "you're depending on `eml-lean`'s zero-sorry posture without verifying it — the same overclaiming the rest of the repo refuses." **Defense:** correct. The verification gate above is exactly the discipline that prevents this. Pillar entries do not cite `eml-lean` lemmas as canonical until the gate passes.

> **Attack:** an attacker pushes upstream changes that introduce `sorry` instances into previously-closed proofs. **Defense:** the pinned revision in this file is the canonical reference. An upstream regression does not propagate; the next vendor refresh re-runs the gate.
