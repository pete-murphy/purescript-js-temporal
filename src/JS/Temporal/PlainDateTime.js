export function _new(components) {
  return Temporal.PlainDateTime.from(components);
}

export function _from(options, str) {
  return Temporal.PlainDateTime.from(str, options);
}

export function _fromNoOpts(str) {
  return Temporal.PlainDateTime.from(str);
}

export const year = (pdt) => pdt.year;
export const month = (pdt) => pdt.month;
export const day = (pdt) => pdt.day;
export const monthCode = (pdt) => pdt.monthCode;
export const dayOfWeek = (pdt) => pdt.dayOfWeek;
export const dayOfYear = (pdt) => pdt.dayOfYear;
export const _weekOfYear = (pdt) => pdt.weekOfYear ?? null;
export const _yearOfWeek = (pdt) => pdt.yearOfWeek ?? null;
export const daysInMonth = (pdt) => pdt.daysInMonth;
export const daysInYear = (pdt) => pdt.daysInYear;
export const daysInWeek = (pdt) => pdt.daysInWeek;
export const monthsInYear = (pdt) => pdt.monthsInYear;
export const inLeapYear = (pdt) => pdt.inLeapYear;
export const calendarId = (pdt) => pdt.calendarId;
export const _era = (pdt) => pdt.era ?? null;
export const _eraYear = (pdt) => pdt.eraYear ?? null;
export const hour = (pdt) => pdt.hour;
export const minute = (pdt) => pdt.minute;
export const second = (pdt) => pdt.second;
export const millisecond = (pdt) => pdt.millisecond;
export const microsecond = (pdt) => pdt.microsecond;
export const nanosecond = (pdt) => pdt.nanosecond;

export function _add(options, duration, pdt) {
  return pdt.add(duration, options);
}

export function _addNoOpts(duration, pdt) {
  return pdt.add(duration);
}

export function _subtract(options, duration, pdt) {
  return pdt.subtract(duration, options);
}

export function _subtractNoOpts(duration, pdt) {
  return pdt.subtract(duration);
}

export function _with(options, fields, pdt) {
  return pdt.with(fields, options);
}

export function _withNoOpts(fields, pdt) {
  return pdt.with(fields);
}

export function _withPlainTime(plainTime, pdt) {
  return pdt.withPlainTime(plainTime);
}

export function _withCalendar(calendar, pdt) {
  return pdt.withCalendar(calendar);
}

export function _until(options, other, pdt) {
  return pdt.until(other, options);
}

export function _untilNoOpts(other, pdt) {
  return pdt.until(other);
}

export function _since(options, other, pdt) {
  return pdt.since(other, options);
}

export function _sinceNoOpts(other, pdt) {
  return pdt.since(other);
}

export function _round(options, pdt) {
  return pdt.round(options);
}

export function _compare(a, b) {
  return Temporal.PlainDateTime.compare(a, b);
}

export function _equals(a, b) {
  return a.equals(b);
}

export function _toString(options, pdt) {
  return pdt.toString(options);
}

export const toString_ = (pdt) => pdt.toString();

export function _toPlainDate(pdt) {
  return pdt.toPlainDate();
}

export function _toPlainTime(pdt) {
  return pdt.toPlainTime();
}

export function _toZonedDateTime(timeZone, pdt) {
  return pdt.toZonedDateTime(timeZone);
}
