-- | Methods to obtain the current time in various formats. Corresponds to
-- | the `Temporal.Now` namespace. All functions run in Effect and use the
-- | system's current time.
-- |
-- | Functions with a trailing underscore use the system's local time zone.
-- | Functions without the underscore take an explicit time zone string.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/Now>
module JS.Temporal.Now
  ( instant
  , zonedDateTimeISO
  , zonedDateTimeISOWithTimeZone
  , plainDateISO
  , plainDateISOWithTimeZone
  , plainDateTimeISO
  , plainDateTimeISOWithTimeZone
  , plainTimeISO
  , plainTimeISOWithTimeZone
  , timeZoneId
  ) where

import Effect (Effect)
import Effect.Uncurried (EffectFn1)
import Effect.Uncurried as Effect.Uncurried
import JS.Temporal.Instant (Instant)
import JS.Temporal.PlainDate (PlainDate)
import JS.Temporal.PlainDateTime (PlainDateTime)
import JS.Temporal.PlainTime (PlainTime)
import JS.Temporal.ZonedDateTime (ZonedDateTime)

-- | The current instant (nanoseconds since epoch).
-- |
-- | ```purescript
-- | exampleInstant :: Effect Unit
-- | exampleInstant = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   now <- Now.instant
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "Africa/Monrovia" }
-- |   Console.log ("Current instant (Africa/Monrovia): " <> JS.Intl.DateTimeFormat.format formatter now)
-- | ```
-- | ---
-- | ```text
-- | Current instant (Africa/Monrovia): July 11, 2026 at 1:19:14 PM
-- | ```
foreign import instant :: Effect Instant

-- | The system's current time zone identifier (e.g. `"America/New_York"`).
-- |
-- | ```purescript
-- | exampleTimeZoneId :: Effect Unit
-- | exampleTimeZoneId = do
-- |   tz <- Now.timeZoneId
-- |   Console.log ("System time zone: " <> tz)
-- | ```
-- | ---
-- | ```text
-- | System time zone: America/New_York
-- | ```
foreign import timeZoneId :: Effect String

foreign import _zonedDateTimeISO :: Effect ZonedDateTime

-- | Current date and time in the system's local time zone.
-- |
-- | ```purescript
-- | exampleZonedDateTimeISO :: Effect Unit
-- | exampleZonedDateTimeISO = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   now <- Now.zonedDateTimeISO
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- |   Console.log ("Now (zoned): " <> JS.Intl.DateTimeFormat.format formatter now)
-- | ```
-- | ---
-- | ```text
-- | Now (zoned): July 11, 2026 at 9:19:14 AM
-- | ```
zonedDateTimeISO :: Effect ZonedDateTime
zonedDateTimeISO = _zonedDateTimeISO

foreign import _zonedDateTimeISOWithTimeZone :: EffectFn1 String ZonedDateTime

-- | Current date and time in the given time zone.
-- |
-- | ```purescript
-- | exampleZonedDateTimeISOWithTimeZone :: Effect Unit
-- | exampleZonedDateTimeISOWithTimeZone = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   nowUtc <- Now.zonedDateTimeISOWithTimeZone "UTC"
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
-- |   Console.log ("Now (UTC): " <> JS.Intl.DateTimeFormat.format formatter nowUtc)
-- | ```
-- | ---
-- | ```text
-- | Now (UTC): July 11, 2026 at 1:19:14 PM
-- | ```
zonedDateTimeISOWithTimeZone :: String -> Effect ZonedDateTime
zonedDateTimeISOWithTimeZone = Effect.Uncurried.runEffectFn1 _zonedDateTimeISOWithTimeZone

foreign import _plainDateISO :: Effect PlainDate

-- | Current date in the system's local time zone.
-- |
-- | ```purescript
-- | examplePlainDateISO :: Effect Unit
-- | examplePlainDateISO = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   today <- Now.plainDateISO
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log ("Today (local): " <> JS.Intl.DateTimeFormat.format formatter today)
-- | ```
-- | ---
-- | ```text
-- | Today (local): July 11, 2026
-- | ```
plainDateISO :: Effect PlainDate
plainDateISO = _plainDateISO

