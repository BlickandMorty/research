# Kernels — Targets, Not Implementations

> *This subdirectory exists so that no one downstream — including future me — confuses a target for an implementation.*

The HELIOS V6.1 substrate names six load-bearing Metal kernels. **None of them are implemented in this public repo.** The status is `P (target only)`. The contracts are public so that the falsifier specification is in the open; the implementations are not, because no honest implementation exists yet.

---

## The six target kernels

| Kernel | Lane | Status | Falsifier | Notes |
|---|---|---|---|---|
| `SemiseparableBlockScan.metal` | L1 / L2 | P (target only) | Bit-exact correctness vs. `ssd_minimal.py` reference at 32 K Core / 128 K Stretch | Existing Mamba2 shaders compile; canonical SemiseparableBlockScan is not yet implemented |
| `LocalRecallIsland.metal` | L2 | P (target only) | Passkey / NIAH recall ≥ 0.99 at 32 K Core; 128 K is Stretch | Policy is encoded; no hardware run yet |
| `PageGather.metal` | L1 / L2 | P (target only) | ≥ 70% of *measured* `BW_baseline_M2Pro` (63–73 GB/s sustained) over a 1 s window | NOT 70% of theoretical 200 GB/s peak |
| `ControllerKernelPack.metal` | L2 | P (target only) | Reference-equivalence test at 1 ULP | No fused controller pack exists |
| `PacketRouter1bit.metal` | L5 | P (target only) | Routing-quality loss ≤ 2% versus FP16 reference | Vault policy is encoded; no kernel implemented |
| `InterruptScore.metal` | L5 | P (target only) | Bit-exact agreement with the canonical Swift CPU implementation; activated only for batches ≥ 64 tokens | Swift CPU is canonical for V6.2 single-token |

---

## Why this directory exists

The standard pattern in research-substrate writing is to claim a kernel exists in the same paragraph as the theorem it supports. That is dishonest at the substrate level: the falsifier protocol *needs* the kernel to evaluate, and if the kernel is not there, the falsifier has not run.

This directory makes the gap explicit. A reader who lands here knows immediately:

- The kernels are *target contracts*, not finished artifacts.
- The falsifier thresholds are concrete and named.
- Downstream theorems that depend on a kernel are flagged accordingly (T35, parts of T28 / T33 / T34, the Stage 3 V6.1 falsifier ladder).

---

## What *does* exist

For honesty, here is what is implemented in the source-of-truth Epistemos repo (private) at the V6.1 lock:

- **19 existing `.metal` shader files** that compile against `xcrun -sdk macosx metal -std=metal3.1`. None of them is the V6.1 named-kernel set above.
- **Mamba2 shaders** that compile and pass smoke tests but are not the canonical `SemiseparableBlockScan.metal`.
- **A Swift CPU `InterruptScore`** that is canonical for V6.2 single-token use, with a P99 < 100 µs target on M2 Pro 16 GB.

Nothing in the public repo claims more than this.

---

## V6.2 sequencing

Per `EPISTEMOS_V6_2_CANON_INTAKE_2026_05_07`, the implementation gate sequence is:

1. PageGather baseline on the M2 Pro 16 GB rig.
2. PageGather scatter against 70% of measured baseline.
3. Swift CPU `InterruptScore` with P99 < 100 µs.
4. `PacketRouter1bit` dispatch P99 < 100 µs.
5. `ControllerKernelPack` reference-equivalence tests.
6. `SemiseparableBlockScan` correctness against `ssd_minimal.py`.
7. `LocalRecallIsland` 32 K Core passkey / NIAH trials.

A kernel is promoted from P to EV only after its falsifier passes on the M2 Pro 16 GB rig with a committed run log.

---

## What this means for downstream theorems

Several Parameter Connectome Family theorems (T28, T33) and the V6.1 falsifier ladder (T35) depend on these kernels existing and passing their falsifiers. Until the kernels are EV, those theorems remain at P.

When you read a theorem that says "verified on M2 Pro 16 GB," the verification *requires* one or more kernels in this list. That is why this README is the prerequisite read for the rest of HELIOS — without it, the verified-vs-target boundary is opaque.
