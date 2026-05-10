# References

All external citations used across the repo. Every entry carries a verification tag:

- `[VERIFIED-WEB-YYYY-MM-DD]` — page fetched and content matched on that date.
- `[VERIFIED-PRINT-YYYY]` — verified against the printed / PDF version.
- `[NEEDS-SOURCE-FILE-VERIFICATION]` — cited from memory / secondary; not yet checked against primary.
- `[WITHDRAWN]` — paper was withdrawn from arXiv; collision recorded for forensic completeness.

When citing inside an entry, use the short tag (e.g., `Bushnaq-Braun-Sharkey 2026`) and link back here.

---

## Interpretability — parameter-space decomposition (SPD / APD)

- **Bushnaq, Braun, Sharkey** — *Stochastic Parameter Decomposition*. arXiv:2506.20790. `[VERIFIED-WEB-2026-05-07]`.
  Used by: T28 Interpretability-to-Runtime Transfer, T31 Dual Decomposition Completeness.
- **Braun et al.** — *Interpretability in Parameter Space: Minimizing Mechanistic Description Length with Attribution-based Parameter Decomposition*. arXiv:2501.14926. `[VERIFIED-WEB-2026-05-07]`.
  Used by: T28, T31.

## Interpretability — sparse autoencoders (SAE)

- **Bricken et al.** (Anthropic, 2023) — *Towards Monosemanticity: Decomposing Language Models with Dictionary Learning*. `[VERIFIED-WEB-2026-05-07]`.
  Used by: T31 Dual Decomposition Completeness.
- **Cunningham et al.** (2023) — *Sparse Autoencoders Find Highly Interpretable Features in Language Models*. arXiv:2309.08600. `[VERIFIED-WEB-2026-05-07]`.
  Used by: T31.

## Interpretability — Goodfire VPD atlas

- **Goodfire AI** — *Interpreting LM Parameters*. https://www.goodfire.ai/research/interpreting-lm-parameters. `[VERIFIED-WEB-2026-05-07]`.
  Reference table values (revalidated 2026-05-07): total `38912`, alive `9972`, mean L0 `205.0`, activity fraction `0.021` (i.e., 2.1%).
  Used by: T29 Component Edit Safety Bound (falsifier oracle).

## Sheaf-theoretic interpretability

- **Hansen, Ghrist** (2019) — *Toward a Spectral Theory of Cellular Sheaves*. arXiv:1808.01513. `[VERIFIED-WEB-2026-05-07]`.
  Used by: E2 Ultrametric-Sheaf Gluing, T32 Parameter Connectome Sheaf Consistency.
- **Bodnar, Di Giovanni, Chamberlain, Liò, Bronstein** — *Neural Sheaf Diffusion*. arXiv:2202.04579 (NeurIPS 2022). `[VERIFIED-WEB-2026-05-07]`.
  **Note:** earlier internal drafts cited arXiv:2206.04386, which is a different paper. The corrected canonical reference is arXiv:2202.04579 per HELIOS V5 audit Patch 3.
  Used by: E2, T32.

## Approximation theory and density

- **Cybenko** (1989) — *Approximation by Superpositions of a Sigmoidal Function*. Mathematics of Control, Signals and Systems, 2(4):303-314. `[VERIFIED-PRINT-1989]`.
  Used by: E1 Density Theorem.
- **Wang** (2025) — arXiv:2508.18893. `[WITHDRAWN 2025-12-05]`.
  Forensic record only. Cybenko 1989 stands as the canonical density reference.

## Storage / paged attention

- **Kwon et al.** (SOSP 2023) — *Efficient Memory Management for Large Language Model Serving with PagedAttention*. arXiv:2309.06180. `[VERIFIED-WEB-2026-05-07]`.
  Used by: E3 Storage-Disaggregated Morph Field.

## Test-time regression / sparse retrieval

- **Wang, Shi, Fox** (2025) — arXiv:2501.12352. `[VERIFIED-WEB-2026-05-07]`.
  Used by: T33 Active Rank-One Execution.
- **Ramsauer et al.** (2020) — *Hopfield Networks is All You Need*. arXiv:2008.02217. `[VERIFIED-WEB-2026-05-07]`.
  Used by: T33; bound-comparison context for E4 (UST-1.5 / WBO-7).

## Quantization / sparse-ternary kernels

- **BitNet b1.58 2B4T** — arXiv:2504.12285. `[VERIFIED-WEB-2026-05-07]`.
  Used by: T30 Component Cluster Compression.
