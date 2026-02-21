module Test.Main (main) where

import Prelude

import Data.Foldable as Foldable
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console as Console
import JS.BigInt as BigInt
import JS.Temporal.CalendarName as CalendarName
import JS.Temporal.Disambiguation as Disambiguation
import JS.Temporal.Duration as Duration
import JS.Temporal.Instant as Instant
import JS.Temporal.Now as Now
import JS.Temporal.Overflow as Overflow
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainMonthDay as PlainMonthDay
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.PlainYearMonth as PlainYearMonth
import JS.Temporal.RoundingMode as RoundingMode
import JS.Temporal.TemporalUnit as TemporalUnit
import JS.Temporal.ZonedDateTime as ZonedDateTime
import Test.Assert.Extended as Test

main :: Effect Unit
main = do
  test_PlainDate
  test_PlainTime
  test_PlainDateTime
  test_PlainYearMonth
  test_PlainMonthDay
  test_Duration
  test_Instant
  test_ZonedDateTime
  test_Now
  test_TemporalUnit
  test_Overflow
  test_RoundingMode
  test_Disambiguation
  test_CalendarName

-- PlainDate
test_PlainDate :: Effect Unit
test_PlainDate = do
  Console.log "PlainDate.new"
  plainDate <- PlainDate.new 2026 2 21
  Test.assertEqual
    { actual: PlainDate.toString {} plainDate
    , expected: "2026-02-21"
    }

  Console.log "PlainDate.from_"
  fromDate <- PlainDate.from_ "2024-01-15"
  Test.assertEqual
    { actual: PlainDate.year fromDate
    , expected: 2024
    }
  Test.assertEqual
    { actual: PlainDate.month fromDate
    , expected: 1
    }
  Test.assertEqual
    { actual: PlainDate.day fromDate
    , expected: 15
    }

  Console.log "PlainDate properties"
  Test.assertEqual
    { actual: PlainDate.monthCode plainDate
    , expected: "M02"
    }
  Test.assertEqual
    { actual: PlainDate.dayOfWeek plainDate
    , expected: 6
    }
  Test.assertEqual
    { actual: PlainDate.daysInMonth plainDate
    , expected: 28
    }
  Test.assertEqual
    { actual: PlainDate.daysInYear plainDate
    , expected: 365
    }
  Test.assertEqual
    { actual: PlainDate.inLeapYear plainDate
    , expected: false
    }

  Console.log "PlainDate.add / subtract"
  duration <- Duration.new { days: 7 }
  added <- PlainDate.add_ duration plainDate
  Test.assertEqual
    { actual: PlainDate.toString {} added
    , expected: "2026-02-28"
    }
  subtracted <- PlainDate.subtract_ duration plainDate
  Test.assertEqual
    { actual: PlainDate.toString {} subtracted
    , expected: "2026-02-14"
    }

  Console.log "PlainDate.until_ / since_"
  otherDate <- PlainDate.new 2026 3 1
  untilDuration <- PlainDate.until_ otherDate plainDate
  Test.assertEqual
    { actual: Duration.days untilDuration
    , expected: 8
    }
  sinceDuration <- PlainDate.since_ otherDate plainDate
  Test.assertEqual
    { actual: Duration.days sinceDuration
    , expected: (-8)
    }

  Console.log "PlainDate.with"
  withDate <- PlainDate.with { day: 1 } plainDate
  Test.assertEqual
    { actual: PlainDate.day withDate
    , expected: 1
    }

  Console.log "PlainDate.toPlainDateTime"
  plainTime <- PlainTime.new { hour: 12, minute: 30, second: 0, millisecond: 0, microsecond: 0, nanosecond: 0 }
  dateTime <- pure (PlainDate.toPlainDateTime plainTime plainDate)
  Test.assertEqual
    { actual: PlainDateTime.toString {} dateTime
    , expected: "2026-02-21T12:30:00"
    }

