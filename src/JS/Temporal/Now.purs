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
foreign import instant :: Effect Instant

-- | The system's current time zone identifier (e.g. `"America/New_York"`).
foreign import timeZoneId :: Effect String

foreign import _zonedDateTimeISO_ :: Effect ZonedDateTime

-- | Current date and time in the system's local time zone.
zonedDateTimeISO_ :: Effect ZonedDateTime
zonedDateTimeISO_ = _zonedDateTimeISO_

foreign import _zonedDateTimeISO :: EffectFn1 String ZonedDateTime

-- | Current date and time in the given time zone.
zonedDateTimeISO :: String -> Effect ZonedDateTime
zonedDateTimeISO = Effect.Uncurried.runEffectFn1 _zonedDateTimeISO

foreign import _plainDateISO_ :: Effect PlainDate

-- | Current date in the system's local time zone.
plainDateISO_ :: Effect PlainDate
plainDateISO_ = _plainDateISO_

foreign import _plainDateISO :: EffectFn1 String PlainDate

-- | Current date in the given time zone.
plainDateISO :: String -> Effect PlainDate
plainDateISO = Effect.Uncurried.runEffectFn1 _plainDateISO

foreign import _plainDateTimeISO_ :: Effect PlainDateTime

-- | Current date and time in the system's local time zone (plain, no zone).
plainDateTimeISO_ :: Effect PlainDateTime
plainDateTimeISO_ = _plainDateTimeISO_

foreign import _plainDateTimeISO :: EffectFn1 String PlainDateTime

-- | Current date and time in the given time zone (plain, no zone).
plainDateTimeISO :: String -> Effect PlainDateTime
plainDateTimeISO = Effect.Uncurried.runEffectFn1 _plainDateTimeISO

foreign import _plainTimeISO_ :: Effect PlainTime

-- | Current time in the system's local time zone.
plainTimeISO_ :: Effect PlainTime
plainTimeISO_ = _plainTimeISO_

foreign import _plainTimeISO :: EffectFn1 String PlainTime

-- | Current time in the given time zone.
plainTimeISO :: String -> Effect PlainTime
plainTimeISO = Effect.Uncurried.runEffectFn1 _plainTimeISO
