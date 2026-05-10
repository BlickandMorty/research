---
state: P (provisional — theoretical synthesis; not empirically demonstrated at LM scale)
last-verified: 2026-05-09
---

# Cognition as Constitutive Geometry

> *Concepts as Concept Packets. Reasoning as trajectory evolution. Memory as topological deformation. Safety as topologically entangled with coherence. The Semantic Force Graph is the substrate.*

The thesis. **Theoretical at this lock** — the architectural intuition is novel and the validated citation base is real, but the full architecture has not been built end-to-end at language-model scale.

---

## The position

Transformers are stateless associative retrieval engines. Five architectural vulnerabilities follow:

1. **Statelessness** — no world model maintained between turns; semantic context evaporates.
2. **Geometry-blindness** — no enforcement of geometric constraints on representable states.
3. **Memory-as-retrieval** — "memory" is linear search in a token buffer, not structural deformation.
4. **Safety-as-filter** — moral constraints applied after representation, not to representation.
5. **Hallucination instability** — no damping mechanism; activations can amplify into runaway attractors.

ARC-AGI confirms (1): models experience 2–3× degradation from ARC-AGI-1 to ARC-AGI-2. BeliefShift confirms (3): every tested model either drifts with the user (GPT-4o; high personalization, poor drift resistance) or fails to update on legitimate evidence (Claude 3.5 Sonnet; high fact-grounding, low revision accuracy) — no architecture currently achieves both.

CMS-X claims that all five vulnerabilities are *consequences of the same architectural choice*: treating cognition as stateless function evaluation rather than as the evolution of a persistent geometric field. The proposal is to fix all five at the source.

---

## The Concept Packet

Every node in the Semantic Force Graph (SFG) is a multi-component state object:

```
N_i = (v_sem, v_struct, v_ctx, v_bind, m_i, q_i, k_i, E_i, C_i)
```

| Component | Type | Role |
|---|---|---|
| `v_sem ∈ ℝᵈ` | continuous vector | base semantic meaning; cosine similarity governs attraction |
| `v_struct ∈ ℝᵈ` | continuous vector | syntactic / logical / discourse role, independent of lexical content |
| `v_ctx ∈ ℝᵈ` | continuous vector | contextual trace: decaying history of recent activations |
| `v_bind ∈ ℝᵈ` | GHRR hypervector | compositional fingerprint via non-commutative binding |
| `m_i ∈ ℝ⁺` | scalar | conceptual inertia; resistance to rapid displacement; grows with use |
| `q_i ∈ ℝᵏ` | vector charge | multi-dimensional compatibility signature; governs polarity of forces |
| `k_i ∈ ℝ⁺` | scalar | binding stiffness; cluster cohesion strength; learned and decayable |
| `E_i ∈ ℝ⁺` | scalar | activation cost; energetic threshold to recruit node into active trajectory |
| `C_i` | constraint tag set | CMS v2 moral / epistemic / task constraints |

The binding vector `v_bind` uses **Generalized Holographic Reduced Representations (GHRR)** — block-diagonal unitary representations that provide order-sensitive, non-commutative path binding (PathHD arXiv:2512.09369). Concepts are not just embedded; they are bound to their structural roles so that *"the dog bit the man"* and *"the man bit the dog"* produce entirely different `v_bind` hypervectors despite identical token sets.

PathHD reports 40–60% latency reduction and 3–5× lower GPU memory vs. neural-encoder approaches on knowledge-graph reasoning. That validates GHRR as a binding primitive — it does not validate the full Concept Packet ontology, which is *theoretical*.

---

## Multi-scale tri-manifold topology

The architecture operates across three interconnected manifolds:

- **Layer A — Token Manifold.** Local lexical resolution. Maps input tokens to base semantic vectors `v_sem`. Standard embedding layer; character / subword granularity.
- **Layer B — Sentence Structure Manifold.** Syntactic, logical, and discourse structure. Generates `v_struct` encoding grammatical roles, argument structure, clause relations. *This is what makes CMS-X compositional.*
- **Layer C — Semantic Field State.** The persistent dynamical field. Integrates `v_sem` and `v_struct` via the binding operation:

```
v_sentence = GHRR(v_tokens, v_structure) = v_tokens ⊛ v_structure
```

using GHRR circular convolution (order-sensitive, non-commutative, dimension-preserving). Layer C is the attractor landscape: each stable configuration is a local energy minimum, and reasoning is the trajectory from one minimum to another under the force laws (see [`02-five-force-laws.md`](./02-five-force-laws.md)).

---

## What is validated vs. what is theoretical

**Validated:**
- Continuous latent reasoning is real (Coconut / Chain of Continuous Thought, arXiv:2412.06769; 291 citations).
- Persistent latent state is real (State Stream Transformer, arXiv:2501.18356; 89.01% GSM-8K with frozen LLaMA 3.1 8B).
- GHRR non-commutative binding is real (PathHD).
- LLM trajectories exhibit dynamical-systems properties (ACL 2025 paraphrasing-attractor result).
- Riemannian manifold transformers are technically feasible (ManifoldFormer arXiv:2511.16828).

**Theoretical (synthesis, not empirical):**
- The Concept Packet's full 9-component tuple at LM scale.
- The tri-manifold topology operating end-to-end.
- The full Semantic Force Graph as the operational substrate of a working system.
- All training compute estimates ($45 / $55 / $75 / $30 / $195 buffer per phase) are research-design figures, not validated benchmarks.

The discipline of [`05-claim-calibration.md`](./05-claim-calibration.md) governs the upgrade path from theoretical to validated.

---

## Adversarial attack and defense

> **Attack:** an attacker observes that the Concept Packet has 9 free hyperparameters per node and argues the architecture has too many free parameters to validate. **Defense:** the validation plan in the original manuscript decomposes the architecture into five training phases (representation, dynamics, memory shaping, constraint geometry, adversarial testing), each with falsifier protocols and TRACED-based success metrics. The claim is not "all 9 components must be validated together" — the claim is that each phase has its own falsifier.

> **Attack (subtler):** an attacker constructs an example where the Layer-A / Layer-B decomposition fails — e.g., languages without clear syntactic structure (highly agglutinative or sign languages). **Defense:** Layer B is implemented as a learned syntactic encoder, not a hand-coded grammar. Languages whose syntactic structure is implicit produce `v_struct` vectors with appropriate continuous representations. The decomposition is not a hard partition — it is a continuous structuring of the same underlying vector space.

---

## The strongest engagement with this thesis

The strongest published challenge is **"The Alignment Trap"** (arXiv:2506.10304), which presents five "pillars of impossibility":

1. The safe policy set has measure zero.
2. Verifying safety is coNP-complete.
3. Required training data is self-contradictory.
4. Safety rules exceed network information-theoretic capacity.
5. Capability / safety gradients are generally anti-aligned.

CMS-X must engage with each formally, not rhetorically. The discipline is recorded in [`05-claim-calibration.md`](./05-claim-calibration.md).

A separate challenge: **"What Is the Alignment Tax?"** (arXiv:2603.00047) proves the safety-capability tradeoff follows an *elliptic Pareto frontier parameterized by a single angle α*. When α = π/2, the tradeoff vanishes; otherwise some capability cost is inevitable. CMS-X's "constitutive geometry" framing is consistent with this — it argues that constraint barriers along *natural geodesics* avoid flattening the Riemannian curvature that capable reasoning requires. Whether α is exactly π/2 in practice is empirical and *not yet demonstrated*.
