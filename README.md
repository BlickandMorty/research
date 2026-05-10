# Research

[![Lean Build](https://github.com/BlickandMorty/research/actions/workflows/lean-build.yml/badge.svg)](https://github.com/BlickandMorty/research/actions/workflows/lean-build.yml)
[![Markdown Checks](https://github.com/BlickandMorty/research/actions/workflows/markdown-checks.yml/badge.svg)](https://github.com/BlickandMorty/research/actions/workflows/markdown-checks.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A working notebook of mathematical primitives embedded in the latent and parameter subspaces of post-transformer runtimes — built so that *what counts as harm* and *what counts as a faithful computation* are first-class invariants, not afterthoughts.

By [Jordan Conley](https://linkedin.com/in/jordanconley30) — ML red-team engineer at Mercor.
Contact: `jordantyrellconley@gmail.com`.

---

## What this repo is

Three independent research programs sharing a single discipline:

> **Falsifier-first. Every claim ships with a hardware falsifier protocol, an adversarial attack paired with a named defense, and (where applicable) a Lean 4 anchor under a tracked sorry-budget.**

| | Pillar | One-line thesis |
|---|---|---|
| 01 | [**HELIOS**](./01-helios/) | Inference substrate canon. Attention is an interruptible computation routed by an audit-grade signal — not a softmax pass. |
| 02 | [**EML**](./02-eml/) | A reconceptualization of elementary scientific computation around a single binary operator: `eml(x, y) = exp(x) − ln(y)`. |
| 03 | [**Substrate Ideas**](./03-substrate-ideas/) | Smaller high-signal ideas: storage-disaggregated runtimes (SSD as RAM extension), the five-plane formalism, ACS, honesty-by-construction. |

This is the public mirror of an active, opinionated research notebook. Some entries are canonical; others are provisional candidates with named falsifiers; a few are vault-only. **The status legend is load-bearing — every claim carries a status tag.** See [`STATUS_LEGEND.md`](./STATUS_LEGEND.md).

## What this repo is *not*

- It is not a finished paper.
- It is not a product release. The on-device runtime that consumes this work (Epistemos) is private.
- It is not "AI-augmented prose written without proofs." The Lean substrate is real; the sorry-budget is real; the falsifier protocols target real hardware (M2 Pro 16 GB).
- It is not a dump of every speculative idea I have ever had. Speculative ideas live behind clear walls in [`speculative/`](./speculative/) and are labeled accordingly.

---

## Reading paths

> Pick the path that matches what you want to know. **The 90-second path is enough to decide whether to keep reading.**

### 90 seconds — what is this?
1. This README, top to bottom.
2. [`00-spine/thesis.md`](./00-spine/thesis.md) — the unified thesis in one page.

### 5 minutes — is the work serious?
1. [`STATUS_LEGEND.md`](./STATUS_LEGEND.md) — what `C / EV / EB / P / DROP` mean.
2. [`00-spine/methodology.md`](./00-spine/methodology.md) — falsifier-first, attack-with-defense, the WRV ladder.
3. [`00-spine/avenues.md`](./00-spine/avenues.md) — the same body of work mapped to seven entry points (safety, performance, sparsity, local inference, kernel architecture, interpretability, gaming).
4. [`00-spine/verified-artifacts.md`](./00-spine/verified-artifacts.md) — the test counts, build commands, and verified runtime invariants behind the EV claims.
5. [`01-helios/04-attention-as-interrupt/README.md`](./01-helios/04-attention-as-interrupt/README.md) — the HELIOS flagship.
6. [`02-eml/README.md`](./02-eml/README.md) — the EML thesis.

### 30 minutes — engage with the work
1. The reading paths above.
2. [`01-helios/03-parameter-connectome-T25-T34/`](./01-helios/03-parameter-connectome-T25-T34/) — T28 / T29 / T32 with citations and falsifiers.
3. [`02-eml/06-f-ulp-oracle/`](./02-eml/06-f-ulp-oracle/) — the F-ULP-Oracle protocol.
4. [`03-substrate-ideas/01-storage-disaggregated-E3/`](./03-substrate-ideas/01-storage-disaggregated-E3/) — SSD-as-RAM-extension as a runtime invariant.
5. [`lean/`](./lean/) — Lean 4 substrate. `lake build` after pinning `leanprover/lean4:v4.16.0`.

### Hiring-manager path
1. This README.
2. [`STATUS_LEGEND.md`](./STATUS_LEGEND.md) — how I label proved vs provisional.
3. [`00-spine/avenues.md`](./00-spine/avenues.md) — the work mapped to the avenue you came in on.
4. [`00-spine/verified-artifacts.md`](./00-spine/verified-artifacts.md) — what is actually verified, with test counts and commands.
5. Whichever pillar matches the role:
   - Interpretability / mech-interp / safety: → [`01-helios/03-parameter-connectome-T25-T34/`](./01-helios/03-parameter-connectome-T25-T34/) and [`01-helios/04-attention-as-interrupt/`](./01-helios/04-attention-as-interrupt/).
   - Foundation models / on-device inference: → [`01-helios/04-attention-as-interrupt/`](./01-helios/04-attention-as-interrupt/) and [`03-substrate-ideas/01-storage-disaggregated-E3/`](./03-substrate-ideas/01-storage-disaggregated-E3/).
   - Numerical methods / computation foundations: → [`02-eml/`](./02-eml/) end to end.
   - Game design / structured-data: → [`03-substrate-ideas/05-data-as-lattice/`](./03-substrate-ideas/05-data-as-lattice/).

---

## Discipline rules (non-negotiable)

1. **No claim without a status tag.** Every theorem / kernel / protocol carries `state: C | EV | EB | P | DROP`. See [`STATUS_LEGEND.md`](./STATUS_LEGEND.md).
2. **No claim without a falsifier.** If it cannot be disproved, it is not a research claim — it lives in [`speculative/`](./speculative/) until promoted.
3. **No claim without an adversarial attack and a named defense.** Anything else is a wish.
4. **No citation without a verification date.** All references in [`REFERENCES.md`](./REFERENCES.md) carry `[VERIFIED-WEB-YYYY-MM-DD]` or `[NEEDS-SOURCE-FILE-VERIFICATION]`.
5. **Sorry-budget is published.** The Lean ledger publishes its proof debt; promoting a theorem from P to C requires the budget to drop.
6. **Adversarial defense quoted from Mercor practice:** *"Every claimed weakness paired with a reproducible falsifier and a named mitigation."* The same posture governs this repo.

See [`CONTRIBUTING.md`](./CONTRIBUTING.md) for the full promotion rules and the per-status checklist.

---

## Repo layout

```
research/
├── README.md                       ← this file
├── STATUS_LEGEND.md                ← C / EV / EB / P / DROP definitions
├── REFERENCES.md                   ← arXiv citations with verification dates
├── CONTRIBUTING.md                 ← discipline rules + promotion checklist
│
├── 00-spine/                       ← cross-cutting docs
│   ├── thesis.md                   ← unified thesis
│   ├── methodology.md              ← falsifier-first / attack-with-defense / WRV
│   ├── avenues.md                  ← seven entry points (safety / performance / sparsity / local / kernel / interp / gaming)
│   └── verified-artifacts.md       ← test counts, build commands, EV evidence
│
├── 01-helios/                      ← Pillar 1 — substrate canon
│   ├── README.md
│   ├── 01-foundational-E1-E7/      ← E1-E7 substrate-foundational invariants
│   ├── 02-build-canon-H1-H17/      ← H1-H17 build/canon claims
│   ├── 03-parameter-connectome-T25-T34/   ← safety pillar (FLAGSHIP)
│   ├── 04-attention-as-interrupt/         ← V6.1 flagship (FLAGSHIP)
│   ├── 05-kernels-targets/                ← Metal kernels (target-only, honest)
│   └── falsifiers/                        ← M2 Pro 16 GB protocols
│
├── 02-eml/                          ← Pillar 2 — reconceptualizing computation
│   ├── README.md
│   ├── 01-operator/                 ← eml(x,y) = exp(x) − ln(y)
│   ├── 02-grammar/                  ← S → 1 | eml(S, S)
│   ├── 03-density/                  ← Stone-Weierstrass argument
│   ├── 04-implementations/          ← oxieml + eml-lean vendor notes
│   ├── 05-morph-eval-reduced/       ← Metal kernel spec (target only)
│   ├── 06-f-ulp-oracle/             ← FLAGSHIP — falsifier protocol
│   └── 07-open-questions/           ← what remains open and why
│
├── 03-substrate-ideas/              ← Pillar 3 — smaller high-signal ideas
│   ├── README.md
│   ├── 01-storage-disaggregated-E3/    ← SSD as RAM extension (mmap)
│   ├── 02-acs-episodic-plane/          ← ACS in the Episodic plane
│   ├── 03-honesty-by-construction/     ← StaticFallbackAcknowledged contract
│   ├── 04-five-plane-formalism/        ← State / Episodic / Assembly / Controller / Verification
│   └── 05-data-as-lattice/             ← gaming application: shared ontology across game systems
│
├── lean/                            ← Lean 4 substrate
│   ├── lakefile.lean                ← mathlib4 pin
│   ├── lean-toolchain               ← Lean version pin
│   ├── ResearchCanon.lean           ← root module
│   └── ResearchCanon/
│       ├── Helios/Connectome/       ← T28, T29, T32 stubs
│       ├── Helios/Interrupt/        ← interrupt invariant
│       ├── Eml/                     ← operator + density stubs
│       └── Substrate/               ← E3, five-plane stubs
│
├── falsifiers/                      ← shared falsifier infrastructure
│   ├── README.md                    ← M2 Pro 16 GB rig spec
│   └── protocols/                   ← cross-pillar protocol scripts
│
├── speculative/                     ← clearly walled, no proof claims
└── archive/                         ← preserved-but-vault, dropped ideas
```

## Citing this work

If you reference this work, cite it as:

> Conley, J. (2026). *Research: HELIOS, EML, and substrate ideas for post-transformer runtimes*. https://github.com/BlickandMorty/research

## License

MIT — see [`LICENSE`](./LICENSE). Vendored upstream code (when present) carries its own license; see notes per pillar.
