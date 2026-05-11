module Test.Main where

import Prelude

import Data.Array as Array
import Effect (Effect)
import Effect.Console as Console
import Node.Process as Process
import Test.Unit as Unit
import Test.Properties as Properties
import Test.Invariants as Invariants

main :: Effect Unit
main = do
  args <- Process.argv
  let checkInvariants = Array.elem "--check-invariants" args
  Unit.run
  Properties.run
  if checkInvariants then do
    Invariants.run
    Console.log ""
    Console.log "All tests passed (including invariant checks)!"
  else do
    Console.log ""
    Console.log "All tests passed! (run with --check-invariants for codebase checks)"
