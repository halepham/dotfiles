---
paths:
  - "docs/**/*.md"
  - "docs/**/*.rst"
  - "docs/**/*.adoc"
  - "**/*.md"
  - "**/*.rst"
  - "**/*.adoc"
  - "**/*.c"
  - "**/*.h"
  - "**/*.cpp"
  - "**/*.hpp"
  - "**/*.py"
  - "**/*.js"
  - "**/*.ts"
  - "**/*.java"
  - "**/*.go"
  - "**/*.rs"
---

# Technical writing rules

Apply these rules when creating or editing customer-facing technical documentation, code comments, API documentation, release notes, changelog entries, commit messages, and pull request descriptions.

If a product-specific documentation style guide, business-unit requirement, or repository convention conflicts with these rules, follow the more specific requirement.

## Core writing style

- Prioritize clarity, conciseness, accuracy, consistency, and maintainability.
- Use International English. For example, use `initialize`, `analyze`, `color`, `behavior`, `canceled`, `labeled`, `learned`, and `dialog`, not `initialise`, `analyse`, `colour`, `behaviour`, `cancelled`, `labelled`, `learnt`, and `dialogue`. Do not alter a name that comes from code or a user interface.
- Treat `data` as a mass noun with a singular verb: `The data is transferred on the AXI bus.`
- Write all documentation, code comments, commit messages, pull request descriptions, and changelog entries in English, regardless of the language used in the conversation or request. Do not switch to the conversation's language, for example Vietnamese, for these deliverables.
- Prefer present tense and active voice. Avoid past tense and future tense where possible.
- Use passive voice only when the agent is unknown, irrelevant, sensitive, or when describing device behavior that the reader cannot control.
- Write instructions in second person or imperative form. Start each procedural step with an action verb.
- Avoid first person (`I`, `we`).
- Put the main idea at the start of a sentence. Split long sentences. State points positively where possible.
- Rewrite nominal constructions into direct statements: write `Take the measurements`, not `Measurements are taken`.
- Avoid `there is` and `there are` when a direct subject is clear: write `A voltage comparator checks...`, not `There is a voltage comparator that checks...`.
- Do not turn nouns into verbs.
- Place adjectives and adverbs next to the words they modify. Do not stack more than three modifiers before a noun.
- Keep essential articles (`a`, `an`, `the`) and relative pronouns (`that`, `who`).
- Use parallel structure in lists, headings of the same level, and table entries.
- Use simple, precise, industry-standard terminology.
- Use one term consistently for one concept. Do not use synonyms merely for variety.
- Avoid idioms, slang, contractions, vague pronouns, and unnecessary jargon.
- Avoid Latin abbreviations and ambiguous expressions. Write `for example` for `e.g.`, `that is` for `i.e.`, `In particular` for `n.b.`, and reword `etc.`. Reword `and/or` to state exactly one meaning.
- Prefer `because` over `since` when stating a cause.
- Avoid temporal terms such as `currently`, `now`, `latest`, and `previous version`. State the applicable version, behavior, or condition directly.
- Do not use bold, italics, quotation marks, capitalization, or underlining only for emphasis. A required typeface convention, such as bold for GUI names and table column headings, is not emphasis.
- Do not use an em dash (`—`). Replace it with a comma, colon, semicolon, parentheses, or a separate sentence, depending on which relationship the surrounding text expresses.
- Use plain ASCII characters. Do not use emoji, decorative symbols, or pictographic icons in prose, headings, tables, code comments, commit messages, or pull request descriptions.
- Use straight quotation marks (`"` and `'`), not curly or smart quotes (`“ ” ‘ ’`).
- Write three periods (`...`) for an ellipsis. Do not use the ellipsis character (`…`).
- Use a regular space. Do not use a non-breaking space or other non-ASCII whitespace character, except where required between a number and a unit and the output format supports it.
- Do not use decorative bullet glyphs (`•`, `●`, `▪`, `»`) in prose. Use the standard Markdown list marker (`-` or a number).
- Do not use arrow glyphs (`→`, `⇒`, `↔`) in prose. Write `to` or restructure the sentence. Arrows remain allowed inside a figure or diagram where they convey a flow or connection.
- Do not use symbol shorthand such as `✓`, `✗`, `★`, or `⚠` to indicate status or severity. Use a word such as `Pass`, `Fail`, `Yes`, `No`, `Warning`, or `Note`.
- An approved standard unit or mathematical symbol required for technical accuracy, such as `µ`, `Ω`, `°`, `×`, or `±`, remains allowed when no ASCII substitute preserves the technical meaning and the output format supports it.

