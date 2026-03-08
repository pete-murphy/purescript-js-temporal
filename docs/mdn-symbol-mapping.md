# PureScript js-temporal to MDN Symbol Mapping

Maps PureScript exports from `JS.Temporal.*` to MDN documentation paths.
Path format: `reference/mdn/files/en-us/web/javascript/reference/global_objects/temporal/<type>/<member>/index.md`

## PlainDate

| PureScript | MDN Path | Notes |
| new | plaindate/plaindate | constructor |
| from | plaindate/from | |
| from_ | (alias of from) | Same as `from` with defaults |
| add | plaindate/add | |
| add_ | (alias of add) | Same as `add` with defaults |
| subtract | plaindate/subtract | |
| subtract_ | (alias of subtract) | Same as `subtract` with defaults |
| with | plaindate/with | |
| with_ | (alias of with) | Same as `with` with defaults |
| withCalendar | plaindate/withCalendar | |
| until | plaindate/until | |
| until_ | (alias of until) | Same as `until` with defaults |
| since | plaindate/since | |
| since_ | (alias of since) | Same as `since` with defaults |
| toString | plaindate/tostring | |
| toString_ | (alias of toString) | Same as `toString` with defaults |
| year | plaindate/year | property |
| month | plaindate/month | property |
| day | plaindate/day | property |
| monthCode | plaindate/monthcode | property |
| dayOfWeek | plaindate/dayofweek | property |
| dayOfYear | plaindate/dayofyear | property |
| daysInMonth | plaindate/daysinmonth | property |
| daysInYear | plaindate/daysinyear | property |
| daysInWeek | plaindate/daysinweek | property |
| monthsInYear | plaindate/monthsinyear | property |
| inLeapYear | plaindate/inleapyear | property |
| calendarId | plaindate/calendarid | property |
| weekOfYear | plaindate/weekofyear | property |
| yearOfWeek | plaindate/yearofweek | property |
| era | plaindate/era | property |
| eraYear | plaindate/erayear | property |
| toPlainYearMonth | plaindate/toplainyearmonth | |
| toPlainMonthDay | plaindate/toplainmonthday | |
| toPlainDateTime | plaindate/toplaindatetime | |
| toZonedDateTime | plaindate/tozoneddatetime | |
| fromDate | (PureScript-only) | purescript-datetime Date → PlainDate |
| toDate | (PureScript-only) | PlainDate → purescript-datetime Date |

## PlainTime

| PureScript | MDN Path | Notes |
| new | plaintime/plaintime | constructor |
| from | plaintime/from | |
| from_ | (alias of from) | Same as `from` with defaults |
| add | plaintime/add | |
| subtract | plaintime/subtract | |
| with | plaintime/with | |
| with_ | (alias of with) | Same as `with` with defaults |
| until | plaintime/until | |
| until_ | (alias of until) | Same as `until` with defaults |
| since | plaintime/since | |
| since_ | (alias of since) | Same as `since` with defaults |
| round | plaintime/round | |
| toString | plaintime/tostring | |
| toString_ | (alias of toString) | Same as `toString` with defaults |
| hour | plaintime/hour | property |
| minute | plaintime/minute | property |
| second | plaintime/second | property |
| millisecond | plaintime/millisecond | property |
| microsecond | plaintime/microsecond | property |
| nanosecond | plaintime/nanosecond | property |
| fromTime | (PureScript-only) | purescript-datetime Time → PlainTime |
| toTime | (PureScript-only) | PlainTime → purescript-datetime Time |

## PlainMonthDay

| PureScript | MDN Path | Notes |
| new | plainmonthday/plainmonthday | constructor |
| from | plainmonthday/from | |
| from_ | (alias of from) | Same as `from` with defaults |
| with | plainmonthday/with | |
| with_ | (alias of with) | Same as `with` with defaults |
| toPlainDate | plainmonthday/toplaindate | |
| toString | plainmonthday/tostring | |
| toString_ | (alias of toString) | Same as `toString` with defaults |
| monthCode | plainmonthday/monthcode | property |
| day | plainmonthday/day | property |
| calendarId | plainmonthday/calendarid | property |

## PlainYearMonth