-- PlainTime
test_PlainTime :: Effect Unit
test_PlainTime = do
  Console.log "PlainTime.new"
  plainTime <- PlainTime.new { hour: 14, minute: 30, second: 45, millisecond: 123, microsecond: 456, nanosecond: 789 }
  Test.assertEqual
    { actual: PlainTime.hour plainTime
    , expected: 14
    }
  Test.assertEqual
    { actual: PlainTime.minute plainTime
    , expected: 30
    }
  Test.assertEqual
    { actual: PlainTime.second plainTime
    , expected: 45
    }
  Test.assertEqual
    { actual: PlainTime.millisecond plainTime
    , expected: 123
    }

  Console.log "PlainTime.from_"
  fromTime <- PlainTime.from_ "09:15:30.500"
  Test.assertEqual
    { actual: PlainTime.hour fromTime
    , expected: 9
    }
  Test.assertEqual
    { actual: PlainTime.minute fromTime
    , expected: 15
    }
  Test.assertEqual
    { actual: PlainTime.second fromTime
    , expected: 30
    }
  Test.assertEqual
    { actual: PlainTime.millisecond fromTime
    , expected: 500
    }

  Console.log "PlainTime.toString"
  Test.assertEqual
    { actual: PlainTime.toString { fractionalSecondDigits: 3 } plainTime
    , expected: "14:30:45.123"
    }

  Console.log "PlainTime.add / subtract"
  duration <- Duration.new { hours: 2 }
  added <- PlainTime.add duration plainTime
  Test.assertEqual
    { actual: PlainTime.hour added
    , expected: 16
    }
  subtracted <- PlainTime.subtract duration plainTime
  Test.assertEqual
    { actual: PlainTime.hour subtracted
    , expected: 12
    }

  Console.log "PlainTime.until_ / since_"
  otherTime <- PlainTime.new { hour: 16, minute: 0, second: 0, millisecond: 0, microsecond: 0, nanosecond: 0 }
  untilDuration <- PlainTime.until_ otherTime plainTime
  Test.assertEqual
    { actual: Duration.hours untilDuration
    , expected: 1
    }
  Test.assertEqual
    { actual: Duration.minutes untilDuration
    , expected: 29
    }

  Console.log "PlainTime.round"
  rounded <- PlainTime.round { smallestUnit: TemporalUnit.Minute } plainTime
  Test.assertEqual
    { actual: PlainTime.minute rounded
    , expected: 31
    }

-- PlainDateTime
test_PlainDateTime :: Effect Unit
test_PlainDateTime = do
  Console.log "PlainDateTime.new"
  plainDateTime <- PlainDateTime.new { year: 2026, month: 2, day: 21, hour: 14, minute: 30, second: 0, millisecond: 0, microsecond: 0, nanosecond: 0 }
  Test.assertEqual
    { actual: PlainDateTime.toString {} plainDateTime
    , expected: "2026-02-21T14:30:00"
    }

  Console.log "PlainDateTime.from_"
  fromDateTime <- PlainDateTime.from_ "2024-12-25T23:59:59.999"
  Test.assertEqual
    { actual: PlainDateTime.year fromDateTime
    , expected: 2024
    }
  Test.assertEqual
    { actual: PlainDateTime.month fromDateTime
    , expected: 12
    }
  Test.assertEqual
    { actual: PlainDateTime.day fromDateTime
    , expected: 25
    }
  Test.assertEqual
    { actual: PlainDateTime.hour fromDateTime
    , expected: 23
    }
  Test.assertEqual
    { actual: PlainDateTime.minute fromDateTime
    , expected: 59
    }
  Test.assertEqual
    { actual: PlainDateTime.second fromDateTime
    , expected: 59
    }
  Test.assertEqual
    { actual: PlainDateTime.millisecond fromDateTime
    , expected: 999
    }

  Console.log "PlainDateTime.toString with options"
  Test.assertEqual
    { actual: PlainDateTime.toString { fractionalSecondDigits: 3 } plainDateTime
    , expected: "2026-02-21T14:30:00.000"
    }

  Console.log "PlainDateTime.add / subtract"
  duration <- Duration.new { days: 1, hours: 1 }
  added <- PlainDateTime.add_ duration plainDateTime
  Test.assertEqual
    { actual: PlainDateTime.day added
    , expected: 22
    }
  Test.assertEqual
    { actual: PlainDateTime.hour added
    , expected: 15
    }

  Console.log "PlainDateTime.toPlainDate / toPlainTime"
  Test.assertEqual
    { actual: PlainDate.toString {} (PlainDateTime.toPlainDate plainDateTime)
    , expected: "2026-02-21"
    }
  Test.assertEqual
    { actual: PlainTime.toString {} (PlainDateTime.toPlainTime plainDateTime)
    , expected: "14:30:00"
    }

  Console.log "PlainDateTime.round"
  rounded <- PlainDateTime.round { smallestUnit: TemporalUnit.Hour } plainDateTime
  Test.assertEqual
    { actual: PlainDateTime.hour rounded
    , expected: 15
    }

