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

instant :: Effect Instant
instant = _instant

foreign import _zonedDateTimeISO :: Effect ZonedDateTime

zonedDateTimeISO :: Effect ZonedDateTime
zonedDateTimeISO = _zonedDateTimeISO

foreign import _zonedDateTimeISOIn :: EffectFn1 String ZonedDateTime

zonedDateTimeISOIn :: String -> Effect ZonedDateTime
zonedDateTimeISOIn = Effect.Uncurried.runEffectFn1 _zonedDateTimeISOIn

foreign import _plainDateISO :: Effect PlainDate

plainDateISO :: Effect PlainDate
plainDateISO = _plainDateISO

foreign import _plainDateISOIn :: EffectFn1 String PlainDate

plainDateISOIn :: String -> Effect PlainDate
plainDateISOIn = Effect.Uncurried.runEffectFn1 _plainDateISOIn

foreign import _plainDateTimeISO :: Effect PlainDateTime

plainDateTimeISO :: Effect PlainDateTime
plainDateTimeISO = _plainDateTimeISO

foreign import _plainDateTimeISOIn :: EffectFn1 String PlainDateTime

plainDateTimeISOIn :: String -> Effect PlainDateTime
plainDateTimeISOIn = Effect.Uncurried.runEffectFn1 _plainDateTimeISOIn

foreign import _plainTimeISO :: Effect PlainTime

plainTimeISO :: Effect PlainTime
plainTimeISO = _plainTimeISO

foreign import _plainTimeISOIn :: EffectFn1 String PlainTime

plainTimeISOIn :: String -> Effect PlainTime
plainTimeISOIn = Effect.Uncurried.runEffectFn1 _plainTimeISOIn

foreign import _timeZoneId :: Effect String

timeZoneId :: Effect String
timeZoneId = _timeZoneId
