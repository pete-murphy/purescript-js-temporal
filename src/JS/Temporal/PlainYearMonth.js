export function _fromRecordWithOptions(options, components) {
  return Temporal.PlainYearMonth.from(components, options);
}

export function _fromRecord(components) {
  return Temporal.PlainYearMonth.from(components);
}

export function _fromStringWithOptions(options, str) {
  return Temporal.PlainYearMonth.from(str, options);
}

export function _fromString(str) {
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

export function _addWithOptions(options, duration, pym) {
  return pym.add(duration, options);
}

export function _add(duration, pym) {
  return pym.add(duration);
}

export function _subtractWithOptions(options, duration, pym) {
  return pym.subtract(duration, options);
}

export function _subtract(duration, pym) {
  return pym.subtract(duration);
}

export function _withWithOptions(options, fields, pym) {
  return pym.with(fields, options);
}

export function _with(fields, pym) {
  return pym.with(fields);
}

export function _toPlainDate(fields, pym) {
  return pym.toPlainDate(fields);
}

export function _untilWithOptions(options, other, pym) {
  return pym.until(other, options);
}

export function _until(other, pym) {
  return pym.until(other);
}

export function _sinceWithOptions(options, other, pym) {
  return pym.since(other, options);
}

export function _since(other, pym) {
  return pym.since(other);
}



export function _toString(options, pym) {
  return pym.toString(options);
}

