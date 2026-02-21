-- | Cookbook: Schedule a reminder ahead of matching a record-setting duration
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#schedule-a-reminder-ahead-of-matching-a-record-setting-duration
module Examples.Cookbook.RecordReminder where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.Instant as Instant

getInstantBeforeOldRecord
  :: Instant.Instant
  -> Duration.Duration
  -> Duration.Duration
  -> Effect Instant.Instant
getInstantBeforeOldRecord start previousRecord noticeWindow = do
  afterRecord <- Instant.add previousRecord start
  Instant.subtract noticeWindow afterRecord

main :: Effect Unit
main = do
  raceStart <- Instant.from "2016-08-13T21:27-03:00[America/Sao_Paulo]"
  record <- Duration.new { minutes: 26, seconds: 17, milliseconds: 530 }
  noticeWindow <- Duration.new { minutes: 1 }

  reminderAt <- getInstantBeforeOldRecord raceStart record noticeWindow
  Console.log ("Reminder at: " <> Instant.toString_ reminderAt)
