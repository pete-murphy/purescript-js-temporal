-- | Compilable doc examples for JS.Temporal.Now.
module Examples.Docs.Now where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Now as Now

-- [EXAMPLE JS.Temporal.Now.instant]
exampleInstant :: Effect Unit
exampleInstant = do
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.instant
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "Africa/Monrovia" }
  Console.log ("Current instant (Africa/Monrovia): " <> JS.Intl.DateTimeFormat.format formatter now)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Now.plainDateISO]
examplePlainDateISO :: Effect Unit
examplePlainDateISO = do
  locale <- JS.Intl.Locale.new_ "en-US"
  today <- Now.plainDateISO
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log ("Today (local): " <> JS.Intl.DateTimeFormat.format formatter today)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Now.plainDateISOWithTimeZone]
examplePlainDateISOWithTimeZone :: Effect Unit
examplePlainDateISOWithTimeZone = do
  locale <- JS.Intl.Locale.new_ "en-US"
  todayTijuana <- Now.plainDateISOWithTimeZone "America/Tijuana"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log ("Today (America/Tijuana): " <> JS.Intl.DateTimeFormat.format formatter todayTijuana)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Now.plainDateTimeISO]
examplePlainDateTimeISO :: Effect Unit
examplePlainDateTimeISO = do
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.plainDateTimeISO
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log ("Now (local): " <> JS.Intl.DateTimeFormat.format formatter now)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Now.plainDateTimeISOWithTimeZone]
examplePlainDateTimeISOWithTimeZone :: Effect Unit
examplePlainDateTimeISOWithTimeZone = do
  locale <- JS.Intl.Locale.new_ "en-US"
  nowUtc <- Now.plainDateTimeISOWithTimeZone "UTC"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log ("Now (UTC): " <> JS.Intl.DateTimeFormat.format formatter nowUtc)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Now.plainTimeISO]
examplePlainTimeISO :: Effect Unit
examplePlainTimeISO = do
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- Now.plainTimeISO
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log ("Current time (local): " <> JS.Intl.DateTimeFormat.format formatter time)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Now.plainTimeISOWithTimeZone]
examplePlainTimeISOWithTimeZone :: Effect Unit
examplePlainTimeISOWithTimeZone = do
  locale <- JS.Intl.Locale.new_ "en-US"
  timeUtc <- Now.plainTimeISOWithTimeZone "UTC"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log ("Current time (UTC): " <> JS.Intl.DateTimeFormat.format formatter timeUtc)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Now.zonedDateTimeISO]
exampleZonedDateTimeISO :: Effect Unit
exampleZonedDateTimeISO = do
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.zonedDateTimeISO
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log ("Now (zoned): " <> JS.Intl.DateTimeFormat.format formatter now)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Now.zonedDateTimeISOWithTimeZone]
exampleZonedDateTimeISOWithTimeZone :: Effect Unit
exampleZonedDateTimeISOWithTimeZone = do
  locale <- JS.Intl.Locale.new_ "en-US"
  nowUtc <- Now.zonedDateTimeISOWithTimeZone "UTC"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
  Console.log ("Now (UTC): " <> JS.Intl.DateTimeFormat.format formatter nowUtc)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Now.timeZoneId]
exampleTimeZoneId :: Effect Unit
exampleTimeZoneId = do
  tz <- Now.timeZoneId
  Console.log ("System time zone: " <> tz)
-- [/EXAMPLE]

