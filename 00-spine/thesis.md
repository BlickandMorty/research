# Thesis

> *One page. The unified position the rest of this repo elaborates.*

---

## The position

Modern post-transformer runtimes are increasingly powerful and increasingly opaque. The standard response — bolt-on safety classifiers and refusal-quality fine-tuning — treats safety as a downstream filter on a black-box function. That is the wrong shape.

**Safety is a property of the latent and parameter subspaces.** Build the substrate so that *what counts as harm*, *what counts as a faithful computation*, and *what counts as a static fallback* are first-class invariants — not afterthoughts. Then attention, computation, and storage all become *audit-grade signals* by construction.

Three independent programs argue this position from three different angles.

---

## HELIOS — attention as an interruptible signal

Attention is not a softmax pass. It is an *interrupt-routed* computation, scored against an audit invariant, with a verifiable static fallback. The `AnswerPacket` struct in the runtime emits `attention_mode ∈ {dynamic, static_fallback, unavailable}` as a load-bearing field, and a static fallback that is not acknowledged is rejected by source-lint contract.

**The Parameter Connectome Family (T25–T34)** says the same thing in parameter space: a sparse, faithful decomposition of model parameters lifts to runtime as an active-rank-one execution path; component-level edits bound out-of-edit perplexity drift; the connectome over component clusters carries a cellular sheaf whose global sections coincide with consistent multi-component computations.

The point is *not* a particular kernel. The point is that interpretability gives you a substrate where safety claims become falsifiable in code.

→ [`01-helios/`](../01-helios/)

---

## EML — reconceptualizing computation around `exp − ln`

Elementary scientific computation reduces to a single binary operator: `eml(x, y) = exp(x) − ln(y)`. The grammar `S → 1 | eml(S, S)` is dense in the continuous functions over compact domains by Stone-Weierstrass (coordinates + conjugation + a constant `1`). The `F-ULP-Oracle` is the concrete falsifier: 412,000 log-sampled points, 2 ULP fp16 tolerance, ≤ 90 s wall-clock on M2 Pro 16 GB, oracle reference `oxieml::EmlTree::eval_real`.

If the operator is right, every elementary scientific computation has a single well-defined verification target. The runtime does not need a pile of fused kernels — it needs *one* kernel that passes the oracle. EML reframes the kernel design problem as a Stone-Weierstrass density argument plus an ULP-bounded equivalence check.

What remains open is the constant-free universal-EML question and the citability of the Monnerot `eml*` formulation; both are recorded in `02-eml/07-open-questions/` rather than hidden.

→ [`02-eml/`](../02-eml/)

---

## Substrate ideas — storage and honesty as runtime invariants

Three smaller claims, each independently load-bearing:

1. **Storage-disaggregated runtime (E3).** Resident memory scales with *active patches*, not total archive size: `M_resident(t) ≤ M_core + M_state + M_active(t) + M_cache(t) + M_glue(t)`. SSD as a true RAM extension, validated by an `mmap` arena with a producer/consumer contract and a real RSS check. The PagedAttention paper (Kwon et al., SOSP 2023) is the closest existing literature collision.
2. **Honesty-by-construction.** A static fallback emission must be acknowledged via `ClaimKind::StaticFallbackAcknowledged`; a silent fallback fails source-lint. This is *honesty-as-a-compile-error*.
3. **Five-plane formalism.** State / Episodic / Assembly / Controller / **Verification**. The Verification plane is a hard audit boundary, not a soft observability layer.

→ [`03-substrate-ideas/`](../03-substrate-ideas/)

---

## What this thesis is not

It is not "safety via better classifiers."
It is not "interpretability as a research curiosity."
It is not "post-transformer architectures as a benchmark race."
It is not "let the model decide what counts as harm."

It is *engineering* — at the most fundamental level the substrate exposes — so that harm bounds, faithfulness bounds, and audit invariants are *forced* on every inference step the runtime takes. That is the position. The rest of the repo is the work.
