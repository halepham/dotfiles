# Terminology and word choice

Use this file to check spelling, hyphenation, acronyms, and word choice in technical content. Use the form in the first column.

## Common errors

### Applying power to a device

- Power is applied to a device, so use `power up` and `power down`, not `power on` and `power off`.
- Use `power up` and `power down` as verbs, without a hyphen: `power up a processor`.
- Use `powerup` and `powerdown` as nouns.

### Prefix non

- Hyphenate `non` when the main body of the word begins with a vowel, an `n`, or an uppercase letter: `non-existent`, `non-native`, `non-ModelGen`, `Non-Confidential`.
- Do not hyphenate in other cases: `nonvolatile`, `nonrecurrent`, `nonreentrant`.
- Use a space instead of a hyphen when the main body of the word is already hyphenated: `non word-aligned`.
- An exception is `Non-secure`, as in `Non-secure state` and `Non-secure region`.

### Hyphens, spaces, and word meanings

| Noun or adjective | Verb |
|---|---|
| `setup` | `set up` |
| `plug-in` | `plug in` |
| `login` | `log in` |

- Write `memory map` as a noun and `memory-mapped` as an adjective: `The CPU has a default memory map.` `The CPU is memory-mapped.`
- Do not hyphenate a compound modifier whose first term is an adverb ending in `-ly`: `closely followed`.
- Technical terms are an exception: `fully-associative` and `closely-coupled` are hyphenated.
- Check hyphenated words in Merriam-Webster's Collegiate Dictionary or the Chicago Manual of Style. They might not include some accepted technical terms.
- A hyphen can change meaning. `command-line interface` is an interface, but `command line interface` can read as a command called `line interface`. Check the context before you add or remove a hyphen.

### Interrupts

- IRQ and FIQ are interrupts. Do not use any other name for them.
- Write `IRQ interrupt` and `FIQ interrupt`. Never write `fast interrupt`, because architecturally nothing is fast about an FIQ.
- NMFI means non-maskable FIQ. Never include the word `fast` in a definition or description of NMFI.

### NUL and NULL

- `NUL` is the ASCII character that terminates a string in C.
- `NULL` is a special pointer value that indicates that the pointer points to no value.

## Common terms

Terms are in alphabetical order. A numeral entry such as `2-phase` follows the entries that begin with a letter.

