# Numbers, units, dates, and equations

This file extends the number rules in the technical writing rule. The local ASCII policy overrides the guide where they differ: use a regular space, not a non-breaking space, and a hyphen, not a minus sign or an en dash.

## Numbers in text

If a rule conflicts with the requirements of your product family, follow the product-specific guideline.

| Rule | Example |
|---|---|
| Write numbers up to and including ten in full, unless the number appears with a unit of measure, is over ten, or is a logic value or clock cycle count. | `Four frames of data`; `an address width of 4, 8, or 16 bits`; `Write 1 to this bit after 0 is read`; `6 PCLKB cycles are required` |
| Use numerals for mixed numbers (whole and decimal). | `1.5 cycles` |
| Use numerals with a unit and a space between the number and the unit. | `2 bits`, `8 bytes`, `10 Hz`, `4 µs`, `32 KB`, `5 V`, `+40 °C`, `-40 °C to 85 °C` |
| Do not put a space before the percent sign. | `9%` |
| If a range shares a unit, omit the unit on the first number or repeat it. | `60 to 90 mW`, `5 V to 10 V` |
| With `phase`, use a numeral or write the number in full. If the number starts the sentence, write it in full. | `3-phase`, `Three-phase` |
| With `wire`, use a numeral. If the number starts the sentence, write it in full. | `2-wire`, `Two-wire` |
| For multiples of a value, use numerals. | `Multiple of 4` |
| For a number of times, write zero through ten in full and use numerals above ten. | `One time` (or `once`), `Two times` (or `twice`), `100 times` |
| If a number starts a sentence, write it in full. Rephrase the sentence if possible. | `Forty bytes are` |
| Hyphenate compound numbers. | `Forty-eight` |
| Use a period as the decimal point. | `12.34` |
| Do not use a comma to separate thousands. | `12345.67` |
| Avoid fractions. | `Half-byte`, not `1/2 byte` |
| In an inline list, keep each number with its unit. | `16-bit and 32-bit`, not `16- and 32-bit` |
| Enclose a single bit and a bit range in square brackets. | `[9]`, `[7:0]` |

- Do not write both a numeral and a word for the same number.
- Write a percentage with numerals and the percent symbol. Write `Ten percent` in full when the percentage begins a sentence or heading.
- Make a numeral plural by adding `s`: `the number of 1s in the parity bit`.
- Do not separate a number from its unit at the end of a line. Keep them together where the output format supports it.

## Hexadecimal, binary, negative numbers, and ranges

- Write hexadecimal numbers with a lowercase `x` prefix and uppercase digits for non-digit values: `0xFFDD00CC`. Do not use the `h` suffix.
- Add an underscore for each 16 bits when the number is an address: `0xFFDD_00CC`, `0xAABB_CCDD_0000_1111`.
- Write binary numbers with the suffix `b`: `1001001b`.
- In MCU and MPU documentation, write a binary number of four or more digits in hexadecimal: write `0x1`, not `0001b`.
- Write negative values with a hyphen and no space: `-12`.
- Write a number range with a hyphen and no spaces: `12-19`.
- Write bit numbers in square brackets with a space before the bracket: `bit [2]`, `bits [5:3]`. With a symbol name, do not add a space: `CKS[2]`, `CKS[7:0]`.

## Units of measurement

Use only the approved units. Do not abbreviate other units.

| Symbol | Name | Measure |
|---|---|---|
| `°` | Degree | Temperature |
| `A` | Ampere | Electric current |
| `0b` | Bit | Binary digit. Do not abbreviate `bit` in text. |
| `B` | Byte | Use only with the prefixes `K`, `M`, `G`, `T`, `P`, and `E`. Do not abbreviate `byte` in text. |
| `F` | Farad | Electrical capacitance |
| `g` | Gram | Mass |
| `H` | Henry | Magnetic inductance |
| `Hi-Z` | - | High impedance |
| `Hz` | Hertz | Frequency |
| `m` | Meter | Length |
| `MIPS` | - | Million instructions per second |
| `s` | Second | Time |
| `V` | Volt | Potential difference, electromotive force |
| `Ω` or `R` | Ohm | Electrical resistance, reactance, impedance |
| `W` | Watt | Power |

