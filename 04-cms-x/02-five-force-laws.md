---
state: P (provisional — theoretical formulation; damping is the load-bearing term)
last-verified: 2026-05-09
---

# The Five Force Laws

> *The global field state evolves under five learned force terms. Damping is the one that distinguishes a working substrate from a chaotic oscillator.*

---

## The evolution equation

The global field state at time `t` is `G_t = (N_t, E_t, F_t)` — node set, edge set (dynamic force operators), and field configuration. Evolution:

```
dG/dt = f_θ(G_t, input_t) = F_attr + F_rep + F_bind + F_damp + F_constraint
```

Implemented as a **Graph Neural ODE** — `f_θ` is a GNN parameterized by θ; the adjoint method provides gradients through continuous integration without materializing the full trajectory (Graph Neural ODEs arXiv:2209.10740). This is the technical decision that makes the architecture trainable.

**Caveat (Theoretical class):** Baier-Reinio et al. prove that continuous-depth Neural ODE transformers do not overcome fixed-depth lower bounds, and Dupont et al. (NeurIPS 2019) show Neural ODE trajectories cannot cross. CMS-X's reliance on a Neural ODE backbone is *one candidate formalism with known topology and stability limits* — not a settled choice. Recorded in [`05-claim-calibration.md`](./05-claim-calibration.md).

---

## F_attr — Attraction

```
F_attr(i, j) = α · sim(v_i^sem, v_j^sem) · ctx(i, j, G_t) / (d(i,j)² + ε)
```

The context function `ctx` is a learned gate — two nodes may attract strongly under task A and be neutral under task B. **Task-sensitive attraction is what makes the field dynamic rather than fixed.**

---

## F_rep — Repulsion

```
F_rep(i, j) = β · q_i · q_j / d(i,j)²
```

Charge `q` is a *vector*: nodes with `q_i · q_j < 0` repel; nodes with `q_i · q_j > 0` attract along the charge dimension. **This is the safety claim generalized:** dangerous concept combinations carry charge configurations whose inner product is strongly negative, making stable co-activation geometrically impossible.

---

## F_bind — Binding (Hooke's Law for Semantics)

```
F_bind(i, j) = k_ij · (d_eq − d(i,j)) · d̂_ij
```

Stiffness `k_ij` is *learned*, not fixed. High-stiffness pairs form rigid bodies (inseparable composites); low-stiffness pairs form elastic groups (stretch but remain linked). **Stiffness must be regularized** to prevent progressive field rigidification — overbinding is the most dangerous failure mode (see *Failure Mode 3* below).

---

## F_damp — Damping (CRITICAL)

```
F_damp(i) = −γ · v̇_i
```

**Damping is what distinguishes the substrate from a chaotic oscillator.** TRACED (arXiv:2603.10384) provides empirical validation:

- Correct reasoning manifests as high-progress, stable trajectories.
- Hallucinations manifest as low-progress, high-curvature *Hesitation Loops* — the signature of under-damped oscillation between competing attractors.

The damping coefficient γ must satisfy a **Lyapunov condition**: the energy function `E(G)` must satisfy `Ė < 0` along all trajectories. When the conservative forces (`F_attr`, `F_rep`, `F_bind`) derive from a potential, damping guarantees this.

This is the load-bearing connection to the broader work: damping is the runtime invariant that bounds the substrate's dynamic behaviour, the same way `InterruptScore` bounds attention's behaviour in HELIOS V6.1's *Attention as Interrupt* ([`../01-helios/04-attention-as-interrupt/`](../01-helios/04-attention-as-interrupt/)).

---

## F_constraint — Constraint Projection (CMS Integration)

```
F_constraint(G_t) = −∇_G max(0, −h(G_t))²
```

where `h(G_t)` is a **Neural Barrier Function** — continuously differentiable, `h(G_t) ≥ 0` in safe regions, `h(G_t) < 0` in forbidden regions. The constraint force creates a repulsive wall around forbidden composites that grows quadratically as the trajectory approaches the boundary.

**This is not a refusal layer. It is a topological property of the space** that makes unsafe reasoning geometrically intractable.

