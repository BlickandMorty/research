-- Research Canon — top-level Lean library entry.
--
-- Imports the per-pillar substrate stubs so `lake build` checks them all.
-- Each theorem stub carries its own sorry-budget cap declared in the file
-- doc-comment; the cap is tracked alongside the markdown entry that names
-- the stub.
--
-- Layout:
--   ResearchCanon.Helios.Connectome.*   — T28, T29, T32 stubs
--   ResearchCanon.Helios.Interrupt.*    — interrupt invariant stub
--   ResearchCanon.Eml.*                 — operator, grammar, density
--   ResearchCanon.Substrate.*           — E3, five-plane invariants

import ResearchCanon.Helios.Connectome.T29EditSafetyBound
import ResearchCanon.Helios.Connectome.T28RuntimeTransfer
import ResearchCanon.Helios.Connectome.T32SheafConsistency
import ResearchCanon.Helios.Interrupt.InterruptInvariant
import ResearchCanon.Eml.Operator
import ResearchCanon.Eml.Grammar
import ResearchCanon.Eml.Density
import ResearchCanon.Substrate.E3StorageDisaggregated
import ResearchCanon.CMSX.NeuralBarrierFunction
