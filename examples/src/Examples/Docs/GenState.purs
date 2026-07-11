-- | Shared generator state for doc examples that need an arbitrary
-- | datetime value: a fixed seed keeps the generated values (and therefore
-- | the captured example outputs) stable across runs.
module Examples.Docs.GenState (genState) where

import Random.LCG (mkSeed)
import Test.QuickCheck.Gen (GenState)

genState :: GenState
genState = { newSeed: mkSeed 0, size: 10 }