foreign import _plainDateISOWithTimeZone :: EffectFn1 String PlainDate

-- | Current date in the given time zone.
-- |
-- | ```purescript
-- | examplePlainDateISOWithTimeZone :: Effect Unit
-- | examplePlainDateISOWithTimeZone = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   todayTijuana <- Now.plainDateISOWithTimeZone "America/Tijuana"
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log ("Today (America/Tijuana): " <> JS.Intl.DateTimeFormat.format formatter todayTijuana)
-- | ```
-- | ---
-- | ```text
-- | Today (America/Tijuana): July 11, 2026
-- | ```
plainDateISOWithTimeZone :: String -> Effect PlainDate
plainDateISOWithTimeZone = Effect.Uncurried.runEffectFn1 _plainDateISOWithTimeZone

foreign import _plainDateTimeISO :: Effect PlainDateTime

-- | Current date and time in the system's local time zone (plain, no zone).
-- |
-- | ```purescript
-- | examplePlainDateTimeISO :: Effect Unit
-- | examplePlainDateTimeISO = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   now <- Now.plainDateTimeISO
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- |   Console.log ("Now (local): " <> JS.Intl.DateTimeFormat.format formatter now)
-- | ```
-- | ---
-- | ```text
-- | Now (local): July 11, 2026 at 9:19:14 AM
-- | ```
plainDateTimeISO :: Effect PlainDateTime
plainDateTimeISO = _plainDateTimeISO

foreign import _plainDateTimeISOWithTimeZone :: EffectFn1 String PlainDateTime

-- | Current date and time in the given time zone (plain, no zone).
-- |
-- | ```purescript
-- | examplePlainDateTimeISOWithTimeZone :: Effect Unit
-- | examplePlainDateTimeISOWithTimeZone = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   nowUtc <- Now.plainDateTimeISOWithTimeZone "UTC"
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- |   Console.log ("Now (UTC): " <> JS.Intl.DateTimeFormat.format formatter nowUtc)
-- | ```
-- | ---
-- | ```text
-- | Now (UTC): July 11, 2026 at 1:19:14 PM
-- | ```
plainDateTimeISOWithTimeZone :: String -> Effect PlainDateTime
plainDateTimeISOWithTimeZone = Effect.Uncurried.runEffectFn1 _plainDateTimeISOWithTimeZone

foreign import _plainTimeISO :: Effect PlainTime

-- | Current time in the system's local time zone.
-- |
-- | ```purescript
-- | examplePlainTimeISO :: Effect Unit
-- | examplePlainTimeISO = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   time <- Now.plainTimeISO
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
-- |   Console.log ("Current time (local): " <> JS.Intl.DateTimeFormat.format formatter time)
-- | ```
-- | ---
-- | ```text
-- | Current time (local): 9:19:14 AM
-- | ```
plainTimeISO :: Effect PlainTime
plainTimeISO = _plainTimeISO

foreign import _plainTimeISOWithTimeZone :: EffectFn1 String PlainTime

-- | Current time in the given time zone.
-- |
-- | ```purescript
-- | examplePlainTimeISOWithTimeZone :: Effect Unit
-- | examplePlainTimeISOWithTimeZone = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   timeUtc <- Now.plainTimeISOWithTimeZone "UTC"
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
-- |   Console.log ("Current time (UTC): " <> JS.Intl.DateTimeFormat.format formatter timeUtc)
-- | ```
-- | ---
-- | ```text
-- | Current time (UTC): 1:19:14 PM
-- | ```
plainTimeISOWithTimeZone :: String -> Effect PlainTime
plainTimeISOWithTimeZone = Effect.Uncurried.runEffectFn1 _plainTimeISOWithTimeZone
