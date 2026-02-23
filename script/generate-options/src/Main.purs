module Main where

import Prelude

import Control.Monad.Writer as Writer
import Data.Array ((!!))
import Data.Maybe (Maybe(..))
import Data.String as String
import Data.Foldable as Foldable
import Data.Map as Map
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Aff as Aff
import Effect.Exception as Exception
import Node.Encoding (Encoding(..))
import Node.FS.Aff as NodeFS
import Node.FS.Perms as Perms
import Node.Path as Path
import Node.Process as Process
import Partial.Unsafe as Partial.Unsafe
import PureScript.CST.Types (Module)
import Tidy.Codegen as Codegen
import Tidy.Codegen.Monad as Codegen.Monad

type Option = { name :: String, constructors :: Array { name :: String, toString :: String } }

options :: Array Option
options =
  [ { name: "OffsetDisambiguation"
    , constructors:
        [ { name: "Use", toString: "use" }
        , { name: "Ignore", toString: "ignore" }
        , { name: "Reject", toString: "reject" }
        , { name: "Prefer", toString: "prefer" }
        ]
    }
  , { name: "Overflow"
    , constructors:
        [ { name: "Constrain", toString: "constrain" }
        , { name: "Reject", toString: "reject" }
        ]
    }
  , { name: "RoundingMode"
    , constructors:
        [ { name: "Ceil", toString: "ceil" }
        , { name: "Floor", toString: "floor" }
        , { name: "Expand", toString: "expand" }
        , { name: "Trunc", toString: "trunc" }
        , { name: "HalfCeil", toString: "halfCeil" }
        , { name: "HalfFloor", toString: "halfFloor" }
        , { name: "HalfExpand", toString: "halfExpand" }
        , { name: "HalfTrunc", toString: "halfTrunc" }
        , { name: "HalfEven", toString: "halfEven" }
        ]
    }
  , { name: "TemporalUnit"
    , constructors:
        [ { name: "Year", toString: "year" }
        , { name: "Month", toString: "month" }
        , { name: "Week", toString: "week" }
        , { name: "Day", toString: "day" }
        , { name: "Hour", toString: "hour" }
        , { name: "Minute", toString: "minute" }
        , { name: "Second", toString: "second" }
        , { name: "Millisecond", toString: "millisecond" }
        , { name: "Microsecond", toString: "microsecond" }
        , { name: "Nanosecond", toString: "nanosecond" }
        ]
    }
  , { name: "Disambiguation"
    , constructors:
        [ { name: "Compatible", toString: "compatible" }
        , { name: "Earlier", toString: "earlier" }
        , { name: "Later", toString: "later" }
        , { name: "Reject", toString: "reject" }
        ]
    }
  , { name: "CalendarName"
    , constructors:
        [ { name: "Auto", toString: "auto" }
        , { name: "Always", toString: "always" }
        , { name: "Never", toString: "never" }
        , { name: "Critical", toString: "critical" }
        ]
    }
  ]

makeModule :: String -> Option -> Module Void
makeModule moduleName option = Partial.Unsafe.unsafePartial do
  Codegen.Monad.codegenModule moduleName do
    Codegen.Monad.exportTypeAll option.name
    Codegen.Monad.exportValue "toString"
    Codegen.Monad.exportValue "fromString"

    Codegen.Monad.importOpen "Prelude"
    maybe <- Codegen.Monad.importFrom "Data.Maybe" (Codegen.Monad.importType "Maybe")
    just <- Codegen.Monad.importFrom "Data.Maybe" (Codegen.Monad.importCtor "Maybe" "Just")
    nothing <- Codegen.Monad.importFrom "Data.Maybe" (Codegen.Monad.importCtor "Maybe" "Nothing")

    Writer.tell
      [ Codegen.declData option.name []
          (option.constructors <#> \{ name } -> Codegen.dataCtor name [])

      , Codegen.declDerive Nothing [] "Eq" [ Codegen.typeCtor option.name ]

      , Codegen.declSignature "toString" do
          Codegen.typeForall [] do
            Codegen.typeArrow [ Codegen.typeCtor option.name ] (Codegen.typeCtor "String")

      , Codegen.declValue "toString" [] do
          Codegen.exprCase [ Codegen.exprSection ]
            ( option.constructors <#> \{ name, toString } ->
                Codegen.caseBranch [ Codegen.binderCtor name [] ] do
                  Codegen.exprString toString
            )

      , Codegen.declSignature "fromString" do
          Codegen.typeForall [] do
            Codegen.typeArrow [ Codegen.typeCtor "String" ] (Codegen.typeApp (Codegen.typeCtor maybe) [ Codegen.typeCtor option.name ])

      , Codegen.declValue "fromString" [] do
          Codegen.exprCase [ Codegen.exprSection ] do
            ( option.constructors <#> \{ name, toString } ->
                Codegen.caseBranch [ Codegen.binderString toString ] do
                  Codegen.exprApp (Codegen.exprCtor just) [ Codegen.exprCtor name ]
            ) <> [ Codegen.caseBranch [ Codegen.binderWildcard ] (Codegen.exprCtor nothing) ]
      ]

main :: Effect Unit
main = do
  let
    duplicateOptionNames =
      options
        <#> (\option -> (Tuple option.name 1))
        # Map.fromFoldableWith (+)
        # Map.filter (_ > 1)

  unless (Map.isEmpty duplicateOptionNames) do
    Exception.throw ("Duplicate option names: " <> Foldable.intercalate ", " (Map.keys duplicateOptionNames))

  rootDirectory <- Process.argv <#> (_ !! 2) >>= case _ of
    Just path -> Path.resolve [] path
    Nothing -> Exception.throw "Expected path to project root as first argument"
  let
    modulePath = [ "JS", "Temporal", "Options" ]
    directoryPath = Path.concat ([ rootDirectory, "src" ] <> modulePath)
  Aff.launchAff_ do
    NodeFS.mkdir' directoryPath { recursive: true, mode: Perms.mkPerms Perms.all Perms.read Perms.read }
    Foldable.for_ options \option -> do
      let
        moduleName = String.joinWith "." (modulePath <> [ option.name ])
        module_ = makeModule moduleName option
        filePath = Path.concat [ directoryPath, option.name <> ".purs" ]
        contents =
          String.joinWith "\n"
            [ "-- *** DO NOT EDIT! ***"
            , "-- This module is generated by `just generate-options`"
            , ""
            , Codegen.printModuleWithOptions (Codegen.defaultPrintOptions { pageWidth = 80 }) module_
            ]
      NodeFS.writeTextFile UTF8 filePath contents
