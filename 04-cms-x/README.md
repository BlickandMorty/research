---
state: index — pillar overview
last-verified: 2026-05-09
---

# CMS-X — Constitutive Semantic Field Model

> *Cognition itself must be constitutive geometry — a persistent, dynamical field in which meaning, memory, reasoning, and moral constraints are inseparable properties of the same topological substrate.*

The fourth pillar. CMS-X is the longer-form research synthesis behind a proposed cognitive architecture that extends the broader work's *safety-as-geometry* discipline into a *cognition-as-geometry* claim. **It is a manuscript-stage research program**, not an operational substrate — distinguished from HELIOS (substrate canon) and EML (computational primitive) by its scope (a full architecture proposal) and by its status (largely Theoretical / Supported-but-indirect, with one validated-anchor base).

This pillar is the **best-version distillation** of three independent essay drafts (CMS-X v3, CMS-X Gemini, CMS-X Perplexity) consolidated into a single fused manuscript with an explicit Claim Status Framework. Per the repo's discipline, what survives here is what is *defensible* — the architectural intuitions, the validated citation base, and the calibration of which claims are speculative.

---

## The unifying thesis

CMS v2 proved that *safety* must be constitutive geometry, not a post-hoc filter. CMS-X argues that *cognition* must be constitutive geometry — concepts as Concept Packets in a Semantic Force Graph; reasoning as trajectory evolution under five learned force laws; memory as topological deformation; safety as topologically entangled with coherence.

The thesis is provocative; it is also bounded. Several technical pillars (SGFMs, holographic functional encryption, full Neural ODE backbones at LM scale) are explicitly **theoretical** in this manuscript and are labeled accordingly.

---

## Reading order

1. [`01-cognition-as-constitutive-geometry.md`](./01-cognition-as-constitutive-geometry.md) — the thesis, the Concept Packet ontology, and the multi-scale tri-manifold topology.
2. [`02-five-force-laws.md`](./02-five-force-laws.md) — attraction, repulsion, binding (Hooke for semantics), **damping**, and constraint projection. Damping is the load-bearing one.
3. [`03-memory-as-topology.md`](./03-memory-as-topology.md) — memory as field deformation, with BeliefShift as the empirical anchor.
4. [`04-traced-and-aqi.md`](./04-traced-and-aqi.md) — TRACED (displacement + curvature) for runtime; AQI for latent-safety geometry.
5. [`05-claim-calibration.md`](./05-claim-calibration.md) — the manuscript's **honest-limits ledger**. What is validated, what is supported-but-indirect, what is theoretical, what is speculative. The single most important file in this pillar.

---

## Claim Status Framework

CMS-X uses a four-class claim taxonomy that maps onto the repo's status legend:

| CMS-X class | Repo status | Meaning |
|---|---|---|
| **Validated** | EV | Directly supported by cited experiments or benchmarked systems |
| **Supported but indirect** | EB | The literature supports the direction, but not the full CMS-X instantiation |
| **Theoretical** | C (definition) or P (claim) | Mathematically or conceptually motivated; not empirically demonstrated at CMS-X scale |
| **Speculative / future work** | speculative | Included as research directions; not established results |

The honest separation is the point. CMS-X is strongest when it preserves architectural originality while clearly separating what has been demonstrated from what is supported by adjacent work and what remains a live research hypothesis.

---

## Key insights — at a glance

| Claim | Class | Anchor |
|---|---|---|
| Refusal is geometrically trivial in standard transformers | Validated | Arditi et al. arXiv:2406.11717 (NeurIPS 2024) |
| Reasoning can occur in continuous latent space (not just token chains) | Validated | Coconut arXiv:2412.06769 (Meta FAIR; 291 citations) |
| Persistent latent state at GSM-8K 89.01% with frozen LLaMA 3.1 8B | Validated | State Stream Transformer arXiv:2501.18356 |
| TRACED displacement + curvature distinguishes hallucination from reasoning | Validated | TRACED arXiv:2603.10384 |
| BeliefShift identifies a real stability/adaptability frontier no current model crosses | Validated | BeliefShift arXiv:2603.23848 |
| AQI as latent-geometry alignment diagnostic | Validated | AQI EMNLP 2025 (ACL Anthology 2025.emnlp-main.145) |
| GHRR non-commutative binding for compositional semantics | Validated | PathHD arXiv:2512.09369 |
| Cognition as field dynamics in a Semantic Force Graph | **Theoretical** | Synthesis of validated anchors into a new architecture |
| Memory as topological deformation of an energy landscape | **Theoretical** | Bio-cognitive precedent (Buzsáki 2010); not LM-scale |
| SGFM as a candidate field formalism for the SFG | **Theoretical** | SGFMs arXiv:2601.08893 are themselves theoretical |
| Neural Barrier Functions for LLM safety in semantic space | **Theoretical** | All CBF work is in physical control; semantic-space CBF is unprecedented |
| "Zero alignment tax" as an unconditional claim | **Demoted** | NSPO's actual language is "mitigating," not "zero" |
| SEAM gradient entanglement at ICLR 2026 | **Cut** | Citation could not be located; treated as unverified |
| Holographic functional encryption at neural-network scale | **Speculative** | Demonstrated data-leakage attacks at scale; remains future work |