-- PlainYearMonth
test_PlainYearMonth :: Effect Unit
test_PlainYearMonth = do
  Console.log "PlainYearMonth.new"
  plainYearMonth <- PlainYearMonth.new 2026 2
  Test.assertEqual
    { actual: PlainYearMonth.year plainYearMonth
    , expected: 2026
    }
  Test.assertEqual
    { actual: PlainYearMonth.month plainYearMonth
    , expected: 2
    }
  Test.assertEqual
    { actual: PlainYearMonth.toString {} plainYearMonth
    , expected: "2026-02"
    }

  Console.log "PlainYearMonth.from_"
  fromYearMonth <- PlainYearMonth.from_ "2024-12"
  Test.assertEqual
    { actual: PlainYearMonth.year fromYearMonth
    , expected: 2024
    }
  Test.assertEqual
    { actual: PlainYearMonth.month fromYearMonth
    , expected: 12
    }

  Console.log "PlainYearMonth.daysInMonth / daysInYear"
  Test.assertEqual
    { actual: PlainYearMonth.daysInMonth plainYearMonth
    , expected: 28
    }
  Test.assertEqual
    { actual: PlainYearMonth.daysInYear plainYearMonth
    , expected: 365
    }

  Console.log "PlainYearMonth.add / subtract"
  duration <- Duration.new { months: 3 }
  added <- PlainYearMonth.add_ duration plainYearMonth
  Test.assertEqual
    { actual: PlainYearMonth.month added
    , expected: 5
    }

  Console.log "PlainYearMonth.toPlainDate"
  toDate <- PlainYearMonth.toPlainDate { day: 15 } plainYearMonth
  Test.assertEqual
    { actual: PlainDate.toString {} toDate
    , expected: "2026-02-15"
    }

-- PlainMonthDay
test_PlainMonthDay :: Effect Unit
test_PlainMonthDay = do
  Console.log "PlainMonthDay.new"
  plainMonthDay <- PlainMonthDay.new 12 25
  Test.assertEqual
    { actual: PlainMonthDay.monthCode plainMonthDay
    , expected: "M12"
    }
  Test.assertEqual
    { actual: PlainMonthDay.day plainMonthDay
    , expected: 25
    }
  Test.assertEqual
    { actual: PlainMonthDay.toString {} plainMonthDay
    , expected: "12-25"
    }

  Console.log "PlainMonthDay.from_"
  fromMonthDay <- PlainMonthDay.from_ "02-29"
  Test.assertEqual
    { actual: PlainMonthDay.monthCode fromMonthDay
    , expected: "M02"
    }
  Test.assertEqual
    { actual: PlainMonthDay.day fromMonthDay
    , expected: 29
    }

  Console.log "PlainMonthDay.toPlainDate"
  toDate <- PlainMonthDay.toPlainDate { year: 2024 } plainMonthDay
  Test.assertEqual
    { actual: PlainDate.toString {} toDate
    , expected: "2024-12-25"
    }

  Console.log "PlainMonthDay.with"
  withMonthDay <- PlainMonthDay.with { day: 31 } plainMonthDay
  Test.assertEqual
    { actual: PlainMonthDay.day withMonthDay
    , expected: 31
    }

