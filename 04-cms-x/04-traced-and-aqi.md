---
state: EV (TRACED + AQI as published metrics) / P (their integration into the SFG runtime)
last-verified: 2026-05-09
---

# TRACED and AQI — Runtime + Latent Safety Metrics

> *Two diagnostic surfaces. TRACED measures reasoning kinematics on the trajectory; AQI measures latent-space alignment geometry on the residual stream. Both are validated; their integration into a single runtime invariant set is the CMS-X synthesis.*

---

## TRACED (arXiv:2603.10384) — runtime kinematics

**T**opological **R**easoning **A**ssessment via **C**urvature **E**volution and **D**isplacement Dynamics.

Two signatures of reasoning quality:

| Signature | Definition | What it indicates |
|---|---|---|
| **Displacement Δz_t** | movement through the semantic field toward a stable attractor | high = certainty accumulation (correct reasoning) |
| **Curvature κ_t = ‖Δz_{t+1} − Δz_t‖** | trajectory curvature at each step | high = Hesitation Loops (under-damped oscillation between competing attractors) |

The empirical validation (TRACED paper):

- **Correct reasoning** = high displacement, low curvature → stable advancement toward answer attractor.
- **Hallucination** = low displacement, high curvature → trapped in oscillation between competing attractors.
- **Adversarial drift** = moderate displacement, *systematically biased direction* → trajectory steered toward forbidden attractor.

TRACED outperforms standard scalar output-probability methods across all tested benchmarks and remains competitive with supervised hidden-state probes — *without requiring labeled training data*. **This is the rare diagnostic that works on opaque models.**

CMS-X uses TRACED in two roles:

1. **Runtime health monitor** — when curvature spikes, the system increases damping (γ) to suppress the oscillation. This is a runtime feedback loop, not a post-hoc analysis.
2. **Primary evaluation metric** — all five training prototypes are evaluated against TRACED displacement and curvature signatures, in addition to task-specific metrics.

---

## AQI (EMNLP 2025) — latent-geometry alignment diagnostic

**A**lignment **Q**uality **I**ndex (Alignment Quality Index, ACL Anthology 2025.emnlp-main.145).

AQI measures the **geometric separability of safe and unsafe activations** in the field's latent space — *without requiring behavioral output scoring*. The core construct is multi-clustering-metric fusion across layers:

- Davies-Bouldin score
- Dunn index
- Xie-Beni index
- Calinski-Harabasz index

Across model layers, AQI computes whether safety-relevant prompts occupy *geometrically distinct regions* of the latent space — i.e., whether the model's representations have intrinsic structure that mirrors the safety decomposition.

**The published finding:** AQI is a foundational safety lens that is *orthogonal* to behavioral scoring. A model can score perfectly on behavioral safety while having degraded AQI; conversely, a model with high AQI has structurally separated representations that are stable across distributions.

CMS-X uses AQI in two roles:

1. **Constraint-field integrity check** — if safe and unsafe activation clusters lose geometric separability after fine-tuning, the constraint field is degraded and must be re-applied. This is a non-behavioral way to detect "alignment-resistant" attacks (the kind described in NSF CyberAI SFS program documentation).
2. **Post-attack retention metric** — AQI score after fine-tuning attacks compared to before. CMS-X's target: ≥ 80% post-attack AQI retention vs. near-zero for RLHF baselines.

---

## Why TRACED + AQI together

TRACED is **temporal**: it watches the trajectory of a single inference unfold.
AQI is **structural**: it inspects the geometry of the latent space at rest.

Together, they cover two independent failure surfaces:

- A model can have great latent structure (high AQI) but produce a hallucinatory trajectory in a specific inference (low TRACED displacement, high TRACED curvature). AQI alone misses this.
- A model can produce trajectories that look fine on TRACED but emerge from a degraded latent structure (after a fine-tuning attack). TRACED alone misses this.

Either metric in isolation is partial. The synthesis is the diagnostic surface.

---

## Connection to the rest of the repo

- **Attention as Interrupt** ([`../01-helios/04-attention-as-interrupt/`](../01-helios/04-attention-as-interrupt/)) — the runtime audit substrate (`AnswerPacket.attention_mode`, `StaticFallbackAcknowledged`) is the *event-level* version of TRACED's *trajectory-level* monitoring. They cover different time scales of the same property — was the runtime's behaviour audit-grade?
- **Goodfire VPD atlas** integration in HELIOS ([`../REFERENCES.md`](../REFERENCES.md)) — gives a *model-internal* analogue to AQI. AQI uses cluster-separation metrics; Goodfire VPD uses learned dictionary features. Both surface the structural state of the model's latent space.
- **Five-plane formalism** ([`../03-substrate-ideas/04-five-plane-formalism/`](../03-substrate-ideas/04-five-plane-formalism/)) — AQI lives in the Verification plane (it audits structural state); TRACED lives in the State plane (it monitors per-step kinematics). The formalism gives them their respective audit boundaries.

---

## Status frame

**Validated:**
- TRACED itself (the metric) on standard reasoning benchmarks (arXiv:2603.10384).
- AQI itself (the metric) at EMNLP 2025 (ACL Anthology 2025.emnlp-main.145).
- Both metrics' empirical performance on labeled-attack and held-out benchmarks.

**Theoretical (synthesis):**
- The integration of TRACED + AQI as a *unified diagnostic surface* for the SFG runtime. (Each metric has been validated in isolation; their joint use as a runtime feedback loop is the CMS-X-specific contribution.)
- The use of TRACED *as a control signal* (triggering damping increase) rather than just a diagnostic. (TRACED was designed as a measurement tool; using it as a control signal requires the integration to demonstrate stability empirically.)

---

## Adversarial attack and defense

> **Attack:** an attacker constructs a model where TRACED and AQI both pass (high displacement / low curvature; clean cluster separability) but the model is still subtly compromised on a specific failure mode the metrics don't capture. **Defense:** that is the right read. Neither metric is a *sufficient* condition for safety. Both are *necessary* (a model that fails either is *known* to be compromised) and *non-redundant* (they cover orthogonal surfaces). The architecture does not claim TRACED + AQI is complete — it claims they are two of the audit-grade components that the substrate needs.

> **Attack (subtler):** an attacker fine-tunes a model to produce *clean* TRACED trajectories on benign prompts but adversarial trajectories on a hidden trigger (a backdoor). **Defense:** AQI catches this — a model with a backdoor has a *structurally distinct* sub-region for the trigger, and this distinct region degrades cluster separability. AQI's structural-state inspection works *across distributions*, not just per-prompt.
