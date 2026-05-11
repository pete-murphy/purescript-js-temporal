export function _equals(a, b) {
  return a.equals(b);
}

export function _compare(a, b) {
  return Temporal.ZonedDateTime.compare(a, b);
}

export const toString = (zdt) => zdt.toString();
