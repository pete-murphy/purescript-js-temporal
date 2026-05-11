-- | Cookbook: Adjustable Hijri calendar
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#adjustable-hijri-calendar
module Examples.Cookbook.HijriCalendar where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainDate as PlainDate

-- | The built-in Islamic calendars can be used via the `calendar` field.
-- | Available variants include `islamic-civil`, `islamic-umalqura`,
-- | `islamic-tbla`, and `islamic-rgsa`.
main :: Effect Unit
main = do
  -- Create a Hijri date using the Umm al-Qura calendar
  date <- PlainDate.from { year: 1446, month: 7, day: 1, calendar: "islamic-umalqura" }
  Console.log ("Hijri date (Umm al-Qura): " <> PlainDate.toString date)
  Console.log ("Calendar: " <> PlainDate.calendarId date)
  Console.log ("Year: " <> show (PlainDate.year date))
  Console.log ("Month: " <> show (PlainDate.month date))
  Console.log ("Day: " <> show (PlainDate.day date))

  -- Convert the same Hijri date to the civil Islamic calendar
  civil <- PlainDate.withCalendar "islamic-civil" date
  Console.log ("Hijri date (civil): " <> PlainDate.toString civil)

  -- Convert to ISO calendar to see the Gregorian equivalent
  iso <- PlainDate.withCalendar "iso8601" date
  Console.log ("Gregorian equivalent: " <> PlainDate.toString iso)