| PureScript | MDN Path | Notes |
| new | plainyearmonth/plainyearmonth | constructor |
| from | plainyearmonth/from | |
| from_ | (alias of from) | Same as `from` with defaults |
| add | plainyearmonth/add | |
| add_ | (alias of add) | Same as `add` with defaults |
| subtract | plainyearmonth/subtract | |
| subtract_ | (alias of subtract) | Same as `subtract` with defaults |
| with | plainyearmonth/with | |
| with_ | (alias of with) | Same as `with` with defaults |
| until | plainyearmonth/until | |
| until_ | (alias of until) | Same as `until` with defaults |
| since | plainyearmonth/since | |
| since_ | (alias of since) | Same as `since` with defaults |
| toPlainDate | plainyearmonth/toplaindate | |
| toString | plainyearmonth/tostring | |
| toString_ | (alias of toString) | Same as `toString` with defaults |
| year | plainyearmonth/year | property |
| month | plainyearmonth/month | property |
| monthCode | plainyearmonth/monthcode | property |
| daysInMonth | plainyearmonth/daysinmonth | property |
| daysInYear | plainyearmonth/daysinyear | property |
| monthsInYear | plainyearmonth/monthsinyear | property |
| inLeapYear | plainyearmonth/inleapyear | property |
| calendarId | plainyearmonth/calendarid | property |
| era | plainyearmonth/era | property |
| eraYear | plainyearmonth/erayear | property |

## Duration

| PureScript | MDN Path | Notes |
| new | duration/duration | constructor |
| from | duration/from | |
| add | duration/add | |
| subtract | duration/subtract | |
| negated | duration/negated | |
| abs | duration/abs | |
| with | duration/with | |
| compare | duration/compare | |
| round | duration/round | |
| total | duration/total | |
| toString | duration/tostring | |
| toString_ | (alias of toString) | Same as `toString` with defaults |
| years | duration/years | property |
| months | duration/months | property |
| weeks | duration/weeks | property |
| days | duration/days | property |
| hours | duration/hours | property |
| minutes | duration/minutes | property |
| seconds | duration/seconds | property |
| milliseconds | duration/milliseconds | property |
| microseconds | duration/microseconds | property |
| nanoseconds | duration/nanoseconds | property |
| sign | duration/sign | property |
| blank | duration/blank | property |
| fromMilliseconds | (PureScript-only) | purescript-datetime Milliseconds → Duration |
| toMilliseconds | (PureScript-only) | Duration → Maybe purescript-datetime Milliseconds |

## Instant

| PureScript | MDN Path | Notes |
| new | instant/instant | constructor |
| from | instant/from | |
| add | instant/add | |
| subtract | instant/subtract | |
| until | instant/until | |
| until_ | (alias of until) | Same as `until` with defaults |
| since | instant/since | |
| since_ | (alias of since) | Same as `since` with defaults |
| round | instant/round | |
| toString | instant/tostring | |
| toString_ | (alias of toString) | Same as `toString` with defaults |
| epochMilliseconds | instant/epochmilliseconds | property |
| epochNanoseconds | instant/epochnanoseconds | property |
| toZonedDateTimeISO | instant/tozoneddatetimeiso | |
| fromEpochMilliseconds | instant/fromepochmilliseconds | |
| fromEpochNanoseconds | instant/fromepochnanoseconds | |
| fromDateTimeInstant | (PureScript-only) | purescript-datetime Instant → Instant |
| toDateTimeInstant | (PureScript-only) | Instant → Maybe purescript-datetime Instant |

## PlainDateTime

| PureScript | MDN Path | Notes |
| new | plaindatetime/plaindatetime | constructor |
| from | plaindatetime/from | |
| from_ | (alias of from) | Same as `from` with defaults |
| add | plaindatetime/add | |
| add_ | (alias of add) | Same as `add` with defaults |
| subtract | plaindatetime/subtract | |
| subtract_ | (alias of subtract) | Same as `subtract` with defaults |
| with | plaindatetime/with | |
| with_ | (alias of with) | Same as `with` with defaults |
| withPlainTime | plaindatetime/withplaintime | |
| withCalendar | plaindatetime/withcalendar | |
| until | plaindatetime/until | |
| until_ | (alias of until) | Same as `until` with defaults |
| since | plaindatetime/since | |
| since_ | (alias of since) | Same as `since` with defaults |
| round | plaindatetime/round | |
| toString | plaindatetime/tostring | |
| toString_ | (alias of toString) | Same as `toString` with defaults |
| toPlainDate | plaindatetime/toplaindate | |
| toPlainTime | plaindatetime/toplaintime | |
| toZonedDateTime | plaindatetime/tozoneddatetime | |
| year | plaindatetime/year | property |
| month | plaindatetime/month | property |
| day | plaindatetime/day | property |
| monthCode | plaindatetime/monthcode | property |
| dayOfWeek | plaindatetime/dayofweek | property |
| dayOfYear | plaindatetime/dayofyear | property |
| weekOfYear | plaindatetime/weekofyear | property |
| yearOfWeek | plaindatetime/yearofweek | property |
| daysInMonth | plaindatetime/daysinmonth | property |
| daysInYear | plaindatetime/daysinyear | property |
| daysInWeek | plaindatetime/daysinweek | property |
| monthsInYear | plaindatetime/monthsinyear | property |
| inLeapYear | plaindatetime/inleapyear | property |
| calendarId | plaindatetime/calendarid | property |
| era | plaindatetime/era | property |
| eraYear | plaindatetime/erayear | property |
| hour | plaindatetime/hour | property |
| minute | plaindatetime/minute | property |
| second | plaindatetime/second | property |
| millisecond | plaindatetime/millisecond | property |
| microsecond | plaindatetime/microsecond | property |
| nanosecond | plaindatetime/nanosecond | property |
| fromDateTime | (PureScript-only) | purescript-datetime DateTime → PlainDateTime |
| toDateTime | (PureScript-only) | PlainDateTime → purescript-datetime DateTime |

