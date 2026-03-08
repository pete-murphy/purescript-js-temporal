import { Temporal as TemporalPolyfill } from "@js-temporal/polyfill";

function defineMissingOwnProperties(target, source) {
  for (const propertyKey of Reflect.ownKeys(source)) {
    if (Object.prototype.hasOwnProperty.call(target, propertyKey)) {
      continue;
    }

    const sourceDescriptor = Object.getOwnPropertyDescriptor(source, propertyKey);
    if (sourceDescriptor !== undefined) {
      Object.defineProperty(target, propertyKey, sourceDescriptor);
    }
  }
}

function isTemporalPolyfillValue(value) {
  if (typeof value !== "object" || value === null || typeof value.toLocaleString !== "function") {
    return false;
  }

  return Object.prototype.toString.call(value).startsWith("[object Temporal.");
}

function temporalPolyfillTag(value) {
  return Object.prototype.toString.call(value);
}

function installDateTimeFormatTemporalBridge() {
  const patchedFormatSymbol = Symbol.for("js-temporal.polyfill.date-time-format-bridge");
  if (Intl.DateTimeFormat.prototype[patchedFormatSymbol] === true) {
    return;
  }

  const formatDescriptor = Object.getOwnPropertyDescriptor(Intl.DateTimeFormat.prototype, "format");
  if (formatDescriptor?.get === undefined) {
    return;
  }

  Object.defineProperty(Intl.DateTimeFormat.prototype, "format", {
    ...formatDescriptor,
    get() {
      const nativeFormat = formatDescriptor.get.call(this);
      return (value) => {
        if (isTemporalPolyfillValue(value)) {
          const { locale, ...options } = this.resolvedOptions();
          if (temporalPolyfillTag(value) === "[object Temporal.ZonedDateTime]") {
            delete options.timeZone;
          }
          return value.toLocaleString(locale, options);
        }

        return nativeFormat(value);
      };
    },
  });

  Object.defineProperty(Intl.DateTimeFormat.prototype, patchedFormatSymbol, {
    value: true,
    configurable: false,
    enumerable: false,
    writable: false,
  });
}

if (globalThis.Temporal === undefined) {
  globalThis.Temporal = TemporalPolyfill;
  installDateTimeFormatTemporalBridge();
} else {
  if (globalThis.Temporal.Now === undefined) {
    globalThis.Temporal.Now = {};
  }

  defineMissingOwnProperties(globalThis.Temporal.Now, TemporalPolyfill.Now);
}
