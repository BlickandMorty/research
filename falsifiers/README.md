---
state: C (canonical infrastructure spec)
last-verified: 2026-05-09
---

# Falsifiers — Hardware Rig and Protocol Infrastructure

> *The cross-pillar falsifier infrastructure. Per-entry falsifier protocols live with their entries; this directory holds the rig spec, harness conventions, and run-log discipline.*

---

## Default target hardware

**M2 Pro 16 GB.** Per HELIOS V6.2:

> *If it works on Jojo's M2 Pro 16 GB, it can ship. If it requires a workstation, it is research-tier.*

Specifically, the canonical rig is:

- Apple M2 Pro (14-inch 2023, the 12-core CPU / 19-core GPU configuration; verified per Apple support page 111340).
- 16 GB unified memory.
- 200 GB/s memory bandwidth (theoretical peak; the canonical baseline `BW_baseline_M2Pro` is 63–73 GB/s sustained).
- macOS Sonoma or later (current canonical version recorded in run logs).
- Xcode + `xcrun -sdk macosx metal -std=metal3.1` for Metal kernel compilation.

The original HELIOS work was specified against M2 Max; V6.2 retags the verification envelope to M2 Pro 16 GB as the *shippability lock*. M2 Max remains relevant only as scale-validation.

---

## Run-log discipline

Every falsifier run produces a run log. The log goes in the entry's directory, *not* here. The log includes, at minimum:

- Hardware identification: SoC, RAM, macOS version, Xcode version, Metal SDK version.
- Date (UTC).
- The protocol version (markdown commit SHA at run time).
- The kernel / oracle versions (e.g., `oxieml` revision, kernel git SHA).
- Inputs: sample-set size, stress-set size, distribution.
- Outputs: pass/fail per criterion, max ULP distance (where applicable), wall-clock.
- Provenance: who ran it, on which machine.

A run log without provenance is invalid — it is not reproducible.

---

## What lives in this directory

```
falsifiers/
├── README.md                        ← this file
└── protocols/                       ← cross-pillar protocol scripts
    └── (added as protocols accumulate)
```

Per-entry protocols live with their entries:

- F-ULP-Oracle: [`../02-eml/06-f-ulp-oracle/`](../02-eml/06-f-ulp-oracle/)
- T29 component-edit safety bound: [`../01-helios/03-parameter-connectome-T25-T34/T29-edit-safety-bound.md`](../01-helios/03-parameter-connectome-T25-T34/T29-edit-safety-bound.md)
- T28 runtime transfer: [`../01-helios/03-parameter-connectome-T25-T34/T28-runtime-transfer.md`](../01-helios/03-parameter-connectome-T25-T34/T28-runtime-transfer.md)
- T32 sheaf consistency: [`../01-helios/03-parameter-connectome-T25-T34/T32-sheaf-consistency.md`](../01-helios/03-parameter-connectome-T25-T34/T32-sheaf-consistency.md)
- E3 storage-disaggregated: [`../03-substrate-ideas/01-storage-disaggregated-E3/`](../03-substrate-ideas/01-storage-disaggregated-E3/)

Cross-pillar harness scripts (e.g., a generic ULP-distance checker, or a memory-pressure replay harness) go in `protocols/` when they exist.

---

## V6.2 falsifier ladder (HELIOS)

Per `EPISTEMOS_V6_2_CANON_INTAKE_2026_05_07`, the V6.2 implementation gate sequence is:

1. PageGather baseline on the M2 Pro 16 GB rig.
2. PageGather scatter against 70% of measured baseline.
3. Swift CPU `InterruptScore` with P99 < 100 µs.
4. `PacketRouter1bit` dispatch P99 < 100 µs.
5. `ControllerKernelPack` reference-equivalence tests.
6. `SemiseparableBlockScan` correctness against `ssd_minimal.py`.
7. `LocalRecallIsland` 32 K Core passkey / NIAH trials.
8. `RulerBabilong` long-context evaluation.

This sequencing is HELIOS-specific. The EML F-ULP-Oracle is independent and runs in parallel.

---

## Cross-pillar conventions

All protocols share:

1. **Named oracle.** Every protocol identifies its reference oracle by name and revision.
2. **Numerical thresholds.** "Reasonable" or "approximately" is not a threshold.
3. **Wall-clock budget.** Falsifiers must terminate within a stated budget; a "passing" protocol that runs forever is not passing.
4. **Reproducibility.** A third party with the protocol and the rig must be able to reproduce the run from the entry alone.

Protocols that violate any of these are speculative-tier and live behind the wall in [`../speculative/`](../speculative/).
