export function _new(components) {
  return Temporal.Duration.from(components);
}

export function _from(str) {
  return Temporal.Duration.from(str);
}

export const years = (d) => d.years;
export const months = (d) => d.months;
export const weeks = (d) => d.weeks;
export const days = (d) => d.days;
export const hours = (d) => d.hours;
export const minutes = (d) => d.minutes;
export const seconds = (d) => d.seconds;
export const milliseconds = (d) => d.milliseconds;
export const microseconds = (d) => d.microseconds;
export const nanoseconds = (d) => d.nanoseconds;
export const sign = (d) => d.sign;
export const blank = (d) => d.blank;

export function _add(other, d) {
  return d.add(other);
}

export function _subtract(other, d) {
  return d.subtract(other);
}

export const negated = (d) => d.negated();
export const abs = (d) => d.abs();

export function _compare(a, b) {
  return Temporal.Duration.compare(a, b);
}

export function _round(options, d) {
  return d.round(options);
}

export function _total(options, d) {
  return d.total(options);
}

export function _toString(options, d) {
  return d.toString(options);
}

export const toString_ = (d) => d.toString();
