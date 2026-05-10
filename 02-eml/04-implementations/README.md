---
state: C (vendored, read-only — credit upstream)
last-verified: 2026-05-09
---

# Implementations — `oxieml` and `eml-lean`

The two reference implementations EML depends on. **Both are vendored read-only with upstream credit.** They are not authored here. This subdirectory holds vendor notes, integration patterns, and the verification status of each upstream.

---

## `oxieml` — Rust reference

**Role:** the reference oracle for the `F-ULP-Oracle` falsifier ([`../06-f-ulp-oracle/`](../06-f-ulp-oracle/)). Provides:

- `oxieml::EmlTree` — the AST of grammar expressions.
- `oxieml::EmlTree::eval_real` — the canonical real-valued evaluator. Treated as the oracle the kernel under test (`morph_eval_reduced.metal v0.1`) must agree with up to 2 ULP fp16.

**Vendoring posture:** read-only. We do not modify `oxieml`; we depend on a tagged release. If `oxieml`'s upstream changes the `eval_real` semantics, the falsifier oracle changes — and the F-ULP-Oracle's run log records the `oxieml` revision used.

**Verification:** the `oxieml::EmlTree::eval_real` reference is treated as the canonical real-valued evaluator. Its correctness is *not* re-litigated here. If a defect is found, the right move is upstream (file an issue / PR), not patch in this repo.

---

## `eml-lean` — Lean reference

**Role:** the formal-verification side of EML. The Lean library is *claimed* to ship with a zero `sorry` / zero `admit` posture by the upstream maintainer.

**Vendoring posture:** read-only. The "zero sorry / admit" claim is a hypothesis at the V6.1 Foundation Intake stage; verification is part of the foundation gate sequence.

**Verification gate:** before depending on `eml-lean`'s lemmas in a load-bearing way, the foundation sequence requires:

1. Vendoring `eml-lean` at a tagged release.
2. Running `lake build` and inspecting for `sorry` / `admit` instances.
3. Recording the result in a run log.

**Status at this repo's lock:** `eml-lean` is recorded as a target dependency; the verification gate has not been run end-to-end.

---

## Why vendor read-only

EML is not the place to fork upstream libraries. The repo's job is:

- To state the EML thesis precisely.
- To specify the falsifier protocol.
- To produce or verify the `morph_eval_reduced.metal v0.1` kernel.
- To depend on `oxieml` and `eml-lean` as black-box reference oracles.

If `oxieml` or `eml-lean` is wrong, the right fix is upstream. The discipline of treating them as oracles — not as libraries to monkey-patch — keeps the falsifier honest.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker argues that depending on `oxieml::EmlTree::eval_real` as the oracle just *moves* the verification problem — the kernel under test now agrees with `oxieml`, but neither has been independently verified. **Defense:** the falsifier oracle is *named* as `oxieml::EmlTree::eval_real` at a *tagged release*. The correctness of the oracle is not the kernel's verification problem; it is a separate (and named) verification problem upstream. The kernel's claim is "I agree with this named oracle to 2 ULP fp16." That claim is well-defined and falsifiable.

> **Adversarial attack (subtler):** an attacker pushes a malicious update upstream to `oxieml` and waits for this repo to pick it up. **Defense:** the F-ULP-Oracle pins the oracle to a *tagged release*; the run log records the revision. A silent upstream change does not propagate to a passing run unless the lock file is updated.

---

## File structure

This subdirectory will hold:

- `oxieml-vendor-notes.md` — when vendored, this file records the tagged release used and the upstream reference.
- `eml-lean-vendor-notes.md` — same, for the Lean side.
- (No code is checked in here — both are upstream dependencies.)

---

## Open questions

- Independent verification of `eml-lean`'s zero-sorry posture (per V6.1 Foundation Intake, this is a load-bearing gate before EML depends on its lemmas).
- Whether a leaner `oxieml` subset would simplify the F-ULP-Oracle harness — open and recorded.
