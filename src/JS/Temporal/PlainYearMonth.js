export function _new(year, month) {
  return new Temporal.PlainYearMonth(year, month);
}

export function _from(options, str) {
  return Temporal.PlainYearMonth.from(str, options);
}

export function _fromNoOpts(str) {
  return Temporal.PlainYearMonth.from(str);
}

export const year = (pym) => pym.year;
export const month = (pym) => pym.month;
export const monthCode = (pym) => pym.monthCode;
export const daysInMonth = (pym) => pym.daysInMonth;
export const daysInYear = (pym) => pym.daysInYear;
export const monthsInYear = (pym) => pym.monthsInYear;
export const inLeapYear = (pym) => pym.inLeapYear;
export const calendarId = (pym) => pym.calendarId;
export const _era = (pym) => pym.era ?? null;
export const _eraYear = (pym) => pym.eraYear ?? null;

export function _add(options, duration, pym) {
  return pym.add(duration, options);
}

export function _addNoOpts(duration, pym) {
  return pym.add(duration);
}

export function _subtract(options, duration, pym) {
  return pym.subtract(duration, options);
}

export function _subtractNoOpts(duration, pym) {
  return pym.subtract(duration);
}

export function _with(fields, pym) {
  return pym.with(fields);
}

export function _until(options, other, pym) {
  return pym.until(other, options);
}

export function _untilNoOpts(other, pym) {
  return pym.until(other);
}

export function _since(options, other, pym) {
  return pym.since(other, options);
}

export function _sinceNoOpts(other, pym) {
  return pym.since(other);
}

export function _compare(a, b) {
  return Temporal.PlainYearMonth.compare(a, b);
}

export function _equals(a, b) {
  return a.equals(b);
}

export function _toString(options, pym) {
  return pym.toString(options);
}

export const toString_ = (pym) => pym.toString();