| Term | Rule |
|---|---|
| `5 V-tolerant` | `V-tolerant` is hyphenated. |
| `active-low`, `active-high` | Hyphenated. |
| `AC/DC`, `DC/DC` | Always use a forward slash. |
| `auto-configure` | Always include a hyphen. |
| `Analog-to-Digital Converter` | Always include hyphens. Use the full spelling at first occurrence, then `ADC`. |
| `back-end` | Hyphenated. |
| `bandpass` | One word. |
| `bidirectional` | One word. |
| `bootstrap` | One word. |
| `brownout` | One word. |
| `built-in` | No hyphen as a verb (`the filters are built in`). Hyphen as a compound adjective (`a built-in variable`). |
| `by a program` | Write `by software`. |
| `cacheable` | Do not write `cachable`. |
| `cannot` | One word. |
| `closely-coupled` | Hyphenated. |
| `common-mode` | Always include a hyphen. |
| `crossover` | One word, no hyphen. |
| `cross-coupling` | Always use a hyphen. |
| `daisy chain` | No hyphen. Lowercase unless it starts the sentence. |
| `dead time` | Two words. |
| `deassert`, `deasserted` | One word. |
| `deinterlace` | One word. |
| `Digitally Controlled Potentiometer` | Three words, no hyphen. |
| `Digital-to-Analog Converter` | Always include hyphens. Use the full spelling at first occurrence, then `DAC`. |
| `duty cycle` | Two words. |
| `dv/dt` | Always lowercase with a forward slash. |
| `electro-static discharge` | `electro-static` is hyphenated. |
| `feed-forward` | Hyphenated. |
| `fine-tune`, `fine-tuning` | Hyphenated. |
| `form-factor` | Hyphenated. |
| `front-end` | Hyphenated. |
| `fully-associative` | Hyphenated. |
| `handheld` | One word. |
| `hassle-free` | Hyphenated. |
| `high`, `low` (signal level) | Lowercase unless the word starts the sentence. |
| `high-current`, `high-efficiency`, `high-speed` (adjective) | Hyphenated. |
| `high-pass filter`, `low-pass filter` | `high-pass` and `low-pass` are hyphenated. |
| `high-side FET`, `low-side FET` | `high-side` and `low-side` are hyphenated. |
| `high to low`, `low to high` | No hyphens. |
| `highly integrated` | Two words, no hyphen. |
| `Hi-Z` | Hyphenated. |
| `I2C`, `I3C` | Superscript the number where the format supports it. |
| `inrush` | One word. |
| `laser-based` | Hyphenated. |
| `latch-up` | Hyphenated. |
| `least significant`, `most significant` | No hyphen. |
| `light load` | Two words, unless it is a compound adjective: `light-load efficiency`. |
| `Li-ion` | Hyphenated. |
| `load line` | Two words, no hyphen. |
| `lockout` | One word. |
| `log in` | Two words as a verb. `login` is one word as a noun or adjective. |
| `look-up` | Hyphenated. |
| `lux` | Always lowercase, with a space between the number and the unit. |
| `makefile` | One word. Do not write `make file`. |
| `memory map` | Two words as a noun. `memory-mapped` as an adjective. |
| `micropower` | One word. |
| `microcontroller` | One word. Do not write `micro-controller` or `micro controller`. |
| `multi-cell` | Hyphenated. |
| `multiformat` | One word. |
| `multiphase` | One word. |
| `Multiplexers` or `MUXs` | Write `multiplexers` in full. Use `MUXs` only where space is limited, such as in navigation, a heading, or a graphic. Never write `MUXes`. |
| `NFET`, `PFET` | No hyphens. |
| `non-existent`, `non-native`, `non-secure` | Hyphenated. |
| `nonrecurrent`, `nonreentrant`, `nonvolatile` | No hyphens. |
| `non word-aligned` | See the prefix `non` rules. |
| `NUL` | All uppercase when it refers to the ASCII string terminator in C. |
| `off-time` | Hyphenated. |
| `OFF isolation` | Two words, unless it is a compound adjective: `off-isolation circuit`. |
| `ON-resistance` | Hyphenated. |
| `one-phase`, `1-phase` | Hyphenated. |
| `Op Amp` | Two words, no hyphen. |
| `open-drain`, `open-wire` | Hyphenated as a compound adjective. No hyphen otherwise: `the pin is an open drain`. |
| `out-of-bounds`, `out-of-phase` | Hyphenated. |
| `overclocking`, `overcurrent`, `overvoltage` | One word. |
| `over-range`, `over-erase` | Hyphenated. |
| `over-temperature` | Hyphenated if the context is a fault. Two words if something is over the temperature range: `load regulation over temperature`. |
| `peak-to-peak` | Hyphenated. |
| `piezoelectric` | One word. |
| `pinout` | One word. |
| `pin-strap` | Hyphenated. |
| `plug-in` | Hyphenated as a noun or adjective. Two words, no hyphen, as a verb. |
| `point-of-load` | Hyphenated. |
| `post-irradiation`, `pre-irradiation` | Hyphenated. |
| `power-on`, `power-good` | Hyphenated. |
| `power-on reset` | `power-on` is hyphenated. |
| `powerup`, `powerdown` | One word as a noun. Two words as a verb. |
| `preamp`, `preamplifier`, `precharge` | One word. |
| `pre-enabled`, `re-enabled` | Hyphenated. Removing the hyphen changes the meaning. |
| `pull-up`, `pull-down` | Hyphenated. |
| `Pulse-Width Modulation (PWM)` | `Pulse-Width` is hyphenated and initial-capitalized when used with the acronym. |
| `push-pull` | Hyphenated as an adjective. Do not capitalize it: `push-pull oscillator`. |
| `r`DS(ON) | Lowercase `r`, with `DS(ON)` subscripted. |
| `rail-to-rail` | Hyphenated. |
| `ramp-up`, `ramp up` | Hyphenated as a noun. Two words as a verb. |
| `remote wake-up` | `wake-up` is hyphenated. |
| `reprogram`, `restart`, `reuse` | One word. |
| `ringback` | One word as a noun or adjective. Two words as a verb. |
| `round-robin` | Hyphenated. |
| `short-circuit` | Hyphenated. |
| `shutdown`, `shut down` | One word as a noun. Two words as a verb. |
| `set-top box` | `set-top` is hyphenated. |
| `setup` | One word as a noun. Two words as a verb. Hyphenated as a compound adjective. |
| `side by side` | No hyphens, unless it is an adjective. |
| `single-ended` | Hyphenated. |
| `single supply` | No hyphen. |
| `soft-start`, `soft starting` | Hyphenated. |
| `space-saving` | Hyphenated. |
| `standalone`, `standby` | One word. |
| `START`, `STOP`, `READ`, `WRITE` | All uppercase when used as a command name. |
| `SuperCap` | Proper noun. One word, with `S` and `C` capitalized. |
| `supercapacitor` | One word. |
| `three-state`, `3-state`, `tri-state` | Hyphenated. |
| `timing diagram` | Do not write `timing chart`. |
| `trade-offs` | Hyphenated. |
| `transconductance` | One word. |
| `turn-off`, `turn-on` | Hyphenated as a noun or compound adjective. Two words, no hyphen, as a verb. |
| `2-phase`, `3-phase`, `two-phase`, `three-phase` | Write the number in full if the term starts the sentence. |
| `2-wire`, `3-wire`, `two-wire`, `three-wire` | Write the number in full if the term starts the sentence. |
| `undercurrent`, `undervoltage` | One word. |
| `user-programmable` | Hyphenated as a compound adjective. |
| `V`COM | Uppercase `V`, with `com` subscripted in small caps. |
| `X-ray` | Hyphenated, with `X` always capitalized. |
| `wait time` | Two words. |
| `wakeup`, `wake up` | One word as a noun or adjective. Two words as a verb. |