Unit prefixes in ascending order:

| Symbol | Prefix | Factor |
|---|---|---|
| `a` | Atto | 10^-18 |
| `f` | Femto | 10^-15 |
| `p` | Pico | 10^-12 |
| `n` | Nano | 10^-9 |
| `µ` | Micro | 10^-6 |
| `m` | Milli | 10^-3 |
| `k` | Kilo | 10^3. Use `K`, 1024, when referring to computer memory or disk space. |
| `M` | Mega | 10^6 |
| `G` | Giga | 10^9 |
| `T` | Tera | 10^12 |
| `P` | Peta | 10^15 |
| `E` | Exa | 10^18 |

Common unit and prefix combinations:

| Abbreviation | Description |
|---|---|
| `Kb` | Kilobit, for computer memory or disk space |
| `kbps` | Kilobit per second, for data transfer rate or speed |
| `KB` | Kilobyte, for computer memory or disk space |
| `KBps` | Kilobyte per second, for data transfer rate or speed |
| `kHz`, `kV`, `kW` | Kilohertz, kilovolt, kilowatt |
| `Mb`, `Mbps` | Megabit, megabit per second |
| `MB`, `MBps` | Megabyte, megabytes per second |
| `MHz`, `MW` | Megahertz, megawatt |
| `mHz`, `mm`, `ms`, `mV`, `mW` | Millihertz, millimeter, millisecond, millivolt, milliwatt |
| `Gb`, `GB`, `GHz` | Gigabit, gigabyte, gigahertz |
| `TB` | Terabyte |
| `µg`, `µm`, `µW`, `µs` | Microgram, micrometer, microwatt, microsecond |

Follow the International System of Units (SI) conventions published by the National Institute of Standards and Technology (NIST) for any unit not listed here.

## Dates and times

- Use the American English style for dates. Do not use a comma when only the month and year are given. Abbreviate only months of five or more letters.

| Month, day, and year in full | Abbreviated | Month and year abbreviated | Month and year in full |
|---|---|---|---|
| `January 1, 2015` | `Jan. 1, 2015` | `Jan. 2015` | `January 2015` |
| `May 1, 2015` | `May 1, 2015` | `May 2015` | `May 2015` |
| `September 1, 2015` | `Sept. 1, 2015` | `Sept. 2015` | `September 2015` |

- Write the complete month name whenever possible, and all four digits of the year if space allows.
- If the international style is required, write the day, month, and year without punctuation: `23 September 2015`. Do not use ordinal numbers such as `1st`, `2nd`, or `3rd`. Use letters, not numbers, for an abbreviated month.
- Use a 12-hour or a 24-hour clock, and use it consistently.
- With a 12-hour clock, write numerals followed by lowercase `a.m.` or `p.m.`: `6:30 a.m.` Do not add a second period at the end of a sentence. Do not write `am`, `pm`, `AM`, or `PM`. Do not combine `a.m.` or `p.m.` with `morning`, `noon`, `afternoon`, `evening`, `night`, or `midnight`. Do not write `o'clock` with a numeral.
- With a 24-hour clock, do not use `a.m.` or `p.m.`. Use `hh:mm` or `hh:mm:ss`: `01:23`, `01:23:45`.
- To indicate a range of dates or times, write `to` or `and`: `9:15 a.m. to 3:45 p.m.`, `between 12:00 noon and 3:00 p.m.` Do not use a hyphen.

## Equations and mathematical symbols

- Type a simple equation in line with the text and format it with the appropriate typeface.
- Use the same symbols consistently in a document.
- Do not put a space between a negative, positive, or plus-or-minus sign and the number it qualifies: `-8`, `±60 V`.
- Use `×`, not the letter `x`, for dimensions and multiplication: `23 × 5`.
- Use a hyphen for subtraction and negative values. The ASCII policy replaces the minus sign (`−`) that the guide specifies.
- Create a complex equation, or an equation with symbols that a typeface change cannot format, in a drawing tool and insert it as a figure.
