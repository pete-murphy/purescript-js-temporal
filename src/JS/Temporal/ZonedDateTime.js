export function _new(epochNanoseconds, timeZone) {
  return new Temporal.ZonedDateTime(epochNanoseconds, timeZone);
}

export function _from(options, str) {
  return Temporal.ZonedDateTime.from(str, options);
}

export function _fromNoOpts(str) {
  return Temporal.ZonedDateTime.from(str);
}

export const year = (zdt) => zdt.year;
export const month = (zdt) => zdt.month;
export const day = (zdt) => zdt.day;
export const monthCode = (zdt) => zdt.monthCode;
export const hour = (zdt) => zdt.hour;
export const minute = (zdt) => zdt.minute;
export const second = (zdt) => zdt.second;
export const millisecond = (zdt) => zdt.millisecond;
export const microsecond = (zdt) => zdt.microsecond;
export const nanosecond = (zdt) => zdt.nanosecond;
export const dayOfWeek = (zdt) => zdt.dayOfWeek;
export const dayOfYear = (zdt) => zdt.dayOfYear;
export const _weekOfYear = (zdt) => zdt.weekOfYear ?? null;
export const _yearOfWeek = (zdt) => zdt.yearOfWeek ?? null;
export const daysInMonth = (zdt) => zdt.daysInMonth;
export const daysInYear = (zdt) => zdt.daysInYear;
export const daysInWeek = (zdt) => zdt.daysInWeek;
export const monthsInYear = (zdt) => zdt.monthsInYear;
export const inLeapYear = (zdt) => zdt.inLeapYear;
export const calendarId = (zdt) => zdt.calendarId;
export const _era = (zdt) => zdt.era ?? null;
export const _eraYear = (zdt) => zdt.eraYear ?? null;
export const timeZoneId = (zdt) => zdt.timeZoneId;
export const offset = (zdt) => zdt.offset;
export const offsetNanoseconds = (zdt) => zdt.offsetNanoseconds;
export const hoursInDay = (zdt) => zdt.hoursInDay;
export const epochMilliseconds = (zdt) => zdt.epochMilliseconds;
export const epochNanoseconds = (zdt) => zdt.epochNanoseconds;

export function _toInstant(zdt) {
  return zdt.toInstant();
}

export function _toPlainDateTime(zdt) {
  return zdt.toPlainDateTime();
}

export function _toPlainDate(zdt) {
  return zdt.toPlainDate();
}

export function _toPlainTime(zdt) {
  return zdt.toPlainTime();
}

export function _add(options, duration, zdt) {
  return zdt.add(duration, options);
}

export function _addNoOpts(duration, zdt) {
  return zdt.add(duration);
}

export function _subtract(options, duration, zdt) {
  return zdt.subtract(duration, options);
}

export function _subtractNoOpts(duration, zdt) {
  return zdt.subtract(duration);
}

export function _with(fields, zdt) {
  return zdt.with(fields);
}

export function _withTimeZone(timeZone, zdt) {
  return zdt.withTimeZone(timeZone);
}

export function _withCalendar(calendar, zdt) {
  return zdt.withCalendar(calendar);
}

export function _withPlainTime(plainTime, zdt) {
  return zdt.withPlainTime(plainTime);
}

export function _until(options, other, zdt) {
  return zdt.until(other, options);
}

export function _untilNoOpts(other, zdt) {
  return zdt.until(other);
}

export function _since(options, other, zdt) {
  return zdt.since(other, options);
}

export function _sinceNoOpts(other, zdt) {
  return zdt.since(other);
}

export function _round(options, zdt) {
  return zdt.round(options);
}

export function _startOfDay(zdt) {
  return zdt.startOfDay();
}

export function _getTimeZoneTransition(nothing, just, direction, zdt) {
  var result = zdt.getTimeZoneTransition(direction);
  return result === null ? nothing : just(result);
}

export function _compare(a, b) {
  return Temporal.ZonedDateTime.compare(a, b);
}

export function _equals(a, b) {
  return a.equals(b);
}

export function _toString(options, zdt) {
  return zdt.toString(options);
}

export const toString_ = (zdt) => zdt.toString();
