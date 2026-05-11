export function unsafeCrashWith(msg) {
  return function () {
    throw new Error(msg);
  };
}

export function toUpper(c) {
  return c.toUpperCase();
}