## Acronyms and abbreviations

- Define an acronym at first use as `Full Term (ACRONYM)`.
- In long documents, define an acronym again at its first use in each major section when helpful.
- Do not define an acronym used only once unless it is more familiar than the full term.
- After the definition, use either the acronym or the full term in a short document. Do not alternate between them.
- Do not define widely recognized acronyms such as `IC`, `RAM`, and `LED`.
- Do not use apostrophes or parentheses to pluralize acronyms. Write `MCUs`, not `MCU's` or `MCU(s)`.
- Do not capitalize the expansion of an acronym that is normally lowercase: `digital signal processing (DSP)`.
- Do not use `PC` to mean personal computer. Use a specific term such as `Windows workstation` when needed. In technical documentation, `PC` means Program Counter.

## Procedures and lists

- Use ordered lists for order-dependent procedures.
- Introduce a list with a sentence or phrase ending in a colon.
- Start each procedural step with a verb.
- Make each ordered-list item a complete sentence. Begin with a capital letter and end with a period.
- Keep an action and its result in the same step.
- Use bulleted lists for unordered items.
- Keep all list items parallel in grammar, syntax, and punctuation.
- Use a serial comma in lists of three or more items.
- Do not use standalone `and`, `or`, or `but` text between list items.

## Numbers, units, code, and registers

- Spell out numbers from zero through ten in normal prose unless they appear with units, values above ten, logic values, or clock cycles.
- Use numerals with units and place a space between the number and unit: `10 MHz`, `32 KB`, `5 V`.
- Keep a number and its unit together where formatting supports it.
- Do not use commas as decimal or thousands separators. Write `1000`, not `1,000`.
- Use a period as the decimal separator: `12.34`.
- Do not use a space before `%`: `9%`.
- Write a number in full if it begins a sentence, or rephrase the sentence.
- Do not write both a numeral and a word for the same number.
- Write the plural of a numeral with `s`: `1s`.
- Use `0x` followed by uppercase hexadecimal digits for hexadecimal values: `0xFFDD_00CC`. Do not use the `h` suffix.
- In MCU and MPU documentation, write a binary value of four or more digits in hexadecimal: write `0x1`, not `0001b`.
- Use underscores to group hexadecimal addresses by 16-bit blocks: `0xAABB_CCDD_0000_1111`.
- Write bit references as `bit [2]` or `bits [7:0]`. With a symbol name, write `CKS[2]` or `CKS[7:0]`.
- Include parentheses when referring to a function: `foo()`.
- Use monospace formatting for code, commands, file names, program names, function names, and code examples.
- Preserve code syntax, capitalization, UI labels, register names, signal names, and product names exactly as provided.
- On first use, write a descriptive register name followed by its short name in parentheses: `DTC Control Register (DTCCR)`.
- Use a space before, but not after, the pointer asterisk: `int *p = NULL;`.

## Tables, figures, and cross-references

- Use sentence case for figure titles, table titles, and table column headings.
- Write table column headings in bold.
- Refer to every figure and table from preceding text.
- Do not leave a table cell empty. Use a hyphen (`-`), not an em dash, where a blank value must be shown.
- Use `TBD` for unresolved author notes. Remove all TBDs before release.
- Repeat a small amount of information instead of adding an unnecessary cross-reference.
- Do not use excessive, circular, temporary, or difficult-to-maintain cross-references.
- Use `See` for internal documentation cross-references.

## Punctuation

