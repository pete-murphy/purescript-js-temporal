module JS.Temporal.Conversions
  ( -- * Pure conversions (projections)
    plainDateTimeToPlainDate
  , plainDateTimeToPlainTime
  , zonedDateTimeToInstant
  , zonedDateTimeToPlainDateTime
  , zonedDateTimeToPlainDate
  , zonedDateTimeToPlainTime
  , plainDateToPlainYearMonth
  , plainDateToPlainMonthDay
  -- * Pure combining
  , plainDateToPlainDateTime
  , instantToZonedDateTimeISO
  -- * Timezone-dependent (Effect)
  , plainDateToZonedDateTime
  , plainDateTimeToZonedDateTime
  , plainYearMonthToPlainDate
  , plainMonthDayToPlainDate
  ) where

import Data.Function.Uncurried (Fn1, Fn2)
import Data.Function.Uncurried as Function.Uncurried
import Effect (Effect)
import Effect.Uncurried (EffectFn2)
import Effect.Uncurried as Effect.Uncurried
import JS.Temporal.Instant (Instant)
import JS.Temporal.PlainDate (PlainDate)
import JS.Temporal.PlainDateTime (PlainDateTime)
import JS.Temporal.PlainMonthDay (PlainMonthDay)
import JS.Temporal.PlainTime (PlainTime)
import JS.Temporal.PlainYearMonth (PlainYearMonth)
import JS.Temporal.ZonedDateTime (ZonedDateTime)

-- Pure conversions (projections)

foreign import _plainDateTimeToPlainDate :: Fn1 PlainDateTime PlainDate

plainDateTimeToPlainDate :: PlainDateTime -> PlainDate
plainDateTimeToPlainDate = Function.Uncurried.runFn1 _plainDateTimeToPlainDate

foreign import _plainDateTimeToPlainTime :: Fn1 PlainDateTime PlainTime

plainDateTimeToPlainTime :: PlainDateTime -> PlainTime
plainDateTimeToPlainTime = Function.Uncurried.runFn1 _plainDateTimeToPlainTime

foreign import _zonedDateTimeToInstant :: Fn1 ZonedDateTime Instant

zonedDateTimeToInstant :: ZonedDateTime -> Instant
zonedDateTimeToInstant = Function.Uncurried.runFn1 _zonedDateTimeToInstant

foreign import _zonedDateTimeToPlainDateTime :: Fn1 ZonedDateTime PlainDateTime

zonedDateTimeToPlainDateTime :: ZonedDateTime -> PlainDateTime
zonedDateTimeToPlainDateTime = Function.Uncurried.runFn1 _zonedDateTimeToPlainDateTime

foreign import _zonedDateTimeToPlainDate :: Fn1 ZonedDateTime PlainDate

zonedDateTimeToPlainDate :: ZonedDateTime -> PlainDate
zonedDateTimeToPlainDate = Function.Uncurried.runFn1 _zonedDateTimeToPlainDate

foreign import _zonedDateTimeToPlainTime :: Fn1 ZonedDateTime PlainTime

zonedDateTimeToPlainTime :: ZonedDateTime -> PlainTime
zonedDateTimeToPlainTime = Function.Uncurried.runFn1 _zonedDateTimeToPlainTime

foreign import _plainDateToPlainYearMonth :: Fn1 PlainDate PlainYearMonth

plainDateToPlainYearMonth :: PlainDate -> PlainYearMonth
plainDateToPlainYearMonth = Function.Uncurried.runFn1 _plainDateToPlainYearMonth

foreign import _plainDateToPlainMonthDay :: Fn1 PlainDate PlainMonthDay

plainDateToPlainMonthDay :: PlainDate -> PlainMonthDay
plainDateToPlainMonthDay = Function.Uncurried.runFn1 _plainDateToPlainMonthDay

-- Pure combining

foreign import _plainDateToPlainDateTime :: Fn2 PlainTime PlainDate PlainDateTime

plainDateToPlainDateTime :: PlainTime -> PlainDate -> PlainDateTime
plainDateToPlainDateTime = Function.Uncurried.runFn2 _plainDateToPlainDateTime

foreign import _instantToZonedDateTimeISO :: Fn2 String Instant ZonedDateTime

instantToZonedDateTimeISO :: String -> Instant -> ZonedDateTime
instantToZonedDateTimeISO = Function.Uncurried.runFn2 _instantToZonedDateTimeISO

-- Timezone-dependent (Effect)

foreign import _plainDateToZonedDateTime :: EffectFn2 String PlainDate ZonedDateTime

plainDateToZonedDateTime :: String -> PlainDate -> Effect ZonedDateTime
plainDateToZonedDateTime = Effect.Uncurried.runEffectFn2 _plainDateToZonedDateTime

foreign import _plainDateTimeToZonedDateTime :: EffectFn2 String PlainDateTime ZonedDateTime

plainDateTimeToZonedDateTime :: String -> PlainDateTime -> Effect ZonedDateTime
plainDateTimeToZonedDateTime = Effect.Uncurried.runEffectFn2 _plainDateTimeToZonedDateTime

foreign import _plainYearMonthToPlainDate :: EffectFn2 { day :: Int } PlainYearMonth PlainDate

plainYearMonthToPlainDate :: { day :: Int } -> PlainYearMonth -> Effect PlainDate
plainYearMonthToPlainDate = Effect.Uncurried.runEffectFn2 _plainYearMonthToPlainDate

foreign import _plainMonthDayToPlainDate :: EffectFn2 { year :: Int } PlainMonthDay PlainDate

plainMonthDayToPlainDate :: { year :: Int } -> PlainMonthDay -> Effect PlainDate
plainMonthDayToPlainDate = Effect.Uncurried.runEffectFn2 _plainMonthDayToPlainDate
