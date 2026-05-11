export function unsafeCrashWith(msg) {
  return function () {
    throw new Error(msg);
  };
}
