// Use a fixed year to get the month: 1972 is a leap year, so February 29 is valid.
export const _isoMonth = (pmd) => pmd.toPlainDate({ year: 1972 }).month;
