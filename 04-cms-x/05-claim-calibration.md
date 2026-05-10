---
state: index — claim ledger; the BEST distillation of the CMS-X validation companion
last-verified: 2026-05-09
---

# Claim Calibration — The Honest-Limits Ledger

> *Per-claim validation status. The single most important file in this pillar — the discipline that separates the architecture's defensible claims from its overclaims and speculative extensions.*

This file is the public-repo distillation of the CMS-X Claim Ledger / Validation Companion. **It is what makes CMS-X a research artifact rather than a manifesto.** Every claim is graded; every demoted claim has a reason; every cut citation is named.

---

## Claim Status Framework

Four classes (mapped to the repo's status legend):

| CMS-X class | Repo status | Meaning |
|---|---|---|
| **Validated** | EV | Direct empirical support; published benchmark or replicated result |
| **Supported but indirect** | EB | Literature supports the direction; not the specific instantiation at LM scale |
| **Theoretical** | C (definition) or P (claim) | Mathematically motivated; not yet empirically demonstrated at scale |
| **Speculative / future work** | speculative | Recorded as research direction; not load-bearing |
| **Demoted** | DROP | Was a commitment in earlier drafts; demoted with reason |
| **Cut** | DROP | Citation could not be located; treated as unverified |

---

## Per-claim ledger

| Claim | Original wording | Calibrated wording | Class | Action |
|---|---|---|---|---|
| Continuous latent reasoning | "Reasoning occurs in continuous latent space" | "Reasoning *can* occur in continuous latent space" — Coconut validates the core premise; full CMS-X implementation is theoretical | Validated (premise) / Theoretical (instantiation) | Keep |
| Persistent latent state | "SST achieves 89.01% GSM-8K with persistent state" | Direct quote from arXiv:2501.18356; precise number confirmed | Validated | Keep |
| TRACED reasoning kinematics | "TRACED distinguishes reasoning from hallucination" | Replicated in TRACED paper; "metacognition" claims about SST are *interpretive*, not metric output | Validated (TRACED) / Caveat (SST framing) | Keep with caveat |
| BeliefShift frontier | "No current model achieves both high DCS and high BRA" | All four metrics and the dual-failure finding confirmed | Validated | Keep |
| GHRR non-commutative binding | "Order-sensitive composition prevents identity collapse" | PathHD validates GHRR-based encoding; the *full* Concept Packet ontology that uses it is theoretical | Validated (GHRR) / Theoretical (Concept Packet) | Keep |
| AQI as latent-safety diagnostic | "AQI measures geometric separability of safe / unsafe activations" | EMNLP 2025; orthogonal to behavioral scoring; well-defined and replicable | Validated | Keep |
| Refusal mediated by single direction | "Refusal is geometrically trivial" | Arditi et al. NeurIPS 2024; foundational for abliteration research line | Validated | Keep |
| Alignment faking 78% | "Anthropic measured 78% alignment-faking after RL on Claude 3 Opus" | Direct from arXiv:2412.14093; rises from 12% baseline | Validated | Keep |
| Emergent misalignment in Nature | "Nature publication on emergent misalignment" | Confirmed Nature 649, 584-589 (2026); DOI 10.1038/s41586-025-09937-5 | Validated | Keep |
| TurboQuant 6× KV-cache | "6× compression on needle-in-haystack" | Validated on specific benchmarks; practical compression typically 4–5× | Validated with caveat | Keep with caveat |
| Cognition as constitutive geometry | "Cognition itself is constitutive geometry" | Synthesis of validated anchors into a new architecture; not empirically demonstrated end-to-end at LM scale | **Theoretical** | Frame as theoretical |
| Memory as topological deformation | "Replaces context window with structural deformation" | Bio-cognitive precedent (Buzsáki 2010); LM-scale demonstration is future work | **Theoretical** | Frame as theoretical |
| Five-force decomposition | "Attraction, repulsion, binding, damping, constraint" | One candidate force basis; alternatives possible; validation requires Phase-1 prototype | **Theoretical** | Frame as theoretical |
| Topological entanglement of safety + coherence | "Safety removal is provably capability-destructive" | Theoretical claim — bold; not empirically demonstrated; requires formal proof or empirical evidence at scale | **Theoretical** (and the boldest claim CMS-X makes) | Frame as theoretical |
| Spectral Generative Flow Models as backbone | "SGFM provides the field formalism" | SGFMs are themselves theoretical (single-author, zero benchmarks); CMS-X uses them as a *candidate formalism*, not a settled backbone | **Demoted to candidate formalism** | Revise framing |
| Neural ODE backbone sufficiency | "Neural ODEs provide the right backbone" | One candidate; Baier-Reinio et al. prove fixed-depth bound limitations; Dupont et al. NeurIPS 2019 prove trajectories cannot cross | **Demoted to candidate** | Revise framing |
| VSA / HDC global scalability | "VSA can scale as universal memory substrate" | O(√D) capacity limits established; tree-depth scaling exponential; no LLM-scale demonstrations exist (IBM Research, NeSy 2025) | **Demoted** to "strongest as bounded structured binding, not unlimited substrate" | Revise framing |
| Holographic Functional Encryption (HFE) | "HFE secures large-model cognition" | Demonstrated data-leakage attacks (RAID 2025); orders-of-magnitude overhead; limited to simple function classes | **Speculative / future work** | Move to future work |
| Zero alignment tax (NSPO) | "CMS-X eliminates the alignment tax" | NSPO's actual language is "mitigating," not "zero"; CMS-X aims to *mitigate* first-order interference under bounded conditions | **Demoted** to bounded mitigation claim | Revise wording |
| SEAM gradient entanglement (ICLR 2026) | (cited as SEAM at ICLR 2026) | Citation **could not be located** despite exhaustive search of ICLR 2026 paper list, OpenReview, arXiv, web | **Cut** | Remove |

---

## The Alignment Trap engagement

**"The Alignment Trap"** (arXiv:2506.10304) presents five "pillars of impossibility":

1. The safe policy set has measure zero.
2. Verifying safety is coNP-complete.
3. Required training data is self-contradictory.
4. Safety rules exceed network information-theoretic capacity.
5. Capability / safety gradients are generally anti-aligned.

CMS-X must engage with each formally — not rhetorically. The honest reading:

- (1) is a measure-theoretic claim about the *closure* of safe policies in the policy space. CMS-X's response: the field's geometry doesn't operate over the policy space directly; it operates over the trajectory space, where safe trajectories form an open set with positive measure under the constrained dynamics.
- (2) is a complexity claim about *verifying* safety. CMS-X's response: the substrate doesn't claim to verify safety in the worst case; it claims that the *runtime average case* is computationally tractable via TRACED + AQI monitoring. coNP-completeness of worst-case verification does not imply intractability of average-case monitoring.
- (3) is a claim about training data. CMS-X's response: this is the strongest objection. Self-contradictory training data is real. The mitigation is the per-phase falsifier protocol (Representation, Dynamics, Memory, Constraint, Adversarial) which validates each layer independently and detects contradiction at the integration step.
- (4) is an information-theoretic capacity claim. CMS-X's response: the SFG's parameter count includes both the GNN (parameters) and the field state (per-inference state), giving a much larger effective capacity than fixed-parameter networks. Whether this clears the bound is empirical.
- (5) is the alignment-tax claim. CMS-X's response: the elliptic-Pareto frontier (arXiv:2603.00047) shows the tradeoff vanishes only when safety and capability subspaces are exactly orthogonal (α = π/2). CMS-X's "constitutive geometry" framing is consistent with this — barriers along natural geodesics, not flattening curvature — but whether α = π/2 holds in practice is empirical and not yet demonstrated.

**Takeaway:** the Alignment Trap's five pillars are *real* objections. CMS-X has *partial* responses to each. None of the responses is a refutation; some of them are research bets. This is the honest framing.

---

## Funding and execution realism

The original CMS-X drafts cited five funding programs. Reality check (per the validation companion):

| Program | Status | Accessible to independent researcher? |
|---|---|---|
| NSF TechAccess AIRA (NSF 26-508) | active, $168M–$224M total | **No** — state-level workforce program, not individual research grant |
| NSF CyberAI SFS (NSF 26-503) | active | **No** — focus is cybersecurity-AI integration, not alignment; requires faculty appointment |
| DARPA YFA | active | **No** — explicitly requires tenure-track faculty |
| UT-REAL-Health-AI | active, $25M ($15M TX Legislature + $10M UT Regents) | **No** — UT institutional PI required; healthcare AI focus, not safety |
| SBIR / STTR | reauthorized via S. 3971 (March 2026) | Closest match — requires forming a for-profit small business; no current AI-safety-specific topic |

**Realistic alternative funding for an independent researcher:**

- Open Philanthropy (accepts independents)
- Long-Term Future Fund (LTFF)
- Survival and Flourishing Fund
- Affiliating with a Texas university as a research associate (unlocks federal mechanisms)

This is a CMS-X-specific concern, but the discipline of recording it publicly is generalizable: research programs that overstate funding accessibility erode their own credibility.

---

## What demotion does to the architecture

The demotions above are not damage — they are how the architecture survives external scrutiny. The strongest version of CMS-X is one where:

- The **validated citation base** (Coconut, SST, TRACED, BeliefShift, AQI, Arditi, alignment faking, emergent misalignment) is the **anchor**.
- The **theoretical synthesis** (cognition-as-constitutive-geometry, five-force decomposition, memory-as-topology, topological entanglement of safety + coherence) is the **architectural ambition**.
- The **demoted candidates** (SGFM as backbone, Neural ODE sufficiency, VSA universal substrate, zero alignment tax, SEAM, HFE at scale) are *removed from load-bearing claims* and either reframed as candidate formalisms or moved to future work.

The architecture is more credible without the demoted claims than it was with them. That is the lesson the Claim Ledger encodes.

---

## Bottom line

CMS-X v3's citation base is remarkably solid — 19 of 20 specific papers verify with claims confirmed, and several (Coconut, Arditi et al., emergent misalignment in Nature) represent high-impact, well-validated work.

The architecture genuinely occupies an unexplored intersection in the literature: no existing system combines energy-based reasoning, persistent semantic state, geometric safety constraints, and barrier function formalism. **This novelty is the paper's greatest strength and greatest risk simultaneously.**

The strongest version of CMS-X is one that owns its theoretical ambition while clearly delineating what has been proven, what is plausible, and what remains speculative. **That is what this file does.**
