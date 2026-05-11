export function _equals(a, b) {
  return a.equals(b);
}

export function _compare(a, b) {
  return Temporal.PlainTime.compare(a, b);
}

export const toString = (t) => t.toString();