The full per-claim ledger is in [`05-claim-calibration.md`](./05-claim-calibration.md).

---

## How CMS-X relates to the other pillars

CMS-X is **not** orthogonal to HELIOS / EML / substrate ideas — it shares structural machinery with each. The connections are:

| CMS-X concept | Maps to | Pillar |
|---|---|---|
| Concept Packet (multi-component node) | Parameter-component decomposition (T28, T31) | HELIOS Connectome |
| GHRR non-commutative binding | Cellular-sheaf compositional consistency (T32) | HELIOS Connectome |
| Damping force as runtime invariant | Attention-as-Interrupt's runtime score (`InterruptScore`) | HELIOS Attention |
| Neural Barrier Functions for safety | Component Edit Safety Bound (T29) | HELIOS Connectome |
| Memory as topological deformation | Storage-disaggregated runtime (E3) — different angle on persistent state | Substrate Ideas |
| SGFM as continuous-field formalism | Stone-Weierstrass density of EML grammar — both reframe computation around continuous-field operators | EML |
| Constitutive safety geometry | `StaticFallbackAcknowledged` source-lint contract — both make safety structural rather than filter-based | Substrate Ideas |
| AQI latent-geometry alignment diagnostic | Goodfire VPD atlas integration | HELIOS |
| TRACED runtime trajectory monitoring | The five-plane formalism's Verification plane | Substrate Ideas |

CMS-X is best read **after** the other pillars. It is the synthesis that names the architectural ambition of which the other pillars are pieces.

---

## What this pillar is not

- It is not the operational substrate. The operational substrate is HELIOS + EML + the runtime invariants in `03-substrate-ideas/`.
- It is not a published paper. CMS-X is at manuscript stage, with explicit Claim Status discipline tracking what has been demonstrated vs. what remains speculative.
- It is not orthogonal to the rest of the work. The connection table above is load-bearing — CMS-X's value is *the synthesis*, not the individual ideas in isolation.
- It is not a marketing document. The Calibration Appendix demotes overclaims (zero-tax → mitigating; SEAM → unverified; HFE → future work) in the same file as the architectural proposal.

---

## Citation lineage (short form)

Full citations and verification dates in [`../REFERENCES.md`](../REFERENCES.md). Headline papers CMS-X depends on:

- **Coconut / Chain of Continuous Thought** — Meta FAIR, arXiv:2412.06769 (291 citations).
- **State Stream Transformer (SST)** — arXiv:2501.18356.
- **TRACED** — arXiv:2603.10384.
- **BeliefShift** — arXiv:2603.23848.
- **PathHD / GHRR** — arXiv:2512.09369.
- **AQI (Alignment Quality Index)** — EMNLP 2025, ACL Anthology 2025.emnlp-main.145.
- **NSPO** — arXiv:2512.11391 (ICLR 2026).
- **Arditi et al. (refusal direction)** — arXiv:2406.11717 (NeurIPS 2024).
- **Anthropic alignment faking 78%** — arXiv:2412.14093.
- **Emergent misalignment in Nature** — Betley et al., Nature 649, 584-589 (2026).
- **What Is the Alignment Tax?** — arXiv:2603.00047 (the elliptic-Pareto frontier paper).
- **The Alignment Trap (5 impossibility pillars)** — arXiv:2506.10304.

Adjacent and challenging:

- **SGFMs** — arXiv:2601.08893 (theoretical only; recorded as candidate formalism).
- **ManifoldFormer** — arXiv:2511.16828 (Riemannian manifold transformers — feasibility precedent).
- **Geometric Dynamics of Agentic Loops** — arXiv:2512.10350.
- **Kona 1.0 / Logical Intelligence** — energy-based reasoning at 96.2% on hard Sudoku in 313ms; Yann LeCun on technical research board (closest competitor).
- **Baier-Reinio et al.** — Neural ODEs do not overcome fixed-depth bounds (formal limitation).

---

## Bottom line

CMS-X is the **architectural ambition** that the rest of the repo's pillars are pieces of. The honest reading is:

- The validated citation base is real (19 of 20 specific anchors verify).
- The synthesis claim — that cognition can be constitutive geometry — is **theoretically motivated but not empirically demonstrated at LM scale**.
- The biggest weak links (SGFM as backbone, Neural ODEs as full backbone, HFE at scale) are explicitly demoted to *future work* in [`05-claim-calibration.md`](./05-claim-calibration.md).
- The strongest version of CMS-X is one that owns its theoretical ambition while clearly delineating what has been proven, what is plausible, and what remains speculative.
