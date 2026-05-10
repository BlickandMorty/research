# Verified Artifacts

> *What in this body of work has been actually run, with what hardware, with what result, and how to verify it.*

This file separates *claim* from *artifact*. Each pillar README states *what is claimed*; this file states *what is verified* and lists the verification commands. Every entry here corresponds to a passing run as of the V6.1 lock (audit `V6_1_LEAN_REALITY_MATRIX_2026_05_06`).

The verification artifacts themselves live in the **private Epistemos repository**, which holds the runtime substrate this research informs. The commands and counts below are public-facing — they describe what *would* be reproduced by a third party with access to the same substrate.

---

## Test counts at the V6.1 lock

| Surface | Command | Result |
|---|---|---:|
| Rust agent core | `cargo test --manifest-path agent_core/Cargo.toml` | **985** lib tests pass + binary, integration, doc-tests |
| Research crate (default features) | `cargo test --manifest-path epistemos-research/Cargo.toml --features research` | **464** lib tests + **97** canonical-consistency tests + doc tests |
| Graph engine | `cd graph-engine && cargo test` | **2,522** passed, 8 ignored, doc tests |
| Omega MCP | `cd omega-mcp && cargo test` | **143** passed |
| Omega AX | `cd omega-ax && cargo test` | **12** passed |
| Vault crate | `cd epistemos-vault && cargo test --features vault` | **15** passed |
| Metal shader compilation | `Tools/metal-shader-compile/metal-shader-compile.sh` | **19** `.metal` files compile against `xcrun -sdk macosx metal -std=metal3.1` |
| Sorry-budget tracker | `Tools/sorry-budget/sorry-budget.sh --report` | **37** total tracked sorries (per-id budgeted; ledger published) |
| Falsifier runner (W25 protocols) | `Tools/falsifier/falsifier.sh` | **All registered W25 protocols pass** (stage-0 protocol pass) |
| macOS app build | `xcodebuild -quiet -project Epistemos.xcodeproj -scheme Epistemos -destination 'platform=macOS' build` | **PASS** |
| macOS app full test suite | `xcodebuild -quiet -project Epistemos.xcodeproj -scheme Epistemos -destination 'platform=macOS' test` | **PASS** in **254.086 seconds** |
| Working tree clean check | `git diff --check` | **PASS** |

These are the V6.1 lock numbers. They are not theoretical; they are recorded in the audit doc cited above and reproducible against the private substrate at that revision.

---

## Verified runtime invariants

Per the V6.1 Reality Matrix, the following surfaces are status **EV** (Empirically Verified):

| Surface | Evidence |
|---|---|
| `AnswerPacket.attention_mode` field on both Rust and Swift sides | `agent_core/src/scope_rex/answer_packet.rs`; `Epistemos/Models/AnswerPacket.swift`; W1 falsifier passes |
| `ClaimKind::StaticFallbackAcknowledged` source-lint contract | doctrine linter gate 6.1; the contract is enforced at compile time |
| Goodfire VPD precision (9972 alive / 205 mean L0 / 2.1% activity) | `epistemos-research/src/goodfire_vpd_specs.rs` + canonical-consistency tests; revalidated 2026-05-07 against the public Goodfire research page |
| V6.1 five-plane discipline | `epistemos-research/src/v6_1_stream_surface.rs`; `v6_1_execution_policy.rs`; the 15-cell stream-plane matrix is preserved in tests |
| ACS plane placement (Episodic) | `epistemos-research/src/acs.rs` — ACS records live in the Episodic plane and are audited by the Verification plane |
| MAS / Pro / Vault execution policy | `v6_1_execution_policy.rs` — MAS uses interrupt-first with static 9:1 fallback; Pro adds full interrupt scoring + LocalRecallIsland; Vault adds 1-bit PacketRouter and ConnectomeAlarm |
| Kernel canon posture (target vs. implementation) | `epistemos-research/src/m2_max_kernels.rs` — the V6.1 five kernels are recorded as **doctrine targets, not implementation claims** |
| LocalAgent membrane discipline | `Epistemos/LocalAgent/LocalAgentPromptBuilder.swift` + `agent_core/src/agent_runtime/prompt_format.rs` — provider/tool orchestration is a membrane; local deterministic substrate answers do not add a gateway hop when no external context is needed |
| Lean theorem stub substrate | `lean/Epistemos/` — E1–E7 + H1–H17 + PCF-1..10 stubs with declared sorry-budgets |
| SSD/RAM mmap substrate (E3) | `agent_core/src/arena/mod.rs` + `agent_core/tests/arena_budget.rs` — real temp-file-backed `MAP_SHARED` arena, producer/consumer/reopen tested |

