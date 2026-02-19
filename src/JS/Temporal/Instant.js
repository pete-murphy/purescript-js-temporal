export function _new(epochNanoseconds) {
  return new Temporal.Instant(epochNanoseconds);
}

export function _from(str) {
  return Temporal.Instant.from(str);
}

export function _fromEpochMilliseconds(ms) {
  return Temporal.Instant.fromEpochMilliseconds(ms);
}

export function _fromEpochNanoseconds(ns) {
  return Temporal.Instant.fromEpochNanoseconds(ns);
}

export const epochMilliseconds = (i) => i.epochMilliseconds;
export const epochNanoseconds = (i) => i.epochNanoseconds;

export function _add(duration, i) {
  return i.add(duration);
}

export function _subtract(duration, i) {
  return i.subtract(duration);
}

export function _until(options, other, i) {
  return i.until(other, options);
}

export function _untilNoOpts(other, i) {
  return i.until(other);
}

export function _since(options, other, i) {
  return i.since(other, options);
}

export function _sinceNoOpts(other, i) {
  return i.since(other);
}

export function _round(options, i) {
  return i.round(options);
}

export function _compare(a, b) {
  return Temporal.Instant.compare(a, b);
}

export function _equals(a, b) {
  return a.equals(b);
}

export function _toString(options, i) {
  return i.toString(options);
}

export const toString_ = (i) => i.toString();
