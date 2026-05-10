-- Research Canon — Lean 4 substrate.
--
-- Lake project pinning mathlib4 by tagged release. Each theorem lives in
-- its own file under `ResearchCanon/`, with a sorry-budget declared in the
-- file frontmatter and tracked alongside its markdown entry.
--
-- Build:
--   cd lean
--   lake update
--   lake build
--
-- The toolchain pin is `lean-toolchain` (leanprover/lean4:v4.16.0).
-- mathlib4 pin lives below.
--
-- Per repo discipline: a `sorry` is not a failure. A `sorry` without a
-- declared budget cap and a markdown entry pointing to it IS a failure.

import Lake
open Lake DSL

package «research-canon» where
  -- Settings shared across all targets.
  leanOptions := #[
    `pp.unicode.fun ↦ true,
    `autoImplicit ↦ false
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.16.0"

@[default_target]
lean_lib «ResearchCanon» where
  -- Substrate library spanning the three pillars:
  --   ResearchCanon.Helios.*    — substrate canon
  --   ResearchCanon.Eml.*       — computational primitive
  --   ResearchCanon.Substrate.* — five-plane / E3 / honesty
