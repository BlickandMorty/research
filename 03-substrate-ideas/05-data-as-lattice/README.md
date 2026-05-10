---
state: P (provisional)
lane: independent — gaming-application avenue
last-verified: 2026-05-09
---

# Data as Lattice — Shared Ontology Across Game Systems

> *Reimagining game data as a single lattice with shared ontology makes save state bit-exact, cross-system interactions decidable, mods composable, and procedural generation a Babai-quantized walk on the lattice.*

The substrate-ideas pillar's entry on the **gaming application** of the broader research program. The same machinery that gives the parameter connectome its sheaf-consistency structure (T32) gives game systems their ontological consistency.

---

## Statement

A game's runtime carries multiple data domains: combat, inventory, narrative state, AI behaviour, world geometry, save state, mod state. The standard architecture treats these as *separate* domains with bespoke serialization, hand-rolled cross-system interactions, and ad-hoc save/load logic.

The data-as-lattice thesis: **make all game data live on a single lattice `L`** — a partially ordered set closed under meet (`⊓`) and join (`⊔`). Every game system reads/writes points of `L`. Every cross-system interaction is a lattice morphism. Save state is a canonical point of `L`. Mods are sublattices.

Three properties drop out:

1. **Save state is bit-exact across versions.** Lattice points are canonical; serialization is the identity (modulo encoding). Save-versioning across game updates is a lattice morphism between the old `L` and the new `L'`.
2. **Cross-system interactions are decidable.** "Does this combat outcome cohere with this narrative state?" reduces to a lattice meet — provable, not heuristic.
3. **Procedural generation has a typed algorithm.** Nearest-lattice-point quantization (Babai 1986) becomes the recipe for "given a constraint, generate the closest valid lattice point that satisfies it."

---

## Why this is a research thesis, not an engineering style

Many engines (especially ECS-based) already share components across systems. That is a *good engineering practice*, but it does not give you a lattice — it gives you a graph of components with hand-rolled compatibility rules.

Data-as-lattice goes one structural step further: the components are *vertices* of a lattice, and the cross-system rules are *meet/join operations* defined by the lattice structure itself. This is what gives you the *decidability* of cross-system interactions — not just convenient access patterns.

The closest precedent in research is **cellular sheaves** (Hansen-Ghrist 2019; Bodnar et al. arXiv:2202.04579), which T32 also uses. The conceptual link: the parameter connectome carries a sheaf whose global sections are consistent multi-component computations. The game-data lattice carries a similar structure whose "consistent multi-system game states" are exactly the lattice points reachable by valid morphisms.

---

## Concrete game-development consequences

Listed concretely so the thesis is not just analogy:

### Save state is bit-exact

Every save is a single canonical lattice point. The serializer hashes the point; deserialization is parse-then-validate against the lattice's type. Save corruption is detected at read; cross-version migration is a typed morphism.

### Cross-system interaction is decidable

When the player's combat action triggers a narrative branch, the engine asks: *given the current lattice point, does this combat outcome admit a consistent narrative continuation?* The answer is a lattice meet between the combat-induced point and the narrative-system's reachable set. If the meet is empty, the action is rejected at type-time, not at runtime.

### ECS architecture is a special case

A standard ECS treats entities as bags of components. Data-as-lattice treats entities as *vertices* of a lattice graph; their components are *coordinates* in the lattice's product structure. ECS becomes a projection of the lattice; "queries" become sublattice selections.

### Procedural generation is Babai-quantized

Procedural asset generation in the data-as-lattice frame is: *given a target description (a region of the lattice), find the nearest lattice point that is a valid asset.* This is exactly the nearest-vector problem in lattice coding (Babai 1986). The State of Beaba RPG concept's "zero external art assets — all sprites, portraits, UI textures generated procedurally at runtime" maps cleanly here.

### Mods are sublattices

A mod that adds new content is a sublattice extension `L → L'`. Mod compatibility is a check that the new sublattice is consistent with the existing lattice's morphisms. Mod conflicts become typed errors, not runtime crashes.

### Multi-language crafting (real Python / TypeScript code)

The Beaba RPG concept proposes a crafting system where the player writes real code (Python, TypeScript) to generate in-game weapons. In the data-as-lattice frame, the player's code is a *lattice morphism* expressed in their language of choice; the game's runtime evaluates the morphism and stamps the resulting lattice point as a craftable item.