## ZonedDateTime

| PureScript | MDN Path | Notes |
| new | zoneddatetime/zoneddatetime | constructor |
| from | zoneddatetime/from | |
| from_ | (alias of from) | Same as `from` with defaults |
| add | zoneddatetime/add | |
| add_ | (alias of add) | Same as `add` with defaults |
| subtract | zoneddatetime/subtract | |
| subtract_ | (alias of subtract) | Same as `subtract` with defaults |
| with | zoneddatetime/with | |
| with_ | (alias of with) | Same as `with` with defaults |
| withTimeZone | zoneddatetime/withtimezone | |
| withCalendar | zoneddatetime/withcalendar | |
| withPlainTime | zoneddatetime/withplaintime | |
| withPlainDate | zoneddatetime/withplaindate | |
| until | zoneddatetime/until | |
| until_ | (alias of until) | Same as `until` with defaults |
| since | zoneddatetime/since | |
| since_ | (alias of since) | Same as `since` with defaults |
| round | zoneddatetime/round | |
| startOfDay | zoneddatetime/startofday | |
| getTimeZoneTransition | zoneddatetime/gettimezonetransition | |
| toInstant | zoneddatetime/toinstant | |
| toPlainDateTime | zoneddatetime/toplaindatetime | |
| toPlainDate | zoneddatetime/toplaindate | |
| toPlainTime | zoneddatetime/toplaintime | |
| toPlainYearMonth | zoneddatetime/toplainyearmonth | |
| toPlainMonthDay | zoneddatetime/toplainmonthday | |
| toString | zoneddatetime/tostring | |
| toString_ | (alias of toString) | Same as `toString` with defaults |
| year | zoneddatetime/year | property |
| month | zoneddatetime/month | property |
| day | zoneddatetime/day | property |
| monthCode | zoneddatetime/monthcode | property |
| hour | zoneddatetime/hour | property |
| minute | zoneddatetime/minute | property |
| second | zoneddatetime/second | property |
| millisecond | zoneddatetime/millisecond | property |
| microsecond | zoneddatetime/microsecond | property |
| nanosecond | zoneddatetime/nanosecond | property |
| dayOfWeek | zoneddatetime/dayofweek | property |
| dayOfYear | zoneddatetime/dayofyear | property |
| weekOfYear | zoneddatetime/weekofyear | property |
| yearOfWeek | zoneddatetime/yearofweek | property |
| daysInMonth | zoneddatetime/daysinmonth | property |
| daysInYear | zoneddatetime/daysinyear | property |
| daysInWeek | zoneddatetime/daysinweek | property |
| monthsInYear | zoneddatetime/monthsinyear | property |
| inLeapYear | zoneddatetime/inleapyear | property |
| calendarId | zoneddatetime/calendarid | property |
| era | zoneddatetime/era | property |
| eraYear | zoneddatetime/erayear | property |
| timeZoneId | zoneddatetime/timezoneid | property |
| offset | zoneddatetime/offset | property |
| offsetNanoseconds | zoneddatetime/offsetnanoseconds | property |
| hoursInDay | zoneddatetime/hoursinday | property |
| epochMilliseconds | zoneddatetime/epochmilliseconds | property |
| epochNanoseconds | zoneddatetime/epochnanoseconds | property |

## Now

| PureScript | MDN Path | Notes |
| instant | now/instant | |
| zonedDateTimeISO | now/zoneddatetimeiso | |
| zonedDateTimeISO_ | (alias of zonedDateTimeISO) | Uses system local time zone |
| plainDateISO | now/plaindateiso | |
| plainDateISO_ | (alias of plainDateISO) | Uses system local time zone |
| plainDateTimeISO | now/plaindatetimeiso | |
| plainDateTimeISO_ | (alias of plainDateTimeISO) | Uses system local time zone |
| plainTimeISO | now/plaintimeiso | |
| plainTimeISO_ | (alias of plainTimeISO) | Uses system local time zone |
| timeZoneId | now/timezoneid | |
