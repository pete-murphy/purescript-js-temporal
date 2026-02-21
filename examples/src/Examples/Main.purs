-- | Runs all Temporal Cookbook examples.
-- | Run with: spago run -m Examples.Main
-- | Or run a single example: spago run -m Examples.Cookbook.CurrentDateTime
module Examples.Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import Examples.Cookbook.BirthdayInYear as BirthdayInYear
import Examples.Cookbook.BridgePublicHolidays as BridgePublicHolidays
import Examples.Cookbook.CurrentDateTime as CurrentDateTime
import Examples.Cookbook.DailyOccurrence as DailyOccurrence
import Examples.Cookbook.DaysUntilFutureDate as DaysUntilFutureDate
import Examples.Cookbook.DateTimeInterop as DateTimeInterop
import Examples.Cookbook.FlightDuration as FlightDuration
import Examples.Cookbook.GetWeeklyDaysInMonth as GetWeeklyDaysInMonth
import Examples.Cookbook.ManipulatingDayOfMonth as ManipulatingDayOfMonth
import Examples.Cookbook.NextOffsetTransition as NextOffsetTransition
import Examples.Cookbook.NextWeeklyOccurrence as NextWeeklyOccurrence
import Examples.Cookbook.NoonOnDate as NoonOnDate
import Examples.Cookbook.NthWeekdayOfMonth as NthWeekdayOfMonth
import Examples.Cookbook.PreservingExactTime as PreservingExactTime
import Examples.Cookbook.PushBackLaunchDate as PushBackLaunchDate
import Examples.Cookbook.RecordReminder as RecordReminder
import Examples.Cookbook.RoundDateToMonth as RoundDateToMonth
import Examples.Cookbook.RoundTimeDown as RoundTimeDown
import Examples.Cookbook.SameDateInAnotherMonth as SameDateInAnotherMonth
import Examples.Cookbook.Serialization as Serialization
import Examples.Cookbook.SortInstantStrings as SortInstantStrings
import Examples.Cookbook.SortPlainDateTime as SortPlainDateTime
import Examples.Cookbook.UnitConstrainedDuration as UnitConstrainedDuration
import Examples.Cookbook.UnixTimestamp as UnixTimestamp
import Examples.Cookbook.UtcOffset as UtcOffset

main :: Effect Unit
main = do
  Console.log "=== Temporal Cookbook Examples ===\n"

  Console.log "--- CurrentDateTime ---"
  CurrentDateTime.main
  Console.log ""

  Console.log "--- UnixTimestamp ---"
  UnixTimestamp.main
  Console.log ""

  Console.log "--- NoonOnDate ---"
  NoonOnDate.main
  Console.log ""

  Console.log "--- BirthdayInYear ---"
  BirthdayInYear.main
  Console.log ""

  Console.log "--- Serialization ---"
  Serialization.main
  Console.log ""

  Console.log "--- SortPlainDateTime ---"
  SortPlainDateTime.main
  Console.log ""

  Console.log "--- SortInstantStrings ---"
  SortInstantStrings.main
  Console.log ""

  Console.log "--- RoundTimeDown ---"
  RoundTimeDown.main
  Console.log ""

  Console.log "--- RoundDateToMonth ---"
  RoundDateToMonth.main
  Console.log ""

  Console.log "--- PreservingExactTime ---"
  PreservingExactTime.main
  Console.log ""

  Console.log "--- DailyOccurrence ---"
  DailyOccurrence.main
  Console.log ""

  Console.log "--- UtcOffset ---"
  UtcOffset.main
  Console.log ""

  Console.log "--- NextOffsetTransition ---"
  NextOffsetTransition.main
  Console.log ""

  Console.log "--- DaysUntilFutureDate ---"
  DaysUntilFutureDate.main
  Console.log ""

  Console.log "--- UnitConstrainedDuration ---"
  UnitConstrainedDuration.main
  Console.log ""

  Console.log "--- FlightDuration ---"
  FlightDuration.main
  Console.log ""

  Console.log "--- PushBackLaunchDate ---"
  PushBackLaunchDate.main
  Console.log ""

  Console.log "--- RecordReminder ---"
  RecordReminder.main
  Console.log ""

  Console.log "--- NthWeekdayOfMonth ---"
  NthWeekdayOfMonth.main
  Console.log ""

  Console.log "--- GetWeeklyDaysInMonth ---"
  GetWeeklyDaysInMonth.main
  Console.log ""

  Console.log "--- ManipulatingDayOfMonth ---"
  ManipulatingDayOfMonth.main
  Console.log ""

  Console.log "--- SameDateInAnotherMonth ---"
  SameDateInAnotherMonth.main
  Console.log ""

  Console.log "--- NextWeeklyOccurrence ---"
  NextWeeklyOccurrence.main
  Console.log ""

  Console.log "--- BridgePublicHolidays ---"
  BridgePublicHolidays.main
  Console.log ""

  Console.log "--- DateTimeInterop ---"
  DateTimeInterop.main
  Console.log ""

  Console.log "=== Done ==="