## Common acronyms

Define each acronym at first use. Do not define widely recognized acronyms.

| Acronym | Expansion |
|---|---|
| `ACIA` | Asynchronous Communications Interface Adapter |
| `ADC` | Analog-to-Digital Converter |
| `AES` | Advanced Encryption Standard |
| `AHB` | Advanced High-Performance Bus |
| `AHB-AP` | AHB Access Port |
| `APB` | Advanced Peripheral Bus |
| `ATB` | Advanced Trace Bus |
| `BCD` | Binary Coded Decimal |
| `BER` | Bit Error Rate |
| `BSDL` | Boundary Scan Description Language |
| `C-RAN` | Cloud Radio Access Network |
| `DAC` | Digital-to-Analog Converter |
| `DES` | Data Encryption Standard |
| `DIMM` | Dual In-Line Memory Module |
| `DMA` | Direct Memory Access |
| `DRAM` | Digital Random Access Memory |
| `DSA` | Digital Signature Algorithm |
| `ECC` | Elliptic Curve Cryptography |
| `ETB` | Embedded Trace Buffer |
| `ETM` | Embedded Trace Macrocell |
| `FLL` | Frequency Locked Loop |
| `FOD` | Fractional Output Divider |
| `FPU` | Floating-Point Unit |
| `GSM` | Global System for Mobile Communications |
| `HMI` | Human Machine Interface |
| `HPC` | High Performance Computing |
| `I/O` | Input/Output |
| `IrDA` | Infrared Data Association |
| `LAN` | Local Area Network |
| `LIU` | Line Interface Unit |
| `LRDIMM` | Load Reduced DIMM |
| `LSB` | Least Significant Bit |
| `MIP` | Memory Interface Product |
| `MSB` | Most Significant Bit |
| `MUX` | Multiplexer |
| `NVDIMM` | Nonvolatile Dual In-Line Memory Module |
| `NVIC` | Nested Vector Interrupt Controller |
| `OTP` | One-Time Programmable |
| `PC` | Program Counter |
| `PFS` | Port Function Select |
| `PHY` | The physical layer of the OSI model in a network interface controller |
| `PLL` | Phase-Locked Loop |
| `PoE` | Power over Ethernet |
| `PON` | Passive Optical Network |
| `POR` | Power-On Reset |
| `PWM` | Pulse Width Modulation |
| `RAM` | Random Access Memory |
| `RDIMM` | Registered DIMM |
| `RMS` | Root Mean Square |
| `RSA` | Rivest Shamir Adleman |
| `R/W` | Read/Write |
| `SerDes` | Serializer/Deserializer |
| `SHA` | Secure Hash Algorithm |
| `S/H` | Sample and Hold |
| `SIP` | Signal Integrity Product or Single In-line Pin (Package) |
| `SDRAM` | Synchronous Dynamic Random-Access Memory |
| `SRAM` | Standby RAM |
| `SNR` | Signal-to-Noise Ratio |
| `SP` | Stack Pointer |
| `SyncE` | Synchronous Ethernet |
| `SWD` | Serial Wire Debug |
| `SW-DP` | Serial Wire-Debug Port |
| `TRNG` | True Random Number Generator |
| `UART` | Universal Asynchronous Receiver/Transmitter |
| `VSWR` | Voltage Standing Wave Ratio |

