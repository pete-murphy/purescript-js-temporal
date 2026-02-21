export function _equals(a, b) {
  return a.equals(b);
}

export function _compare(a, b) {
  return Temporal.PlainDate.compare(a, b);
}

export const toString_ = (pd) => pd.toString();
