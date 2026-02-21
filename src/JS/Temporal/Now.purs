-- | Methods to obtain the current time in various formats. Corresponds to
-- | the `Temporal.Now` namespace. All functions run in Effect and use the
-- | system's current time.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/Now>
module JS.Temporal.Now
  ( instant
  , zonedDateTimeISO
  , zonedDateTimeISOIn
  , plainDateISO
  , plainDateISOIn
  , plainDateTimeISO
  , plainDateTimeISOIn
  , plainTimeISO
  , plainTimeISOIn
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

foreign import _instant :: Effect Instant

-- | The current instant (nanoseconds since epoch).
instant :: Effect Instant
instant = _instant

foreign import _zonedDateTimeISO :: Effect ZonedDateTime

-- | Current date and time in the system's local time zone.
zonedDateTimeISO :: Effect ZonedDateTime
zonedDateTimeISO = _zonedDateTimeISO

foreign import _zonedDateTimeISOIn :: EffectFn1 String ZonedDateTime

-- | Current date and time in the given time zone.
zonedDateTimeISOIn :: String -> Effect ZonedDateTime
zonedDateTimeISOIn = Effect.Uncurried.runEffectFn1 _zonedDateTimeISOIn

foreign import _plainDateISO :: Effect PlainDate

-- | Current date in the system's local time zone.
plainDateISO :: Effect PlainDate
plainDateISO = _plainDateISO

foreign import _plainDateISOIn :: EffectFn1 String PlainDate

-- | Current date in the given time zone.
plainDateISOIn :: String -> Effect PlainDate
plainDateISOIn = Effect.Uncurried.runEffectFn1 _plainDateISOIn

foreign import _plainDateTimeISO :: Effect PlainDateTime

-- | Current date and time in the system's local time zone (plain, no zone).
plainDateTimeISO :: Effect PlainDateTime
plainDateTimeISO = _plainDateTimeISO

foreign import _plainDateTimeISOIn :: EffectFn1 String PlainDateTime

-- | Current date and time in the given time zone (plain, no zone).
plainDateTimeISOIn :: String -> Effect PlainDateTime
plainDateTimeISOIn = Effect.Uncurried.runEffectFn1 _plainDateTimeISOIn

foreign import _plainTimeISO :: Effect PlainTime

-- | Current time in the system's local time zone.
plainTimeISO :: Effect PlainTime
plainTimeISO = _plainTimeISO

foreign import _plainTimeISOIn :: EffectFn1 String PlainTime

-- | Current time in the given time zone.
plainTimeISOIn :: String -> Effect PlainTime
plainTimeISOIn = Effect.Uncurried.runEffectFn1 _plainTimeISOIn

foreign import _timeZoneId :: Effect String

-- | The system's current time zone identifier (e.g. `"America/New_York"`).
timeZoneId :: Effect String
timeZoneId = _timeZoneId
