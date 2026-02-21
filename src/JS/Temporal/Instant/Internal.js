export function _equals(a, b) {
  return a.equals(b);
}

export function _compare(a, b) {
  return Temporal.Instant.compare(a, b);
}

export const toString_ = (i) => i.toString();