## Words and phrases to avoid

Certain words do not translate well and can cause confusion. Use the suggested alternative.

| Avoid | Use | Comment |
|---|---|---|
| `above`, `below`, `in the above`, `in the below` | A cross-reference to the specific text, or `in the specified` | Readers can be unfamiliar with `above` and `below` as position words. Avoiding them also protects the text against changes in the order of information. |
| `all-ones` | `all 1s` | Write numeric 1 for bit value 1. |
| `all-zeros` | `all 0s` | Write numeric 0 for bit value 0. |
| `a majority of` | `most` | - |
| `and so on` | `such as` | Too vague. Reword to give specific examples. |
| `as` | `because` | Do not use `as` when you mean `because`. `as` can also be read as a comparison. |
| `as the starting` | `at the start` | - |
| `at this moment` | `when` | Too verbose. |
| `by means of` | `by` | Too verbose. |
| `cachable` | `cacheable` | - |
| `choose` | `select` | - |
| `current version`, `earlier version`, `previous version`, `latest version` | The version number of the product | These phrases are hard to maintain when it becomes unclear which version they refer to. |
| `could`, `would` | `can`, or rewrite | If you replace the word with `must`, check that the required meaning is preserved. |
| `desire`, `desired` | `want`, `require`, `wanted`, `required` | `desire` is inappropriate in technical documentation. |
| `detail`, `details`, `detailed` | `describe`, `describes`, `described` | `detail` is acceptable as a noun. |
| `discuss`, `discusses`, `discussed` | `describe`, `describes`, `described` | Always forbidden, because `discuss` implies two-way communication. |
| `due to`, `due to the fact that` | `because of`, `from` | Depends on context. Do not use `due to` when you mean `because of`. |
| `e.g.` | `for example` | Latin abbreviations do not translate well. |
| `etc.` | Reword, or use an ellipsis (`...`) | Latin abbreviations do not translate well. |
| `i.e.` | `that is`, `this means` | Latin abbreviations do not translate well. |
| `n.b.` | `In particular`, or a `Note:` | Latin abbreviations do not translate well. |
| `further` | `more`, `additional` | - |
| `hence` | `therefore`, `so` | Use `Therefore` at the start of a sentence. Use `so` inside a sentence. |
| `in the case of` | `when`, `for` | - |
| `in case that` | `for`, `in case of` | Do not use `in case that` when you mean `for xyz`. |
| `if` | `whether` | Do not use `if` when you mean `whether`. |
| `in order that`, `in order to` | `so that`, `to` | Too verbose. |
| `in the event that` | `if` | Too verbose. |
| `in the usual way` | Rephrase | Not all readers know the usual way. Be specific. |
| `judge` | `determine` | `judge` can relate to law or court proceedings, where it refers to an official who presides over a court. In general use it can mean to form an opinion. If you use it in a technical document, make sure that the context makes the meaning clear. |
| `just` | - | Not necessary. |
| `mandate` | `require` | Check the context before you replace `mandate`. |
| `make file` | `makefile` | Use `makefile` where it is well defined. |
| `may` | `might`, `can` | `may` is ambiguous. It can mean that something might happen or that something is permitted. |
| `need to` | `require`, `must`, `want`, `to` | - |
| `note that` | A `Note:` paragraph, or part of the sentence | - |
| `notwithstanding`, `nor does` | Rephrase | - |
| `on a regular basis` | `regularly` | Too verbose. |
| `on the fly` | `dynamically` | Rephrase. |
| `once` | `when` | Unless `once` means one time. |
| `please` | Do not use | Do not use in technical documents. |
| `refer to` | `see` | `see` is one word and costs less to translate. `refer to` directs the reader to an external source. |
| `selective` | `optional` | - |
| `simply` | - | Not necessary. |
| `since` | `because` | Do not use `since` when you mean `because`. |
| `small in size` | `small` | - |
| `such that` | `so that` | - |
| `current`, `now`, `at present`, `currently`, `presently` | Rewrite the sentence in present tense | Write `The library deprecates this feature`, not `this feature is now deprecated`. |
| `the user` | `you`, or the imperative form | The reader implies `you`. |
| `thus` | `therefore` | - |
| `thru` | `through` | - |
| `X and/or Y` | Rewrite | `and/or` creates uncertainty. Write `one or both of X and Y` if both meanings apply. |
| `unmatch` | `non-match` or `mismatch`, depending on the context | In a microcontroller user's manual, non-match means a condition for which matching does not exist. Mismatch means that matching conditions exist but are not the same. |
| `upon` | `when`, `on` | Depends on context. |
| `utilize` | `use` | Use simple language. |
| `used to` | Rewrite | Ambiguous. It can indicate past tense or that something facilitates something else. |
| `via` | `through`, `using`, `with`, `by` | `via` is allowed, but use it sparingly. |
| `when in the case` | `when` | Too verbose. |
| `which` | - | `which` can be replaced by `that` in a defining clause. |
| `whilst` | `while` | Use International English. |
| `will`, `shall` | Avoid future tense | Rewrite in the present tense. Do not use `shall` in the body text of a technical document. It belongs in legal notices. |
| `wish` | `want` | - |
| `with regard to` | `about` | - |

