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
  , zonedDateTimeISO_
  , zonedDateTimeISO
  , plainDateISO_
  , plainDateISO
  , plainDateTimeISO_
  , plainDateTimeISO
  , plainTimeISO_
  , plainTimeISO
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
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | now <- Now.instant
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
-- | Console.log ("Current instant (UTC): " <> JS.Intl.DateTimeFormat.format formatter now)
-- | ```
-- |
-- | ```text
-- | Current instant (UTC): March 8, 2026 at 7:47:31 PM
-- | ```

foreign import instant :: Effect Instant

-- | The system's current time zone identifier (e.g. `"America/New_York"`).
-- |
-- | ```purescript
-- | tz <- Now.timeZoneId
-- | Console.log ("System time zone: " <> tz)
-- | ```
-- |
-- | ```text
-- | System time zone: America/New_York
-- | ```

foreign import timeZoneId :: Effect String

foreign import _zonedDateTimeISO_ :: Effect ZonedDateTime

-- | Current date and time in the system's local time zone.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | now <- Now.zonedDateTimeISO_
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log ("Now (zoned): " <> JS.Intl.DateTimeFormat.format formatter now)
-- | ```
-- |
-- | ```text
-- | Now (zoned): March 8, 2026 at 3:47:31 PM
-- | ```

zonedDateTimeISO_ :: Effect ZonedDateTime
zonedDateTimeISO_ = _zonedDateTimeISO_

foreign import _zonedDateTimeISO :: EffectFn1 String ZonedDateTime

-- | Current date and time in the given time zone.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | nowUtc <- Now.zonedDateTimeISO "UTC"
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
-- | Console.log ("Now (UTC): " <> JS.Intl.DateTimeFormat.format formatter nowUtc)
-- | ```
-- |
-- | ```text
-- | Now (UTC): March 8, 2026 at 7:47:31 PM
-- | ```

zonedDateTimeISO :: String -> Effect ZonedDateTime
zonedDateTimeISO = Effect.Uncurried.runEffectFn1 _zonedDateTimeISO

foreign import _plainDateISO_ :: Effect PlainDate

-- | Current date in the system's local time zone.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | today <- Now.plainDateISO_
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log ("Today (local): " <> JS.Intl.DateTimeFormat.format formatter today)
-- | ```
-- |
-- | ```text
-- | Today (local): March 8, 2026
-- | ```

plainDateISO_ :: Effect PlainDate
plainDateISO_ = _plainDateISO_

foreign import _plainDateISO :: EffectFn1 String PlainDate

-- | Current date in the given time zone.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | todayUtc <- Now.plainDateISO "UTC"
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log ("Today (UTC): " <> JS.Intl.DateTimeFormat.format formatter todayUtc)
-- | ```
-- |
-- | ```text
-- | Today (UTC): March 8, 2026
-- | ```

plainDateISO :: String -> Effect PlainDate
plainDateISO = Effect.Uncurried.runEffectFn1 _plainDateISO

foreign import _plainDateTimeISO_ :: Effect PlainDateTime

-- | Current date and time in the system's local time zone (plain, no zone).
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | now <- Now.plainDateTimeISO_
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log ("Now (local): " <> JS.Intl.DateTimeFormat.format formatter now)
-- | ```
-- |
-- | ```text
-- | Now (local): March 8, 2026 at 3:47:31 PM
-- | ```

plainDateTimeISO_ :: Effect PlainDateTime
plainDateTimeISO_ = _plainDateTimeISO_

foreign import _plainDateTimeISO :: EffectFn1 String PlainDateTime

-- | Current date and time in the given time zone (plain, no zone).
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | nowUtc <- Now.plainDateTimeISO "UTC"
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log ("Now (UTC): " <> JS.Intl.DateTimeFormat.format formatter nowUtc)
-- | ```
-- |
-- | ```text
-- | Now (UTC): March 8, 2026 at 7:47:31 PM
-- | ```

plainDateTimeISO :: String -> Effect PlainDateTime
plainDateTimeISO = Effect.Uncurried.runEffectFn1 _plainDateTimeISO

foreign import _plainTimeISO_ :: Effect PlainTime

-- | Current time in the system's local time zone.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | time <- Now.plainTimeISO_
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
-- | Console.log ("Current time (local): " <> JS.Intl.DateTimeFormat.format formatter time)
-- | ```
-- |
-- | ```text
-- | Current time (local): 3:47:31 PM
-- | ```

plainTimeISO_ :: Effect PlainTime
plainTimeISO_ = _plainTimeISO_

foreign import _plainTimeISO :: EffectFn1 String PlainTime

-- | Current time in the given time zone.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | timeUtc <- Now.plainTimeISO "UTC"
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
-- | Console.log ("Current time (UTC): " <> JS.Intl.DateTimeFormat.format formatter timeUtc)
-- | ```
-- |
-- | ```text
-- | Current time (UTC): 7:47:31 PM
-- | ```

plainTimeISO :: String -> Effect PlainTime
plainTimeISO = Effect.Uncurried.runEffectFn1 _plainTimeISO