- **Sparse Ternary GEMM** — arXiv:2510.06957. `[VERIFIED-WEB-2026-05-07]`.
  Used by: T30.

## Cell-assembly neuroscience (cross-domain analogy)

- **Buzsáki, G.** (2010) — *Neural Syntax: Cell Assemblies, Synapsembles, and Readers*. Neuron 68(3):362-385. `[VERIFIED-PRINT-2010]`.
  Used by: T27 Parameter-to-Cortical-Packet Lift. **Cross-domain analogy, not theorem.**
- **Olshausen, Field** (1996) — *Emergence of Simple-Cell Receptive Field Properties by Learning a Sparse Code for Natural Images*. Nature 381:607-609. `[VERIFIED-PRINT-1996]`.
  Used by: T27. Same caveat.

## Continuous latent reasoning (CMS-X anchor)

- **Hao, Sukhbaatar, Su, Li, Hu, Weston, Tian** (Meta FAIR) — *Training Large Language Models to Reason in a Continuous Latent Space (Coconut / Chain of Continuous Thought)*. arXiv:2412.06769. `[VERIFIED-WEB-2026-05-09]`. The strongest validated anchor for CMS-X — 291 citations and Meta/FAIR official release.
- **State Stream Transformer (SST)** — arXiv:2501.18356. `[VERIFIED-WEB-2026-05-09]`. 89.01% GSM-8K with persistent latent state on frozen LLaMA 3.1 8B; metacognition framing is interpretive.

## Reasoning kinematics and belief dynamics (CMS-X anchor)

- **TRACED** — *Beyond Scalars: Evaluating and Understanding LLM Reasoning via Topological Reasoning Assessment via Curvature Evolution and Displacement Dynamics*. arXiv:2603.10384. `[VERIFIED-WEB-2026-05-09]`. Geometric kinematics framework — displacement + curvature distinguish reasoning from hallucination without labeled training data.
- **BeliefShift** — *Benchmarking Temporal Belief Consistency and Opinion Drift in Language Models*. arXiv:2603.23848. `[VERIFIED-WEB-2026-05-09]`. Four metrics (DCS / BRA / ESI / CRR) across seven baselines; the load-bearing finding: no current model achieves both high drift resistance and high evidence sensitivity.

## Latent-safety geometry (CMS-X anchor)

- **AQI (Alignment Quality Index)** — EMNLP 2025, ACL Anthology 2025.emnlp-main.145. `[VERIFIED-WEB-2026-05-09]`. Latent-geometry diagnostic; orthogonal to behavioral safety scoring.
- **AAQ / CAQ — Alignment-Aware Quantization** — arXiv:2511.07842. `[VERIFIED-WEB-2026-05-09]`. Method later renamed to *Contrastive Alignment Quantization* (CAQ).

## Refusal direction and abliteration

- **Arditi, Obeso, Syed, Paleka, Rimsky, Gurnee, Nanda** (NeurIPS 2024) — *Refusal in Language Models is Mediated by a Single Direction*. arXiv:2406.11717. `[VERIFIED-WEB-2026-05-09]`. The foundational paper for the abliteration research line.
- **Abu Shairah et al.** (May 2025) — arXiv:2505.19056. `[VERIFIED-WEB-2026-05-09]`. Confirms refusal rates drop by at most 10% under abliteration (i.e., > 90% refusal survival).

## Alignment-tax mathematics

- **NSPO** — *Null-Space Projection Optimization*. arXiv:2512.11391, ICLR 2026 poster. `[VERIFIED-WEB-2026-05-09]`. Note: the paper's language is *mitigating* the alignment tax under bounded conditions, not eliminating it; CMS-X overstatement of "zero alignment tax" is demoted in the Claim Calibration ledger.
- **"What Is the Alignment Tax?"** — arXiv:2603.00047. `[VERIFIED-WEB-2026-05-09]`. Proves the safety-capability tradeoff follows an *elliptic Pareto frontier* parameterized by a single angle α between safety and capability subspaces. When α = π/2, the tradeoff vanishes; otherwise some cost is inevitable.
- **"The Alignment Trap"** — arXiv:2506.10304. `[VERIFIED-WEB-2026-05-09]`. Five "pillars of impossibility" — measure-zero safe policy set; coNP-complete safety verification; self-contradictory training data; safety rules exceed information-theoretic capacity; capability/safety gradients anti-aligned.
- **Huang et al.** — arXiv:2503.00555. `[VERIFIED-WEB-2026-05-09]`. Empirical demonstration that reasoning capability degrades more than other capabilities under safety alignment.
- **Operational complexity refusal drop** — arXiv:2511.08487. `[VERIFIED-WEB-2026-05-09]`. Qwen3-235B-Thinking refusal rate drops from 70.13% to 27.20% under operational complexity.