## Misused and misspelled words

This table is a selection from the guide. It omits low-value pairs such as `a lot` and `alot`, `all right` and `alright`, `everyday` and `every day`, `awhile` and `a while`, `kind` and `type`, `problem` and `issue`, `their`, `there`, and `they're`, and `your` and `you're`.

| Words | Guidance |
|---|---|
| `about`, `with respect to` | Use `about` to mean approximately or on the subject of. Use `with respect to` to say what something relates to. |
| `adapter`, `adaptor` | Use `adapter` (International English). |
| `affect`, `effect` | `affect` is a verb that means to influence. `effect` is a noun that means a result. |
| `amount`, `number` | Use `amount` for mass quantities. Use `number` for countable items. |
| `appear`, `display` | Use `appear` when the action has no direct object: `a message appears`. Use `display` when it has one: `the program displays a message`. |
| `between`, `among` | Use `between` with two items. Use `among` with more than two. |
| `can`, `may` | `can` refers to ability. `may` refers to possibility or permission. See also the entry for `may` above. |
| `complete`, `finish` | `complete` takes a direct object: `complete the procedure`. `finish` does not: `allow the procedure to finish`. |
| `complex`, `complicated` | `complex` means that the structure has many connected parts. `complicated` means difficult to use or understand. |
| `comprise`, `consist of` | Do not write `comprised of`. Use `consist of` where possible: `The system consists of a microcontroller and several peripheral devices.` |
| `different from`, `different than` | Use `different from` in American English. |
| `either/or`, `neither/nor` | Use these pairs with two items only. For more than two items, write `Choose A, B, C, or D.` |
| `fewer`, `less` | Use `fewer` for countable items. Use `less` for mass quantities. |
| `following`, `below` | `following` introduces information that directly follows. Avoid `below` to indicate position. |
| `when`, `if` | Use `when` for a future situation that is certain. Use `if` for a possible or unreal condition. |
| `through`, `thru`, `trough` | `through` indicates passage from one end or boundary to another. `thru` is not the correct spelling. `trough` is the minimum or lowest point within a cycle. |
| `respectively` | Avoid it when possible. Write `Set the bit PM01 to 0 and bit PM02 to 1.` |
| `that`, `which` | `that` introduces a restrictive clause. `which`, preceded by a comma, introduces a nonrestrictive clause. |
| `versus`, `vs.` | Avoid this Latin term. If you must use it, spell out `versus` in text and use `vs.` only in headings, titles, tables, or figures where space is tight. |
| `its`, `it's` | Do not use the contraction `it's`. Write `it is`. |