---

## What is *not* verified — explicitly

Per the same audit, the following are status **P** (Provisional, target only):

- `SemiseparableBlockScan.metal` — bit-exact correctness vs. `ssd_minimal.py` reference at 32K Core / 128K Stretch (existing Mamba2 shaders compile; canonical kernel not implemented)
- `LocalRecallIsland.metal` — passkey/NIAH recall ≥ 0.99 at 128K (policy encoded; hardware run pending)
- `PageGather.metal` — ≥ 70% of measured `BW_baseline_M2Pro` (no benchmark proves this yet)
- `ControllerKernelPack.metal` — 1 ULP equivalence (no fused pack exists)
- `PacketRouter1bit.metal` — routing-quality loss ≤ 2% versus FP16 reference (Vault policy encoded; kernel not implemented)
- `InterruptScore.metal` — bit-exact vs. CPU canonical (CPU version is canonical for V6.2 single-token; Metal kernel target only)
- T35 ρ_max = 0.20 at 128K context — encoded, not hardware-proven
- T42 ConnectomeAlarm — Goodfire atlas is public-confirmed for observability; runtime prediction of interrupt traces unproven
- Donor-distilled student (Qwen3-8B → Granite-4-H-shape) — canonical route, no checkpoint exists

This honesty is part of the architecture. Listing target-only items separately from EV items is what makes the EV claims defensible.

---

## Reproducing the verifications

A third party with access to the private Epistemos substrate would:

1. Check out the canonical revision (the V6.1 lock).
2. Run the commands listed above in order.
3. Compare against the recorded test counts.
4. Inspect the `RuntimeDiagnosticsMonitor` for the E3 mmap arena test.
5. Inspect the source-lint output for the `StaticFallbackAcknowledged` contract enforcement.

Without access to the private substrate, the verification cannot be reproduced from this public repo alone. The bridge is the V6.1 Reality Matrix audit doc, which records the *artifacts* of each verification (test outputs, file paths, line counts) without exposing the source.

---

## Related Lean (this repo)

This public repo carries Lean stubs for a subset of the substrate's theorems (T28, T29, T32, the `attention_mode` invariant, EML operator/grammar/density, E3). The stubs are:

- Status: P (provisional). Each carries a declared sorry-budget.
- Build: `cd lean && lake update && lake build`. CI on every push validates `lake build` cleanly with the declared sorries; the `lake build` step is configured to fail on unbudgeted sorries.
- See [`../lean/`](../lean/) and [`../CONTRIBUTING.md`](../CONTRIBUTING.md) for the budget rules.

When the public-repo Lean stubs close their sorries (W → R → V), the corresponding markdown entries promote from P to EV. The public repo lags the private substrate; that lag is honest, not a defect.

---

## Bottom line

Every claim in the public repo points to either:

- A passing run on the private substrate (recorded by command + count + audit-doc reference here), or
- A target-only contract (clearly labeled `P (target only)` in the relevant entry).

There is no third category. A claim that is neither EV-with-evidence nor P-with-falsifier-protocol is overclaiming and is rejected by the discipline in [`../CONTRIBUTING.md`](../CONTRIBUTING.md).
