// Pure conversions (projections)
export function _plainDateTimeToPlainDate(pdt) {
  return pdt.toPlainDate();
}

export function _plainDateTimeToPlainTime(pdt) {
  return pdt.toPlainTime();
}

export function _zonedDateTimeToInstant(zdt) {
  return zdt.toInstant();
}

export function _zonedDateTimeToPlainDateTime(zdt) {
  return zdt.toPlainDateTime();
}

export function _zonedDateTimeToPlainDate(zdt) {
  return zdt.toPlainDate();
}

export function _zonedDateTimeToPlainTime(zdt) {
  return zdt.toPlainTime();
}

export function _plainDateToPlainYearMonth(pd) {
  return pd.toPlainYearMonth();
}

export function _plainDateToPlainMonthDay(pd) {
  return pd.toPlainMonthDay();
}

// Combining (pure)
export function _plainDateToPlainDateTime(plainTime, pd) {
  return pd.toPlainDateTime(plainTime);
}

export function _instantToZonedDateTimeISO(timeZone, instant) {
  return instant.toZonedDateTimeISO(timeZone);
}

// Timezone-dependent (effectful)
export function _plainDateToZonedDateTime(timeZone, pd) {
  return pd.toZonedDateTime(timeZone);
}

export function _plainDateTimeToZonedDateTime(timeZone, pdt) {
  return pdt.toZonedDateTime(timeZone);
}

export function _plainYearMonthToPlainDate(fields, pym) {
  return pym.toPlainDate(fields);
}

export function _plainMonthDayToPlainDate(fields, pmd) {
  return pmd.toPlainDate(fields);
}
