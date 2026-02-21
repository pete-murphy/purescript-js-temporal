module Test.Main (main) where

import Prelude

import Control.Monad.Rec.Class (Step(..), tailRecM)
import Data.Date.Gen (genDate)
import Data.Time.Gen (genTime)
import Data.DateTime.Gen (genDateTime)
import Data.DateTime.Instant as DateTime.Instant
import Data.Foldable as Foldable
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Exception (error, throwException)
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
import Random.LCG (randomSeed)
import Test.Assert.Extended as Test
import Test.QuickCheck.Gen (runGen)

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
  test_DateTimeInterop

-- PlainDate
test_PlainDate :: Effect Unit
test_PlainDate = do
  Console.log "PlainDate.new"
  plainDate <- PlainDate.new 2026 2 21
  Test.assertEqual
    { actual: PlainDate.toString_ plainDate
    , expected: "2026-02-21"
    }
  Test.assertEqual
    { actual: PlainDate.toString { calendarName: CalendarName.Never } plainDate
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

  Console.log "PlainDate.from with overflow"
  constrainDate <- PlainDate.from { overflow: Overflow.Constrain } "2024-01-15"
  Test.assertEqual
    { actual: PlainDate.day constrainDate
    , expected: 15
    }
  rejectDate <- PlainDate.from { overflow: Overflow.Reject } "2024-01-15"
  Test.assertEqual
    { actual: PlainDate.day rejectDate
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
    { actual: PlainDate.toString_ added
    , expected: "2026-02-28"
    }
  subtracted <- PlainDate.subtract_ duration plainDate
  Test.assertEqual
    { actual: PlainDate.toString_ subtracted
    , expected: "2026-02-14"
    }
  addedWithOpts <- PlainDate.add { overflow: Overflow.Constrain } duration plainDate
  Test.assertEqual
    { actual: PlainDate.toString_ addedWithOpts
    , expected: "2026-02-28"
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
  untilWithOpts <- PlainDate.until { largestUnit: TemporalUnit.Day } otherDate plainDate
  Test.assertEqual
    { actual: Duration.days untilWithOpts
    , expected: 8
    }

  Console.log "PlainDate.with_ / with"
  withDate <- PlainDate.with_ { day: 1 } plainDate
  withDateOpts <- PlainDate.with { overflow: Overflow.Constrain } { day: 1 } plainDate
  Test.assertEqual
    { actual: PlainDate.day withDate
    , expected: 1
    }
  Test.assertEqual
    { actual: PlainDate.day withDateOpts
    , expected: 1
    }

  Console.log "PlainDate.toPlainDateTime"
  plainTime <- PlainTime.new { hour: 12, minute: 30, second: 0, millisecond: 0, microsecond: 0, nanosecond: 0 }
  dateTime <- pure (PlainDate.toPlainDateTime plainTime plainDate)
  Test.assertEqual
    { actual: PlainDateTime.toString_ dateTime
    , expected: "2026-02-21T12:30:00"
    }

  Console.log "PlainDate.toZonedDateTime"
  zoned <- PlainDate.toZonedDateTime "America/New_York" plainDate
  Test.assertEqual
    { actual: ZonedDateTime.timeZoneId zoned
    , expected: "America/New_York"
    }
  Test.assertEqual
    { actual: PlainDate.toString_ (ZonedDateTime.toPlainDate zoned)
    , expected: "2026-02-21"
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

  Console.log "PlainTime.from with overflow"
  constrainTime <- PlainTime.from { overflow: Overflow.Constrain } "09:15:30.500"
  Test.assertEqual
    { actual: PlainTime.hour constrainTime
    , expected: 9
    }

  Console.log "PlainTime.toString"
  Test.assertEqual
    { actual: PlainTime.toString { fractionalSecondDigits: 3 } plainTime
    , expected: "14:30:45.123"
    }
  Test.assertEqual
    { actual: PlainTime.toString { smallestUnit: TemporalUnit.Millisecond } plainTime
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
  untilWithOpts <- PlainTime.until { smallestUnit: TemporalUnit.Minute } otherTime plainTime
  Test.assertEqual
    { actual: Duration.hours untilDuration
    , expected: 1
    }
  Test.assertEqual
    { actual: Duration.minutes untilDuration
    , expected: 29
    }
  Test.assertEqual
    { actual: Duration.hours untilWithOpts
    , expected: 1
    }

  Console.log "PlainTime.round"
  rounded <- PlainTime.round { smallestUnit: TemporalUnit.Minute } plainTime
  Test.assertEqual
    { actual: PlainTime.minute rounded
    , expected: 31
    }
  roundedWithMode <- PlainTime.round { smallestUnit: TemporalUnit.Second, roundingMode: RoundingMode.Floor } plainTime
  Test.assertEqual
    { actual: PlainTime.second roundedWithMode
    , expected: 45
    }

-- PlainDateTime
test_PlainDateTime :: Effect Unit
test_PlainDateTime = do
  Console.log "PlainDateTime.new"
  plainDateTime <- PlainDateTime.new { year: 2026, month: 2, day: 21, hour: 14, minute: 30, second: 0, millisecond: 0, microsecond: 0, nanosecond: 0 }
  Test.assertEqual
    { actual: PlainDateTime.toString_ plainDateTime
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

  Console.log "PlainDateTime.from with overflow"
  constrainDateTime <- PlainDateTime.from { overflow: Overflow.Constrain } "2024-12-25T23:59:59.999"
  Test.assertEqual
    { actual: PlainDateTime.day constrainDateTime
    , expected: 25
    }

  Console.log "PlainDateTime.toString with options"
  Test.assertEqual
    { actual: PlainDateTime.toString { fractionalSecondDigits: 3 } plainDateTime
    , expected: "2026-02-21T14:30:00.000"
    }

  Console.log "PlainDateTime.add / subtract"
  duration <- Duration.new { days: 1, hours: 1 }
  added <- PlainDateTime.add_ duration plainDateTime
  addedWithOpts <- PlainDateTime.add { overflow: Overflow.Constrain } duration plainDateTime
  Test.assertEqual
    { actual: PlainDateTime.day added
    , expected: 22
    }
  Test.assertEqual
    { actual: PlainDateTime.hour added
    , expected: 15
    }
  Test.assertEqual
    { actual: PlainDateTime.hour addedWithOpts
    , expected: 15
    }

  Console.log "PlainDateTime.toPlainDate / toPlainTime"
  Test.assertEqual
    { actual: PlainDate.toString_ (PlainDateTime.toPlainDate plainDateTime)
    , expected: "2026-02-21"
    }
  Test.assertEqual
    { actual: PlainTime.toString_ (PlainDateTime.toPlainTime plainDateTime)
    , expected: "14:30:00"
    }

  Console.log "PlainDateTime.until_ / since_"
  otherDateTime <- PlainDateTime.from_ "2026-02-22T14:30:00"
  untilDt <- PlainDateTime.until_ otherDateTime plainDateTime
  Test.assertEqual
    { actual: Duration.days untilDt
    , expected: 1
    }

  Console.log "PlainDateTime.round"
  rounded <- PlainDateTime.round { smallestUnit: TemporalUnit.Hour } plainDateTime
  Test.assertEqual
    { actual: PlainDateTime.hour rounded
    , expected: 15
    }
  roundedWithIncrement <- PlainDateTime.round { smallestUnit: TemporalUnit.Minute, roundingIncrement: 15 } plainDateTime
  Test.assertEqual
    { actual: PlainDateTime.minute roundedWithIncrement
    , expected: 30
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
    { actual: PlainYearMonth.toString_ plainYearMonth
    , expected: "2026-02"
    }
  Test.assertEqual
    { actual: PlainYearMonth.toString { calendarName: CalendarName.Auto } plainYearMonth
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

  Console.log "PlainYearMonth.from with overflow"
  constrainYearMonth <- PlainYearMonth.from { overflow: Overflow.Constrain } "2024-12"
  Test.assertEqual
    { actual: PlainYearMonth.month constrainYearMonth
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
  addedWithOpts <- PlainYearMonth.add { overflow: Overflow.Constrain } duration plainYearMonth
  Test.assertEqual
    { actual: PlainYearMonth.month addedWithOpts
    , expected: 5
    }

  Console.log "PlainYearMonth.until_ / since_"
  otherYearMonth <- PlainYearMonth.from_ "2026-05"
  untilYm <- PlainYearMonth.until_ otherYearMonth plainYearMonth
  Test.assertEqual
    { actual: Duration.months untilYm
    , expected: 3
    }

  Console.log "PlainYearMonth.toPlainDate"
  toDate <- PlainYearMonth.toPlainDate { day: 15 } plainYearMonth
  Test.assertEqual
    { actual: PlainDate.toString_ toDate
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
    { actual: PlainMonthDay.toString_ plainMonthDay
    , expected: "12-25"
    }
  Test.assertEqual
    { actual: PlainMonthDay.toString { calendarName: CalendarName.Never } plainMonthDay
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

  Console.log "PlainMonthDay.from with overflow"
  constrainMonthDay <- PlainMonthDay.from { overflow: Overflow.Constrain } "02-29"
  Test.assertEqual
    { actual: PlainMonthDay.day constrainMonthDay
    , expected: 29
    }

  Console.log "PlainMonthDay.toPlainDate"
  toDate <- PlainMonthDay.toPlainDate { year: 2024 } plainMonthDay
  Test.assertEqual
    { actual: PlainDate.toString_ toDate
    , expected: "2024-12-25"
    }

  Console.log "PlainMonthDay.with_"
  withMonthDay <- PlainMonthDay.with_ { day: 31 } plainMonthDay
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
    { actual: Duration.toString_ duration
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

  Console.log "Duration.round"
  durationToRound <- Duration.new { hours: 1, minutes: 30, seconds: 45 }
  roundedDuration <- Duration.round { smallestUnit: TemporalUnit.Minute } durationToRound
  Test.assertEqual
    { actual: Duration.minutes roundedDuration
    , expected: 31
    }

  Console.log "Duration.total"
  totalSeconds <- Duration.total { unit: TemporalUnit.Second } duration
  Test.assertEqual
    { actual: totalSeconds
    , expected: 648000.0
    }
  durationWithMonths <- Duration.new { months: 1, days: 15 }
  totalDaysWithRelative <- Duration.total { unit: TemporalUnit.Day, relativeTo: "2024-01-01" } durationWithMonths
  Test.assert (totalDaysWithRelative > 40.0 && totalDaysWithRelative < 50.0)

-- Instant
test_Instant :: Effect Unit
test_Instant = do
  Console.log "Instant.from"
  instant <- Instant.from "2026-02-21T12:00:00Z"
  Test.assertEqual
    { actual: Instant.toString_ instant
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
    { actual: Instant.toString_ added
    , expected: "2026-02-21T13:00:00Z"
    }
  subtracted <- Instant.subtract duration instant
  Test.assertEqual
    { actual: Instant.toString_ subtracted
    , expected: "2026-02-21T11:00:00Z"
    }

  Console.log "Instant.until_ / since_"
  otherInstant <- Instant.from "2026-02-21T14:00:00Z"
  untilDuration <- Instant.until_ otherInstant instant
  untilWithOpts <- Instant.until { largestUnit: TemporalUnit.Hour } otherInstant instant
  Test.assertEqual
    { actual: Duration.seconds untilDuration
    , expected: 7200
    }
  Test.assertEqual
    { actual: Duration.hours untilWithOpts
    , expected: 2
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
    { actual: Instant.toString_ rounded
    , expected: "2026-02-21T12:00:00Z"
    }
  roundedWithMode <- Instant.round { smallestUnit: TemporalUnit.Second, roundingMode: RoundingMode.Ceil } instant
  Test.assert (Instant.toString_ roundedWithMode /= "")

-- ZonedDateTime
test_ZonedDateTime :: Effect Unit
test_ZonedDateTime = do
  Console.log "ZonedDateTime.from_"
  zonedDateTime <- ZonedDateTime.from_ "2026-02-21T12:00:00-08:00[America/Los_Angeles]"
  Test.assertEqual
    { actual: ZonedDateTime.year zonedDateTime
    , expected: 2026
    }

  Console.log "ZonedDateTime.from with overflow"
  constrainZoned <- ZonedDateTime.from { overflow: Overflow.Constrain } "2026-02-21T12:00:00-08:00[America/Los_Angeles]"
  Test.assertEqual
    { actual: ZonedDateTime.day constrainZoned
    , expected: 21
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
  Test.assert (PlainDateTime.toString_ (ZonedDateTime.toPlainDateTime zonedDateTime) /= "")

  Console.log "ZonedDateTime.until_ / since_"
  otherZoned <- ZonedDateTime.from_ "2026-02-22T12:00:00-08:00[America/Los_Angeles]"
  untilZoned <- ZonedDateTime.until_ otherZoned zonedDateTime
  Test.assertEqual
    { actual: Duration.hours untilZoned
    , expected: 24
    }

  Console.log "ZonedDateTime.add / subtract"
  duration <- Duration.new { days: 1 }
  added <- ZonedDateTime.add_ duration zonedDateTime
  Test.assertEqual
    { actual: ZonedDateTime.day added
    , expected: 22
    }
  addedWithOpts <- ZonedDateTime.add { overflow: Overflow.Constrain } duration zonedDateTime
  Test.assertEqual
    { actual: ZonedDateTime.day addedWithOpts
    , expected: 22
    }

  Console.log "ZonedDateTime.round"
  roundedZoned <- ZonedDateTime.round { smallestUnit: TemporalUnit.Hour } zonedDateTime
  Test.assertEqual
    { actual: ZonedDateTime.hour roundedZoned
    , expected: 12
    }

  Console.log "ZonedDateTime.toInstant / toPlainDateTime"
  instant <- pure (ZonedDateTime.toInstant zonedDateTime)
  Test.assertEqual
    { actual: Instant.toString_ instant
    , expected: "2026-02-21T20:00:00Z"
    }
  plainDateTime <- pure (ZonedDateTime.toPlainDateTime zonedDateTime)
  Test.assertEqual
    { actual: PlainDateTime.toString_ plainDateTime
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
  Test.assert (Instant.toString_ nowInstant /= "")

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

-- DateTime interop (purescript-datetime round-trip property tests)
test_DateTimeInterop :: Effect Unit
test_DateTimeInterop = do
  Console.log "DateTime interop round-trips"
  let numTests = 100

  seed1 <- randomSeed
  _ <- tailRecM
    ( \{ remaining, state } ->
        if remaining <= 0 then
          pure (Done unit)
        else do
          let Tuple date newState = runGen genDate state
          plain <- PlainDate.fromDate date
          let back = PlainDate.toDate plain
          when (back /= date)
            (throwException (error ("PlainDate round-trip failed for " <> show date)))
          pure (Loop { remaining: remaining - 1, state: newState })
    )
    { remaining: numTests, state: { newSeed: seed1, size: 10 } }

  seed2 <- randomSeed
  _ <- tailRecM
    ( \{ remaining, state } ->
        if remaining <= 0 then
          pure (Done unit)
        else do
          let Tuple time newState = runGen genTime state
          plain <- PlainTime.fromTime time
          let back = PlainTime.toTime plain
          when (back /= time)
            (throwException (error ("PlainTime round-trip failed for " <> show time)))
          pure (Loop { remaining: remaining - 1, state: newState })
    )
    { remaining: numTests, state: { newSeed: seed2, size: 10 } }

  seed3 <- randomSeed
  _ <- tailRecM
    ( \{ remaining, state } ->
        if remaining <= 0 then
          pure (Done unit)
        else do
          let Tuple dateTime newState = runGen genDateTime state
          plain <- PlainDateTime.fromDateTime dateTime
          let back = PlainDateTime.toDateTime plain
          when (back /= dateTime)
            ( throwException
                (error ("PlainDateTime round-trip failed for " <> show dateTime))
            )
          pure (Loop { remaining: remaining - 1, state: newState })
    )
    { remaining: numTests, state: { newSeed: seed3, size: 10 } }

  seed4 <- randomSeed
  _ <- tailRecM
    ( \{ remaining, state } ->
        if remaining <= 0 then
          pure (Done unit)
        else do
          let Tuple dateTime newState = runGen genDateTime state
          let dtInstant = DateTime.Instant.fromDateTime dateTime
          temporalInstant <- Instant.fromDateTimeInstant dtInstant
          case Instant.toDateTimeInstant temporalInstant of
            Just back ->
              when (back /= dtInstant)
                ( throwException
                    (error ("Instant round-trip failed for " <> show dtInstant))
                )
            Nothing ->
              throwException
                (error ("Instant.toDateTimeInstant returned Nothing for " <> show dtInstant))
          pure (Loop { remaining: remaining - 1, state: newState })
    )
    { remaining: numTests, state: { newSeed: seed4, size: 10 } }

  Console.log ("  " <> show numTests <> " PlainDate round-trips passed")
  Console.log ("  " <> show numTests <> " PlainTime round-trips passed")
  Console.log ("  " <> show numTests <> " PlainDateTime round-trips passed")
  Console.log ("  " <> show numTests <> " Instant round-trips passed")
