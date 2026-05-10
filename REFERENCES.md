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
