export function instant() {
  return Temporal.Now.instant();
}

export function _zonedDateTimeISO() {
  return Temporal.Now.zonedDateTimeISO();
}

export function _zonedDateTimeISOWithTimeZone(timeZone) {
  return Temporal.Now.zonedDateTimeISO(timeZone);
}

export function _plainDateISO() {
  return Temporal.Now.plainDateISO();
}

export function _plainDateISOWithTimeZone(timeZone) {
  return Temporal.Now.plainDateISO(timeZone);
}

export function _plainDateTimeISO() {
  return Temporal.Now.plainDateTimeISO();
}

export function _plainDateTimeISOWithTimeZone(timeZone) {
  return Temporal.Now.plainDateTimeISO(timeZone);
}

export function _plainTimeISO() {
  return Temporal.Now.plainTimeISO();
}

export function _plainTimeISOWithTimeZone(timeZone) {
  return Temporal.Now.plainTimeISO(timeZone);
}

export function timeZoneId() {
  return Temporal.Now.timeZoneId();
}
