-- | Compilable doc examples for JS.Temporal.Now.
module Examples.Docs.Now where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Now as Now

exampleInstant :: Effect Unit
exampleInstant = do
  -- [EXAMPLE JS.Temporal.Now.instant]
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.instant
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
  Console.log ("Current instant (UTC): " <> JS.Intl.DateTimeFormat.format formatter now)
  -- [/EXAMPLE]

examplePlainDateISO_ :: Effect Unit
examplePlainDateISO_ = do
  -- [EXAMPLE JS.Temporal.Now.plainDateISO_]
  locale <- JS.Intl.Locale.new_ "en-US"
  today <- Now.plainDateISO_
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log ("Today (local): " <> JS.Intl.DateTimeFormat.format formatter today)
  -- [/EXAMPLE]

examplePlainDateISO :: Effect Unit
examplePlainDateISO = do
  -- [EXAMPLE JS.Temporal.Now.plainDateISO]
  locale <- JS.Intl.Locale.new_ "en-US"
  todayUtc <- Now.plainDateISO "UTC"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log ("Today (UTC): " <> JS.Intl.DateTimeFormat.format formatter todayUtc)
  -- [/EXAMPLE]

examplePlainDateTimeISO_ :: Effect Unit
examplePlainDateTimeISO_ = do
  -- [EXAMPLE JS.Temporal.Now.plainDateTimeISO_]
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.plainDateTimeISO_
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log ("Now (local): " <> JS.Intl.DateTimeFormat.format formatter now)
  -- [/EXAMPLE]

examplePlainDateTimeISO :: Effect Unit
examplePlainDateTimeISO = do
  -- [EXAMPLE JS.Temporal.Now.plainDateTimeISO]
  locale <- JS.Intl.Locale.new_ "en-US"
  nowUtc <- Now.plainDateTimeISO "UTC"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log ("Now (UTC): " <> JS.Intl.DateTimeFormat.format formatter nowUtc)
  -- [/EXAMPLE]

examplePlainTimeISO_ :: Effect Unit
examplePlainTimeISO_ = do
  -- [EXAMPLE JS.Temporal.Now.plainTimeISO_]
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- Now.plainTimeISO_
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log ("Current time (local): " <> JS.Intl.DateTimeFormat.format formatter time)
  -- [/EXAMPLE]

examplePlainTimeISO :: Effect Unit
examplePlainTimeISO = do
  -- [EXAMPLE JS.Temporal.Now.plainTimeISO]
  locale <- JS.Intl.Locale.new_ "en-US"
  timeUtc <- Now.plainTimeISO "UTC"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log ("Current time (UTC): " <> JS.Intl.DateTimeFormat.format formatter timeUtc)
  -- [/EXAMPLE]

exampleZonedDateTimeISO_ :: Effect Unit
exampleZonedDateTimeISO_ = do
  -- [EXAMPLE JS.Temporal.Now.zonedDateTimeISO_]
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.zonedDateTimeISO_
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log ("Now (zoned): " <> JS.Intl.DateTimeFormat.format formatter now)
  -- [/EXAMPLE]

exampleZonedDateTimeISO :: Effect Unit
exampleZonedDateTimeISO = do
  -- [EXAMPLE JS.Temporal.Now.zonedDateTimeISO]
  locale <- JS.Intl.Locale.new_ "en-US"
  nowUtc <- Now.zonedDateTimeISO "UTC"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
  Console.log ("Now (UTC): " <> JS.Intl.DateTimeFormat.format formatter nowUtc)
  -- [/EXAMPLE]

exampleTimeZoneId :: Effect Unit
exampleTimeZoneId = do
  -- [EXAMPLE JS.Temporal.Now.timeZoneId]
  tz <- Now.timeZoneId
  Console.log ("System time zone: " <> tz)
  -- [/EXAMPLE]
