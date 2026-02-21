export function _new(year, month, day) {
  return new Temporal.PlainDate(year, month, day);
}

export function _from(options, str) {
  return Temporal.PlainDate.from(str, options);
}

export function _fromNoOpts(str) {
  return Temporal.PlainDate.from(str);
}

export const year = (pd) => pd.year;
export const month = (pd) => pd.month;
export const day = (pd) => pd.day;
export const monthCode = (pd) => pd.monthCode;
export const dayOfWeek = (pd) => pd.dayOfWeek;
export const dayOfYear = (pd) => pd.dayOfYear;
export const _weekOfYear = (pd) => pd.weekOfYear ?? null;
export const _yearOfWeek = (pd) => pd.yearOfWeek ?? null;
export const daysInMonth = (pd) => pd.daysInMonth;
export const daysInYear = (pd) => pd.daysInYear;
export const daysInWeek = (pd) => pd.daysInWeek;
export const monthsInYear = (pd) => pd.monthsInYear;
export const inLeapYear = (pd) => pd.inLeapYear;
export const calendarId = (pd) => pd.calendarId;
export const _era = (pd) => pd.era ?? null;
export const _eraYear = (pd) => pd.eraYear ?? null;

export function _add(options, duration, pd) {
  return pd.add(duration, options);
}

export function _addNoOpts(duration, pd) {
  return pd.add(duration);
}

export function _subtract(options, duration, pd) {
  return pd.subtract(duration, options);
}

export function _subtractNoOpts(duration, pd) {
  return pd.subtract(duration);
}

export function _with(options, fields, pd) {
  return pd.with(fields, options);
}

export function _withNoOpts(fields, pd) {
  return pd.with(fields);
}

export function _withCalendar(calendar, pd) {
  return pd.withCalendar(calendar);
}

export function _until(options, other, pd) {
  return pd.until(other, options);
}

export function _untilNoOpts(other, pd) {
  return pd.until(other);
}

export function _since(options, other, pd) {
  return pd.since(other, options);
}

export function _sinceNoOpts(other, pd) {
  return pd.since(other);
}

export function _toPlainYearMonth(pd) {
  return pd.toPlainYearMonth();
}

export function _toPlainMonthDay(pd) {
  return pd.toPlainMonthDay();
}

export function _toPlainDateTime(plainTime, pd) {
  return pd.toPlainDateTime(plainTime);
}

export function _toZonedDateTime(timeZone, pd) {
  return pd.toZonedDateTime(timeZone);
}

export function _compare(a, b) {
  return Temporal.PlainDate.compare(a, b);
}

export function _equals(a, b) {
  return a.equals(b);
}

export function _toString(options, pd) {
  return pd.toString(options);
}

export const toString_ = (pd) => pd.toString();