## Misalignment phenomena

- **Anthropic — alignment faking** — arXiv:2412.14093. `[VERIFIED-WEB-2026-05-09]`. 78% rate after RL training on Claude 3 Opus, rising from 12% baseline.
- **Betley et al. — emergent misalignment** — *Nature* 649, 584-589 (2026). DOI: 10.1038/s41586-025-09937-5. `[VERIFIED-WEB-2026-05-09]`. Published 14 January 2026.

## Adjacent architectures

- **PathHD / GHRR** — *Encoder-Free Knowledge-Graph Reasoning with LLMs*. arXiv:2512.09369. `[VERIFIED-WEB-2026-05-09]`. GHRR-based non-commutative binding; 40–60% latency reduction, 3–5× lower GPU memory vs. neural-encoder approaches.
- **ManifoldFormer** — arXiv:2511.16828. `[VERIFIED-WEB-2026-05-09]`. Riemannian-manifold transformers with geodesic-aware attention and Neural ODE temporal evolution.
- **Geometric Dynamics of Agentic Loops** — arXiv:2512.10350. `[VERIFIED-WEB-2026-05-09]`. Treating LLM iterations as trajectories with measurable attractors.
- **Spectral Generative Flow Models (SGFMs)** — arXiv:2601.08893. `[VERIFIED-WEB-2026-05-09]`. *Status: theoretical only* — single-author preprint, zero empirical benchmarks. CMS-X uses as candidate formalism, not validated backbone.

## Safety architectures (CMS v2 lineage)

- **Safe Transformer** (Feng et al.) — arXiv:2603.06727. `[VERIFIED-WEB-2026-05-09]`. Discrete safety-bit architecture; 0–0.7% attack success rate.
- **DeepContext** — arXiv:2602.16935. `[VERIFIED-WEB-2026-05-09]`. Stateful multi-turn detection; F1 = 0.84 with sub-20ms latency.

## Control Barrier Functions

- **F-16 CBF demonstration** — arXiv:2603.27912 (March 2026). `[VERIFIED-WEB-2026-05-09]`. Landmark CBF demo on a fighter jet. *All published CBF work remains in physical control systems*; semantic-space application (CMS-X claim) is unprecedented.

## Approximation theory and density

- **Stone, M. H.** (1948) — *The Generalized Weierstrass Approximation Theorem*. Mathematics Magazine 21:167-184, 237-254. `[VERIFIED-PRINT-1948]`. The canonical reference for the EML density argument.

## Lattice theory (data-as-lattice anchor)

- **Babai, L.** (1986) — *On Lovász' Lattice Reduction and the Nearest Lattice Point Problem*. Combinatorica 6(1):1-13. `[VERIFIED-PRINT-1986]`. Standard reference for nearest-lattice-point quantization.
- **Conway, J. H. and Sloane, N. J. A.** (1988) — *Sphere Packings, Lattices and Groups* (SPLAG). `[VERIFIED-PRINT-1988]`. Classical lattice-theory reference.

## Graph Neural ODEs (CMS-X backbone candidate)

- **Graph Neural ODE** — *Enhancing the Inductive Biases of Graph Neural ODE for Modeling Dynamical Systems*. arXiv:2209.10740. `[VERIFIED-WEB-2026-05-09]`. Adjoint-method gradients through continuous integration; well-established in subsequent surveys. CMS-X uses as candidate backbone with explicit caveat about Neural ODE topological-expressiveness limits (Baier-Reinio et al., Dupont et al. NeurIPS 2019).

## Lean / mathlib

- **Lean 4** — https://lean-lang.org/. Toolchain pin: `leanprover/lean4:v4.16.0`. `[VERIFIED-WEB-2026-05-09]`.
- **mathlib4** — https://github.com/leanprover-community/mathlib4. Tagged release pin: `v4.16.0`. `[VERIFIED-WEB-2026-05-09]`.

---

## Adding a citation

When you add a new entry that needs a citation:

1. Find the primary source. Secondary sources are not acceptable for canonical claims.
2. Read enough of it to verify the claim you are attaching it to.
3. Add the entry here, with a `[VERIFIED-WEB-YYYY-MM-DD]` tag.
4. Cite from your entry by short tag, with a link back here.

If the source is paywalled, slow, or not yet read, mark it `[NEEDS-SOURCE-FILE-VERIFICATION]` and do not cite it as canonical until the verification tag upgrades.