-- Duration
test_Duration :: Effect Unit
test_Duration = do
  Console.log "Duration.new"
  duration <- Duration.new { days: 7, hours: 12 }
  Test.assertEqual
    { actual: Duration.days duration
    , expected: 7
    }
  Test.assertEqual
    { actual: Duration.hours duration
    , expected: 12
    }
  Test.assertEqual
    { actual: Duration.toString {} duration
    , expected: "P7DT12H"
    }

  Console.log "Duration.from"
  fromDuration <- Duration.from "P1Y2M3DT4H5M6S"
  Test.assertEqual
    { actual: Duration.years fromDuration
    , expected: 1
    }
  Test.assertEqual
    { actual: Duration.months fromDuration
    , expected: 2
    }
  Test.assertEqual
    { actual: Duration.days fromDuration
    , expected: 3
    }
  Test.assertEqual
    { actual: Duration.hours fromDuration
    , expected: 4
    }
  Test.assertEqual
    { actual: Duration.minutes fromDuration
    , expected: 5
    }
  Test.assertEqual
    { actual: Duration.seconds fromDuration
    , expected: 6
    }

  Console.log "Duration.add / subtract"
  other <- Duration.new { days: 1 }
  added <- Duration.add duration other
  Test.assertEqual
    { actual: Duration.days added
    , expected: 8
    }
  subtracted <- Duration.subtract other duration
  Test.assertEqual
    { actual: Duration.days subtracted
    , expected: 6
    }

  Console.log "Duration.negated / abs"
  negative <- Duration.new { days: -5 }
  Test.assertEqual
    { actual: Duration.days (Duration.negated negative)
    , expected: 5
    }
  Test.assertEqual
    { actual: Duration.days (Duration.abs negative)
    , expected: 5
    }

  Console.log "Duration.sign / blank"
  Test.assertEqual
    { actual: Duration.sign duration
    , expected: 1
    }
  Test.assertEqual
    { actual: Duration.sign negative
    , expected: -1
    }
  zeroDuration <- Duration.new { days: 0 }
  Test.assertEqual
    { actual: Duration.blank zeroDuration
    , expected: true
    }

  Console.log "Duration.compare"
  comparison <- Duration.compare duration other
  Test.assertEqual
    { actual: comparison
    , expected: GT
    }

  Console.log "Duration.total"
  totalSeconds <- Duration.total { unit: TemporalUnit.Second } duration
  Test.assertEqual
    { actual: totalSeconds
    , expected: 648000.0
    }

-- Instant
test_Instant :: Effect Unit
test_Instant = do
  Console.log "Instant.from"
  instant <- Instant.from "2026-02-21T12:00:00Z"
  Test.assertEqual
    { actual: Instant.toString {} instant
    , expected: "2026-02-21T12:00:00Z"
    }

  Console.log "Instant.fromEpochMilliseconds"
  epochInstant <- Instant.fromEpochMilliseconds 1000000.0
  Test.assertEqual
    { actual: Instant.epochMilliseconds epochInstant
    , expected: 1000000.0
    }

  Console.log "Instant.fromEpochNanoseconds"
  let bigInt = BigInt.fromInt 1000000000
  nanoInstant <- Instant.fromEpochNanoseconds bigInt
  Test.assertEqual
    { actual: Instant.epochMilliseconds nanoInstant
    , expected: 1000.0
    }

  Console.log "Instant.add / subtract"
  duration <- Duration.new { hours: 1 }
  added <- Instant.add duration instant
  Test.assertEqual
    { actual: Instant.toString {} added
    , expected: "2026-02-21T13:00:00Z"
    }
  subtracted <- Instant.subtract duration instant
  Test.assertEqual
    { actual: Instant.toString {} subtracted
    , expected: "2026-02-21T11:00:00Z"
    }

  Console.log "Instant.until_ / since_"
  otherInstant <- Instant.from "2026-02-21T14:00:00Z"
  untilDuration <- Instant.until_ otherInstant instant
  Test.assertEqual
    { actual: Duration.seconds untilDuration
    , expected: 7200
    }

  Console.log "Instant.toZonedDateTimeISO"
  zoned <- pure (Instant.toZonedDateTimeISO "UTC" instant)
  Test.assertEqual
    { actual: ZonedDateTime.offset zoned
    , expected: "+00:00"
    }

  Console.log "Instant.round"
  rounded <- Instant.round { smallestUnit: TemporalUnit.Minute } instant
  Test.assertEqual
    { actual: Instant.toString {} rounded
    , expected: "2026-02-21T12:00:00Z"
    }

