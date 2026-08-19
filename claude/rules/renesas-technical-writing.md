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

# Renesas technical writing rules

Apply these rules when creating or editing Renesas customer-facing technical documentation, code comments, API documentation, release notes, changelog entries, commit messages, and pull request descriptions.

If a product-specific documentation style guide, business-unit requirement, or repository convention conflicts with these rules, follow the more specific requirement.

## Core writing style

- Prioritize clarity, conciseness, accuracy, consistency, and maintainability.
- Use International English. For example, use `initialize`, `color`, and `behavior`.
- Prefer present tense and active voice.
- Use passive voice only when the agent is unknown, irrelevant, sensitive, or when describing device behavior that the reader cannot control.
- Write instructions in second person or imperative form. Start each procedural step with an action verb.
- Use simple, precise, industry-standard terminology.
- Use one term consistently for one concept. Do not use synonyms merely for variety.
- Avoid idioms, slang, contractions, vague pronouns, unnecessary jargon, Latin abbreviations such as `e.g.` and `i.e.`, and ambiguous expressions such as `and/or`.
- Prefer `because` over `since` when stating a cause.
- Avoid temporal terms such as `currently`, `now`, `latest`, and `previous version`. State the applicable version, behavior, or condition directly.
- Do not use bold, italics, quotation marks, capitalization, or underlining only for emphasis.

## Acronyms and abbreviations

- Define an acronym at first use as `Full Term (ACRONYM)`.
- In long documents, define an acronym again at its first use in each major section when helpful.
- Do not define an acronym used only once unless it is more familiar than the full term.
- Do not use apostrophes to pluralize acronyms. Write `MCUs`, not `MCU's`.
- Do not use `PC` to mean personal computer. Use a specific term such as `Windows workstation` when needed.

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
- Use `0x` followed by uppercase hexadecimal digits for hexadecimal values: `0xFFDD_00CC`.
- Use underscores to group hexadecimal addresses by 16-bit blocks: `0xAABB_CCDD_0000_1111`.
- Write bit references as `bit [2]` or `bits [7:0]`. With a symbol name, write `CKS[2]` or `CKS[7:0]`.
- Include parentheses when referring to a function: `foo()`.
- Use monospace formatting for code, commands, file names, program names, function names, and code examples.
- Preserve code syntax, capitalization, UI labels, register names, signal names, and product names exactly as provided.
- On first use, write a descriptive register name followed by its short name in parentheses: `DTC Control Register (DTCCR)`.
- Use a space before, but not after, the pointer asterisk: `int *p = NULL;`.

## Tables, figures, and cross-references

- Use sentence case for figure titles, table titles, and table column headings.
- Refer to every figure and table from preceding text.
- Do not leave a table cell empty. Use an em dash where a blank value must be shown.
- Use `TBD` for unresolved author notes. Remove all TBDs before release.
- Repeat a small amount of information instead of adding an unnecessary cross-reference.
- Do not use excessive, circular, temporary, or difficult-to-maintain cross-references.
- Use `See` for internal documentation cross-references.

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
- Do not include implementation history unless it helps future maintainers understand an active technical constraint.
- Do not make editorial changes only for stylistic variation. Make changes that improve clarity, correctness, consistency, usability, or maintainability.
