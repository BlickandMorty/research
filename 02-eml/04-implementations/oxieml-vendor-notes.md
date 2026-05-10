---
state: C (vendored, read-only — credit upstream)
last-verified: 2026-05-09
upstream: https://github.com/Hammad-A/oxieml  (placeholder until canonical upstream is confirmed)
pinned-revision: TBD (set at first vendor)
---

# `oxieml` — Vendor Notes

The Rust reference oracle for the EML grammar. Treated as a black-box authority for the falsifier in [`../06-f-ulp-oracle/`](../06-f-ulp-oracle/).

---

## Role

- Provides `EmlTree`: the AST type for grammar expressions in `S → 1 | eml(S, S)`.
- Provides `EmlTree::eval_real`: the canonical real-valued evaluator.
- The `F-ULP-Oracle` falsifier compares `morph_eval_reduced.metal v0.1` against `EmlTree::eval_real` at 2 ULP fp16 over 412 K log-sampled points.

---

## Vendoring posture

**Read-only.** The upstream is not modified inside this repo. Vendoring is performed at a tagged release; the pinned revision is recorded here.

When the vendor lands:

1. Pin a tagged release SHA in this file.
2. Record the build command (`cargo build` against the pinned revision).
3. Record the test command (`cargo test`) and the result.
4. Record any local hardware quirks observed.

If `oxieml`'s upstream changes the `eval_real` semantics, the falsifier's reference oracle changes — and the F-ULP-Oracle's run log records the `oxieml` revision used. **A silent upstream change does not propagate to a passing run unless this file's pin is updated.**

---

## Verification status

- The `oxieml::EmlTree::eval_real` reference is treated as the canonical real-valued evaluator. Its correctness is **not** re-litigated in this repo.
- If a defect is found in `eval_real`, the right move is upstream (file an issue / PR), not patch in this repo.
- Independent verification of `eval_real` against arbitrary-precision arithmetic is a separate (and named) upstream verification problem.

---

## Pinning checklist (when first vendored)

- [ ] Confirm canonical upstream URL.
- [ ] Identify the latest tagged release.
- [ ] Pin SHA in this file.
- [ ] Run `cargo build`; record the rustc version used.
- [ ] Run `cargo test`; record the pass count and any skipped tests.
- [ ] Update [`./README.md`](./README.md) status table to reflect the pin.

---

## Adversarial attack and defense

> **Attack:** an attacker pushes a malicious update upstream and waits for this repo to pick it up silently. **Defense:** the F-ULP-Oracle pins the oracle to a *tagged release SHA*; the run log records the revision. A silent upstream change does not propagate to a passing run unless the pin in this file is updated.

> **Attack:** an attacker argues that depending on `eval_real` as the oracle just *moves* the verification problem upstream. **Defense:** the falsifier's claim is "the kernel under test agrees with this *named* oracle to 2 ULP fp16." That claim is well-defined and falsifiable independent of the oracle's internal correctness.