-- ZonedDateTime
test_ZonedDateTime :: Effect Unit
test_ZonedDateTime = do
  Console.log "ZonedDateTime.from_"
  zonedDateTime <- ZonedDateTime.from_ "2026-02-21T12:00:00-08:00[America/Los_Angeles]"
  Test.assertEqual
    { actual: ZonedDateTime.year zonedDateTime
    , expected: 2026
    }
  Test.assertEqual
    { actual: ZonedDateTime.month zonedDateTime
    , expected: 2
    }
  Test.assertEqual
    { actual: ZonedDateTime.day zonedDateTime
    , expected: 21
    }
  Test.assertEqual
    { actual: ZonedDateTime.hour zonedDateTime
    , expected: 12
    }
  Test.assertEqual
    { actual: ZonedDateTime.offset zonedDateTime
    , expected: "-08:00"
    }

  Console.log "ZonedDateTime.toString"
  Test.assertEqual
    { actual: ZonedDateTime.offset zonedDateTime
    , expected: "-08:00"
    }

  Console.log "ZonedDateTime.add / subtract"
  duration <- Duration.new { days: 1 }
  added <- ZonedDateTime.add_ duration zonedDateTime
  Test.assertEqual
    { actual: ZonedDateTime.day added
    , expected: 22
    }

  Console.log "ZonedDateTime.toInstant / toPlainDateTime"
  instant <- pure (ZonedDateTime.toInstant zonedDateTime)
  Test.assertEqual
    { actual: Instant.toString {} instant
    , expected: "2026-02-21T20:00:00Z"
    }
  plainDateTime <- pure (ZonedDateTime.toPlainDateTime zonedDateTime)
  Test.assertEqual
    { actual: PlainDateTime.toString {} plainDateTime
    , expected: "2026-02-21T12:00:00"
    }

  Console.log "ZonedDateTime.startOfDay"
  startOfDay <- ZonedDateTime.startOfDay zonedDateTime
  Test.assertEqual
    { actual: ZonedDateTime.hour startOfDay
    , expected: 0
    }
  Test.assertEqual
    { actual: ZonedDateTime.minute startOfDay
    , expected: 0
    }
  Test.assertEqual
    { actual: ZonedDateTime.second startOfDay
    , expected: 0
    }

  Console.log "ZonedDateTime.withTimeZone"
  utcZoned <- ZonedDateTime.withTimeZone "UTC" zonedDateTime
  Test.assertEqual
    { actual: ZonedDateTime.offset utcZoned
    , expected: "+00:00"
    }

-- Now
test_Now :: Effect Unit
test_Now = do
  Console.log "Now.instant"
  nowInstant <- Now.instant
  Test.assert (Instant.toString {} nowInstant /= "")

  Console.log "Now.plainDateISO"
  plainDate <- Now.plainDateISO
  Test.assertEqual
    { actual: PlainDate.year plainDate >= 1970 && PlainDate.year plainDate < 2100
    , expected: true
    }

  Console.log "Now.plainTimeISO"
  plainTime <- Now.plainTimeISO
  Test.assert (PlainTime.hour plainTime >= 0 && PlainTime.hour plainTime < 24)

  Console.log "Now.plainDateISOIn"
  utcDate <- Now.plainDateISOIn "UTC"
  Test.assertEqual
    { actual: PlainDate.year utcDate >= 1970 && PlainDate.year utcDate < 2100
    , expected: true
    }

  Console.log "Now.zonedDateTimeISO"
  zoned <- Now.zonedDateTimeISO
  Test.assert (ZonedDateTime.year zoned >= 1970 && ZonedDateTime.year zoned < 2100)