- Write `and`, not an ampersand (`&`), in prose.
- Do not use an apostrophe for the possessive in technical prose. Rewrite the sentence. Exceptions are `Two's complement` and proper names.
- Use a colon only to introduce a list, a non-numbered example, or a complex equation, and inside a bit range or ratio. Do not put a dash after a colon.
- Do not use a colon after `such as`, `including`, or a form of `to be` or `to have`.
- Avoid comma splices. Use separate sentences.
- Place the period of a sentence outside closing parentheses, unless the parentheses enclose a complete sentence.
- Use square brackets in prose only for bit numbers and bit ranges. Do not use braces in prose.
- Do not use a forward slash in prose, except in fixed pairs such as `start/stop`, `on/off`, `A/D`, `I/O`, and `read/write`, and in paths and URLs. Do not put a space before or after a slash.
- Do not use a contraction. The phrase `don't care` is allowed to describe a hardware value.

## Words and phrases to avoid

Replace these words and phrases. Where the replacement column shows a dash, delete the word.

| Avoid | Use |
|---|---|
| `above`, `below`, `in the above` | A cross-reference to the specific text |
| `utilize` | `use` |
| `via` | `through`, `using`, `with`, or `by`; use `via` sparingly |
| `will`, `shall` | Present tense |
| `please`, `simply`, `just` | - |
| `due to`, `due to the fact that` | `because of`, `from` |
| `once` (meaning `when`) | `when` |
| `hence`, `thus` | `therefore`, `so` |
| `refer to` (internal) | `see` |
| `thru` | `through` |
| `whilst` | `while` |
| `the user` | `you`, or an imperative verb |
| `may` (ambiguous) | `might` or `can` |
| `could`, `would` | `can`, or rewrite |
| `discuss` | `describe` |
| `judge` | `determine` |
| `desire`, `wish` | `want`, `require` |
| `choose` | `select` |
| `in order to`, `in the event that`, `by means of` | `to`, `if`, `by` |
| `and so on` | `such as`, with specific examples |
| `note that` | A `Note:` paragraph, or rewrite |
| `all-ones`, `all-zeros` | `all 1s`, `all 0s` |
| `which` in a defining clause | `that` |

For the complete list, see the `technical-publications` skill.

## Self-contained comments and documentation

When writing code comments, code documentation, API documentation, commit messages, pull request summaries, changelog entries, or technical documentation:

- Write content that remains understandable without access to the chat conversation, user prompts, handoff notes, temporary planning files, or design discussions.
- Describe code behavior, technical requirements, design rationale, constraints, invariants, assumptions, limitations, or edge cases directly.
- Do not refer to the chat conversation, user instructions, user choices, handoff files, temporary plans, or design documents as the reason for an implementation.
- Do not write content such as:
  - `Per ARCHITECTURE.md section 3.2, use polling.`
  - `As discussed in the handoff, this is temporary.`
  - `The user chose this approach.`
  - `This follows the previous chat decision.`
  - `According to the design document, use this implementation.`
- Convert contextual information into durable technical rationale.

Prefer:

```c
// Poll the status register because this device does not provide a completion interrupt.
```

Instead of:

```c
// Per ARCHITECTURE.md section 3.2, use polling.
```

Prefer:

```c
// Limit retries to prevent initialization from blocking indefinitely when the device is unavailable.
```

Instead of:

```c
// The user requested a retry limit during the handoff.
```

- If a reference is essential for future maintenance, refer only to a stable and relevant artifact that maintainers can access and verify, such as:
  - A published hardware specification
  - A stable API contract
  - A permanent issue or change-request ID
  - A versioned public interface specification
- Even when using an allowed reference, explain the technical requirement or rationale directly. Do not make the reference the only explanation.
- Describe only the code that the comment is attached to, in its current state. Do not describe change history or work status, such as `added`, `fixed`, `removed`, `refactored`, `temporary`, `work in progress`, or `no longer needed`. Put change history in the commit message, not in the code.
- Do not include implementation history unless it helps future maintainers understand an active technical constraint.
- A comment shows why, and the code shows how. Explain the reason, guarantee, constraint, or edge case. Do not restate what the code does.
- Do not make editorial changes only for stylistic variation. Make changes that improve clarity, correctness, consistency, usability, or maintainability.