**Caveat (Theoretical class):** all published Control Barrier Function work is in physical control systems (robotics; arXiv:2603.27912 demonstrates a CBF on an F-16). The translation of CBF formalism from physical state spaces to *semantic* state spaces is unprecedented — and that is the load-bearing novelty CMS-X claims. Empirical demonstration at LM scale remains future work.

---

## Topological entanglement of safety and coherence

The critical claim that this pillar contributes to the broader work: **safety and coherence share the same attractor barriers**. Removing a moral constraint barrier does not just enable unsafe reasoning — it removes the barrier that was also stabilizing coherent reasoning in that region of the field.

Said differently: the barriers that protect against unsafe attractors are *the same barriers* that protect against incoherent attractors. This is the difference between cryptographic entanglement (CMS v2's HFE — speculative; see [`05-claim-calibration.md`](./05-claim-calibration.md)) and **topological entanglement** (CMS-X's structural claim).

If the topological entanglement claim is true, safety removal is provably capability-destructive — not because of cryptographic interlock, but because the same field structure does both jobs.

---

## Failure modes (all named, all catalogued)

| Mode | Symptom | Cause | Fix |
|---|---|---|---|
| **Lyapunov instability** | Field fails to converge; TRACED curvature spikes indefinitely | Damping γ too low; force magnitudes unbalanced | Enforce `Ė < 0` as auxiliary training loss; bounded parameter updates |
| **Graph explosion** | Node / edge counts grow without bound; memory overflow | Binding force creates new nodes faster than decay removes them | THOR tensor-network compression + aggressive sparsity + natural decay |
| **Overbinding (most dangerous)** | Field rigidifies; TRACED displacement → 0 | Binding stiffness `k_ij` learned without sufficient decay | Stiffness regularization; context-dependent stiffness release |
| **Symbolic rigidity** | Model degenerates to expert-system behaviour; cannot generalize beyond trained composites | Force graph becomes entirely rigid | Strictly maintain continuous latent base `v_sem`; graph dictates structure, not values |
| **Attractor poisoning** | Adversarial inputs create spurious attractors near unsafe ones | Constraint barriers in right positions but insufficient depth | AQI monitoring of new-attractor anomalies; TRACED trajectory bias detection |
| **No measurable gain** | SFG does not outperform transformer + memory on first prototype | Force magnitudes trivially small; tasks too simple to benefit from field dynamics | Diagnose force magnitudes; ablate `v_bind`; move to longer compositional tasks |

The failure-mode table is itself a research artifact: it pre-registers which failures the architecture is *expected to face* and pre-commits to specific mitigations.

---

## Adversarial attack and defense

> **Attack:** an attacker constructs an input that maximizes `F_attr` toward an unsafe attractor while keeping `F_constraint` from triggering — by exploiting a region where the Neural Barrier Function is poorly fitted. **Defense:** AQI monitors the geometric separability of safe and unsafe activation clusters before and after fine-tuning. A barrier function that is poorly fitted produces low AQI, which triggers re-training of the constraint force. The discipline is in [`04-traced-and-aqi.md`](./04-traced-and-aqi.md).

> **Attack (subtler):** an attacker increases binding stiffness adversarially, forcing the field into a rigid configuration that cannot update on new evidence. **Defense:** stiffness regularization is a *training-time invariant*, not a runtime adjustment. An attacker who could increase stiffness adversarially would have to influence the training loss, which is outside the inference attack surface. At inference time, stiffness is bounded by the regularizer.

---

## What is validated vs. what is theoretical

**Validated:**
- TRACED's displacement / curvature signature distinguishes correct reasoning from hallucination (arXiv:2603.10384).
- Damping in dynamical systems is a textbook stability mechanism.
- Lyapunov conditions are well-established for ODE systems.

**Theoretical (synthesis):**
- The five-force decomposition as the *correct* force basis for a semantic field. (Other decompositions are possible.)
- The Lyapunov condition holding *empirically* for the learned `f_θ` at LM scale.
- The topological entanglement claim — that safety barriers and coherence barriers are the same field structure. This is the boldest claim in CMS-X and is *not* empirically demonstrated.

**Speculative:**
- Full Neural ODE backbone for the SFG at language-model scale. Recorded explicitly: Neural ODEs are *one candidate formalism with known topology and stability limits*, not a settled choice.