-- TemporalUnit
test_TemporalUnit :: Effect Unit
test_TemporalUnit = do
  Console.log "TemporalUnit.toString"
  Test.assertEqual
    { actual: TemporalUnit.toString TemporalUnit.Year
    , expected: "year"
    }
  Test.assertEqual
    { actual: TemporalUnit.toString TemporalUnit.Day
    , expected: "day"
    }
  Test.assertEqual
    { actual: TemporalUnit.toString TemporalUnit.Hour
    , expected: "hour"
    }
  Test.assertEqual
    { actual: TemporalUnit.toString TemporalUnit.Second
    , expected: "second"
    }

  Console.log "TemporalUnit.fromString"
  Test.assertEqualWith (map TemporalUnit.toString >>> show)
    { actual: TemporalUnit.fromString "month"
    , expected: Just TemporalUnit.Month
    }
  Test.assertEqualWith (map TemporalUnit.toString >>> show)
    { actual: TemporalUnit.fromString "invalid"
    , expected: Nothing
    }

  Foldable.for_ [ TemporalUnit.Year, TemporalUnit.Month, TemporalUnit.Week, TemporalUnit.Day, TemporalUnit.Hour, TemporalUnit.Minute, TemporalUnit.Second, TemporalUnit.Millisecond, TemporalUnit.Microsecond, TemporalUnit.Nanosecond ] \unit ->
    Test.assertEqualWith (map TemporalUnit.toString >>> show)
      { actual: TemporalUnit.fromString (TemporalUnit.toString unit)
      , expected: Just unit
      }

-- Overflow
test_Overflow :: Effect Unit
test_Overflow = do
  Console.log "Overflow.toString"
  Test.assertEqual
    { actual: Overflow.toString Overflow.Constrain
    , expected: "constrain"
    }
  Test.assertEqual
    { actual: Overflow.toString Overflow.Reject
    , expected: "reject"
    }

  Console.log "Overflow.fromString"
  Test.assertEqualWith (map Overflow.toString >>> show)
    { actual: Overflow.fromString "constrain"
    , expected: Just Overflow.Constrain
    }
  Test.assertEqualWith (map Overflow.toString >>> show)
    { actual: Overflow.fromString "reject"
    , expected: Just Overflow.Reject
    }

-- RoundingMode
test_RoundingMode :: Effect Unit
test_RoundingMode = do
  Console.log "RoundingMode.toString"
  Test.assertEqual
    { actual: RoundingMode.toString RoundingMode.HalfEven
    , expected: "halfEven"
    }
  Test.assertEqual
    { actual: RoundingMode.toString RoundingMode.Floor
    , expected: "floor"
    }
  Test.assertEqual
    { actual: RoundingMode.toString RoundingMode.Ceil
    , expected: "ceil"
    }

  Console.log "RoundingMode.fromString"
  Test.assertEqualWith (map RoundingMode.toString >>> show)
    { actual: RoundingMode.fromString "halfEven"
    , expected: Just RoundingMode.HalfEven
    }

  Foldable.for_ [ RoundingMode.Ceil, RoundingMode.Floor, RoundingMode.Expand, RoundingMode.Trunc, RoundingMode.HalfCeil, RoundingMode.HalfFloor, RoundingMode.HalfExpand, RoundingMode.HalfTrunc, RoundingMode.HalfEven ] \mode ->
    Test.assertEqualWith (map RoundingMode.toString >>> show)
      { actual: RoundingMode.fromString (RoundingMode.toString mode)
      , expected: Just mode
      }

-- Disambiguation
test_Disambiguation :: Effect Unit
test_Disambiguation = do
  Console.log "Disambiguation.toString"
  Test.assertEqual
    { actual: Disambiguation.toString Disambiguation.Compatible
    , expected: "compatible"
    }
  Test.assertEqual
    { actual: Disambiguation.toString Disambiguation.Earlier
    , expected: "earlier"
    }
  Test.assertEqual
    { actual: Disambiguation.toString Disambiguation.Later
    , expected: "later"
    }
  Test.assertEqual
    { actual: Disambiguation.toString Disambiguation.Reject
    , expected: "reject"
    }

-- CalendarName
test_CalendarName :: Effect Unit
test_CalendarName = do
  Console.log "CalendarName.toString"
  Test.assertEqual
    { actual: CalendarName.toString CalendarName.Always
    , expected: "always"
    }
  Test.assertEqual
    { actual: CalendarName.toString CalendarName.Auto
    , expected: "auto"
    }
  Test.assertEqual
    { actual: CalendarName.toString CalendarName.Never
    , expected: "never"
    }
