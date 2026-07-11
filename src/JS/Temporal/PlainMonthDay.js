export function _fromRecordWithOptions(options, components) {
  return Temporal.PlainMonthDay.from(components, options);
}

export function _fromRecord(components) {
  return Temporal.PlainMonthDay.from(components);
}

export function _fromStringWithOptions(options, str) {
  return Temporal.PlainMonthDay.from(str, options);
}

export function _fromString(str) {
  return Temporal.PlainMonthDay.from(str);
}

export const monthCode = (pmd) => pmd.monthCode;
export const day = (pmd) => pmd.day;
export const calendarId = (pmd) => pmd.calendarId;

export function _withWithOptions(options, fields, pmd) {
  return pmd.with(fields, options);
}

export function _with(fields, pmd) {
  return pmd.with(fields);
}

export function _toPlainDate(fields, pmd) {
  return pmd.toPlainDate(fields);
}

export function _toString(options, pmd) {
  return pmd.toString(options);
}
