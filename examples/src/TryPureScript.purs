-- This is a stub
module TryPureScript
  ( render
  , withConsole
  ) where

import Prelude

import Effect (Effect)

render :: forall doc. doc -> Effect Unit
render _ = pure unit

withConsole :: Effect Unit -> Effect Unit
withConsole action = action