### Hidden alignment system

The Beaba RPG's hidden 3-axis alignment (compliance, honesty, autonomy) is a literal 3D sublattice. Player choices are lattice points; branching endings are reachable regions; the *hidden* aspect is that the lattice point is the audit substrate, not the displayed UI. This is the gaming version of the runtime's `attention_mode` audit field — the alignment substrate is structural, not observable.

---

## Adversarial attack and defense

> **Adversarial attack:** an attacker constructs a game system whose state space genuinely cannot be embedded in a lattice — e.g., truly continuous physics state. The attacker claims the data-as-lattice thesis fails to scale. **Defense:** the thesis is over the *discrete* game state — combat, inventory, narrative, AI behaviour, save state. Truly continuous physics lives in a separate plane, the same way the runtime's State plane is separate from the Episodic plane. The lattice structure does not need to absorb every byte of runtime memory; it absorbs the *structured* game state that needs cross-system coherence.

> **Adversarial attack (subtler):** an attacker observes that lattice operations have non-trivial computational cost and argues the engine will be too slow. **Defense:** the lattice operations the engine needs are exactly nearest-vector and meet/join queries; both are well-studied with practical algorithms (Babai 1986; Conway-Sloane SPLAG). The cost is bounded by the lattice dimension, which is bounded by the game's design. A 50-dimensional lattice for a 50-system game is computationally reasonable.

---

## Falsifier protocol

**Hardware:** any (Mac or Linux dev rig).

**Procedure:**

1. Implement a small game prototype with three game systems (combat, inventory, save state) sharing a single lattice.
2. Demonstrate that save/load is bit-exact across runs.
3. Demonstrate that an invalid combat-induced narrative state is rejected at type-time, not runtime.
4. Demonstrate that procedural generation produces lattice points reachable by Babai quantization from a constraint description.

**Pass criterion:** all three demonstrations pass; runtime crash on cross-system inconsistency is replaced by a type-error at the lattice morphism.

**Status:** P. Not yet implemented.

---

## Citation lineage

- **Babai, L.** (1986). *On Lovász' Lattice Reduction and the Nearest Lattice Point Problem*. Combinatorica 6(1):1-13. The standard reference for nearest-lattice-point quantization. `[VERIFIED-PRINT-1986]`.
- **Conway, J. H. and Sloane, N. J. A.** (1988). *Sphere Packings, Lattices and Groups* (SPLAG). The classical lattice-theory reference. `[VERIFIED-PRINT-1988]`.
- **Hansen, J. and Ghrist, R.** (2019). *Toward a Spectral Theory of Cellular Sheaves*. arXiv:1808.01513. The sheaf-consistency machinery this thesis shares with [T32](../../01-helios/03-parameter-connectome-T25-T34/T32-sheaf-consistency.md).
- **Bodnar, C. et al.** (2022). *Neural Sheaf Diffusion*. arXiv:2202.04579 (NeurIPS 2022). Same sheaf substrate, applied to GNNs.

---

## Open questions

- Whether the lattice should be a *bounded* lattice (finite) or *unbounded* (countable but with finite-rank meets/joins) — affects the algorithmic complexity of cross-system interaction queries.
- The relationship between mod sublattices and the parent lattice's invariant structure: when does a mod break a load-bearing game invariant, and how is that detected at lattice-extension time?
- Whether real-time gameplay can actually preserve the lattice discipline at frame budgets, or whether the discipline applies only to non-real-time domains (save / load / mod composition).
- Empirical study: take an existing game's data domains and try to embed them in a lattice. How many domains fit cleanly, and how many resist?

---

## Lane and downstream impact

- **Lane:** independent — this avenue is a gaming application of the substrate, separate from the L1 / L2 / L5 register that governs the inference-runtime pillars.
- **Downstream:** the State of Beaba RPG concept is the design playground. If the thesis holds, it informs the Beaba implementation; if it fails, the thesis is demoted to DROP and the Beaba implementation falls back to a conventional ECS architecture.

The connection back to the inference-runtime substrate (HELIOS) is *structural*, not technical: both ask "when do partial structures glue into a coherent global structure?" and both reach for cellular-sheaf machinery for the answer.
