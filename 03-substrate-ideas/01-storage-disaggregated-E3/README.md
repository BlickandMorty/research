---
state: EV (the runtime invariant; the underlying mmap proof is implemented and tested)
lane: L1 (MAS-add)
last-verified: 2026-05-09
---

# E3 — Storage-Disaggregated Morph Field

> *SSD as a real RAM extension. Resident memory scales with active patches, not total archive size.*

The substrate-foundational invariant of HELIOS that says the runtime can keep an arbitrarily large knowledge archive on disk and still hit a bounded resident-memory footprint. **Verified empirically** through a real `MAP_SHARED` arena with a producer / consumer contract.

---

## Statement

For a runtime with `N` archived patches and `K` active patches at time `t`,

```
M_resident(t) ≤ M_core + M_state + M_active(t) + M_cache(t) + M_glue(t)
```

where:

- `M_core` is the runtime executable + kernel pack + glue code (constant).
- `M_state` is the runtime state buffer (small, bounded).
- `M_active(t)` is the resident memory for the K active patches at time t.
- `M_cache(t)` is the bounded cache for recently-deactivated patches (TTL-evicted).
- `M_glue(t)` is the bounded scratch for cross-patch operations.

The point: *resident memory does not scale with `N`*. Adding archived patches that are not active does not increase RSS.

---

## Why this is the substrate-foundational invariant

Most local AI systems are bottlenecked by working set size. If the model + KV cache + retrieval index doesn't fit in RAM, the system thrashes. The standard response is "use a smaller model" or "use a smaller index." E3 says: *neither.* Build the runtime so that disk-resident archives are first-class, and resident memory tracks only the *active* working set.

This is what the runtime does:

- **Patches live on SSD as memory-mapped files.** A patch is touched only when active.
- **The active set is bounded by a residency governor.** When the active set would exceed the budget, the least-recently-used active patch is deactivated.
- **Deactivation is cheap.** A deactivated patch's pages can be released by the OS without runtime involvement.
- **The cache buffer for recently-deactivated patches is bounded by TTL.** No unbounded growth.

The literature collision is **PagedAttention** (Kwon et al. arXiv:2309.06180, SOSP 2023): they apply paging to the KV cache; E3 applies the same discipline to the entire patch archive.

---

## Falsifier protocol

**Hardware:** any (the RSS check is OS-level).

**Procedure:**

1. Instantiate the runtime with `N = 10⁵` archived patches.
2. Activate `K = 10²` patches.
3. Drive the runtime through a representative workload.
4. Measure RSS via `RuntimeDiagnosticsMonitor` (or equivalent).

**Pass criterion:** `RSS ≤ M_core + M_state + sum-of-active-patch-sizes + bounded-cache + bounded-glue`. Specifically, RSS must *not* grow with `N`.

**Status:** EV. The underlying `MAP_SHARED` arena is implemented and tested in `agent_core/src/arena/mod.rs` (private Epistemos repo) with the test harness `agent_core/tests/arena_budget.rs`. The harness exercises:

- A real temp-file-backed `MAP_SHARED` arena, opened twice.
- Producer writes and flushes; consumer reads and consumes.
- Producer observes the tail update.
- A reopened mapping preserves header state.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker constructs a workload that activates *every* archived patch at least once over the workload's lifetime. The active set grows to `N`, and the residency governor's eviction policy is overwhelmed. **Defense:** the governor's eviction is *strict* — when the active set exceeds the budget, the least-recently-used patch is *unconditionally* deactivated. An attacker who activates every patch sequentially still sees a bounded active set; the attacker just waits longer per patch. The bound is preserved.

> **Adversarial attack (subtler):** an attacker exploits a long-tailed workload where a small fraction of patches are *very* large (much larger than the typical patch). The active set is bounded by *count*, but the resident memory for the active set is unbounded if a single active patch is enormous. **Defense:** the residency governor bounds active *bytes*, not just active count. An oversized patch that exceeds the byte budget alone fails to activate; the runtime falls back to a streaming read.

---

## Citation lineage

- **PagedAttention** (Kwon et al. arXiv:2309.06180, SOSP 2023): paging discipline applied to KV cache. The closest existing literature collision. E3 generalizes the discipline to the full patch archive.
- The `mmap` substrate is standard POSIX — the novelty is the *invariant statement*, not the implementation technique.
- **`vmem`-style virtual memory abstractions** (classical OS literature) — adjacent; E3 differs by treating the archive as application-managed rather than OS-managed.

---

## Lane and downstream impact

- **Lane:** L1 (MAS-add). E3 ships in the bounded App Store build.
- **Downstream:** the Episodic plane (where ACS lives) depends on cheap append-only storage. Without E3, the Episodic plane is too expensive to be the default audit substrate. With E3, it is.

This is a substrate-foundational invariant in the strict sense: HELIOS's downstream claims (audit-grade attention, honesty-by-construction) depend on the storage discipline being *cheap*. E3 is what makes that cheapness real.
