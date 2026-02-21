export function _new(month, day) {
  return new Temporal.PlainMonthDay(month, day);
}

export function _from(options, str) {
  return Temporal.PlainMonthDay.from(str, options);
}

export function _fromNoOpts(str) {
  return Temporal.PlainMonthDay.from(str);
}

export const monthCode = (pmd) => pmd.monthCode;
export const day = (pmd) => pmd.day;
export const calendarId = (pmd) => pmd.calendarId;

export function _with(options, fields, pmd) {
  return pmd.with(fields, options);
}

export function _withNoOpts(fields, pmd) {
  return pmd.with(fields);
}

export function _toPlainDate(fields, pmd) {
  return pmd.toPlainDate(fields);
}

export function _toString(options, pmd) {
  return pmd.toString(options);
}
