export function _fromString(str) {
  return Temporal.Instant.from(str);
}

export function _fromEpochMilliseconds(ms) {
  return Temporal.Instant.fromEpochMilliseconds(ms);
}

export function _fromEpochNanoseconds(ns) {
  return Temporal.Instant.fromEpochNanoseconds(ns);
}

export function _fromJSDate(date) {
  return Temporal.Instant.fromEpochMilliseconds(date.getTime());
}

export const epochMilliseconds = (i) => i.epochMilliseconds;
export const epochNanoseconds = (i) => i.epochNanoseconds;

export function _add(duration, i) {
  return i.add(duration);
}

export function _subtract(duration, i) {
  return i.subtract(duration);
}

export function _untilWithOptions(options, other, i) {
  return i.until(other, options);
}

export function _until(other, i) {
  return i.until(other);
}

export function _sinceWithOptions(options, other, i) {
  return i.since(other, options);
}

export function _since(other, i) {
  return i.since(other);
}

export function _round(options, i) {
  return i.round(options);
}

export function _toZonedDateTimeISO(timeZone, i) {
  return i.toZonedDateTimeISO(timeZone);
}

export function _toString(options, i) {
  return i.toString(options);
}
