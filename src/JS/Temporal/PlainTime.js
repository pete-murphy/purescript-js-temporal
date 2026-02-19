export function _new(components) {
  return Temporal.PlainTime.from(components);
}

export function _from(options, str) {
  return Temporal.PlainTime.from(str, options);
}

export function _fromNoOpts(str) {
  return Temporal.PlainTime.from(str);
}

export const hour = (t) => t.hour;
export const minute = (t) => t.minute;
export const second = (t) => t.second;
export const millisecond = (t) => t.millisecond;
export const microsecond = (t) => t.microsecond;
export const nanosecond = (t) => t.nanosecond;

export function _add(duration, t) {
  return t.add(duration);
}

export function _subtract(duration, t) {
  return t.subtract(duration);
}

export function _with(fields, t) {
  return t.with(fields);
}

export function _until(options, other, t) {
  return t.until(other, options);
}

export function _untilNoOpts(other, t) {
  return t.until(other);
}

export function _since(options, other, t) {
  return t.since(other, options);
}

export function _sinceNoOpts(other, t) {
  return t.since(other);
}

export function _round(options, t) {
  return t.round(options);
}

export function _compare(a, b) {
  return Temporal.PlainTime.compare(a, b);
}

export function _equals(a, b) {
  return a.equals(b);
}

export function _toString(options, t) {
  return t.toString(options);
}

export const toString_ = (t) => t.toString();
