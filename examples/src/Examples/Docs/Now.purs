-- | Compilable doc examples for JS.Temporal.Now.
module Examples.Docs.Now where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Now as Now

-- | The current instant (nanoseconds since epoch).
exampleInstant :: Effect Unit
exampleInstant = do
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.instant
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "Africa/Monrovia" }
  Console.log ("Current instant (Africa/Monrovia): " <> JS.Intl.DateTimeFormat.format formatter now)

-- | Current date in the system's local time zone.
examplePlainDateISO :: Effect Unit
examplePlainDateISO = do
  locale <- JS.Intl.Locale.new_ "en-US"
  today <- Now.plainDateISO
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log ("Today (local): " <> JS.Intl.DateTimeFormat.format formatter today)

-- | Current date in the given time zone.
examplePlainDateISOWithTimeZone :: Effect Unit
examplePlainDateISOWithTimeZone = do
  locale <- JS.Intl.Locale.new_ "en-US"
  todayTijuana <- Now.plainDateISOWithTimeZone "America/Tijuana"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log ("Today (America/Tijuana): " <> JS.Intl.DateTimeFormat.format formatter todayTijuana)

-- | Current date and time in the system's local time zone (plain, no zone).
examplePlainDateTimeISO :: Effect Unit
examplePlainDateTimeISO = do
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.plainDateTimeISO
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log ("Now (local): " <> JS.Intl.DateTimeFormat.format formatter now)

-- | Current date and time in the given time zone (plain, no zone).
examplePlainDateTimeISOWithTimeZone :: Effect Unit
examplePlainDateTimeISOWithTimeZone = do
  locale <- JS.Intl.Locale.new_ "en-US"
  nowUtc <- Now.plainDateTimeISOWithTimeZone "UTC"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log ("Now (UTC): " <> JS.Intl.DateTimeFormat.format formatter nowUtc)

-- | Current time in the system's local time zone.
examplePlainTimeISO :: Effect Unit
examplePlainTimeISO = do
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- Now.plainTimeISO
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log ("Current time (local): " <> JS.Intl.DateTimeFormat.format formatter time)

-- | Current time in the given time zone.
examplePlainTimeISOWithTimeZone :: Effect Unit
examplePlainTimeISOWithTimeZone = do
  locale <- JS.Intl.Locale.new_ "en-US"
  timeUtc <- Now.plainTimeISOWithTimeZone "UTC"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log ("Current time (UTC): " <> JS.Intl.DateTimeFormat.format formatter timeUtc)

-- | Current date and time in the system's local time zone.
exampleZonedDateTimeISO :: Effect Unit
exampleZonedDateTimeISO = do
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.zonedDateTimeISO
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log ("Now (zoned): " <> JS.Intl.DateTimeFormat.format formatter now)

-- | Current date and time in the given time zone.
exampleZonedDateTimeISOWithTimeZone :: Effect Unit
exampleZonedDateTimeISOWithTimeZone = do
  locale <- JS.Intl.Locale.new_ "en-US"
  nowUtc <- Now.zonedDateTimeISOWithTimeZone "UTC"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
  Console.log ("Now (UTC): " <> JS.Intl.DateTimeFormat.format formatter nowUtc)

-- | The system's current time zone identifier (e.g. `"America/New_York"`).
exampleTimeZoneId :: Effect Unit
exampleTimeZoneId = do
  tz <- Now.timeZoneId
  Console.log ("System time zone: " <> tz)

