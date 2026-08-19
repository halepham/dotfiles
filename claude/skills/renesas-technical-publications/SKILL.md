---
name: renesas-technical-publications
description: Create, edit, review, or format Renesas customer-facing technical documentation. Use for manuals, hardware user manuals, software guides, application notes, register descriptions, GUI procedures, code comments, API documentation, tables, figures, diagrams, and release documentation.
---

# Renesas Technical Publications Writing Guide

Use this skill when creating, revising, reviewing, or formatting Renesas customer-facing technical publications and associated technical content.

## Objective

Produce content that is clear, concise, accurate, consistent, easy to scan, and suitable for an international audience.

If a product-specific style guide, business-unit requirement, or repository convention conflicts with this skill, follow the more specific requirement.

## Writing workflow

Before drafting or revising content:

1. Identify the audience, purpose, scope, and expected reader task.
2. Determine whether the content is conceptual, descriptive, reference material, a procedure, or code documentation.
3. Preserve correct product names, user interface labels, code, register names, signal names, file names, and legal text exactly as provided.
4. Identify technical details that need confirmation. Use `[TBD: description]` only when the information cannot be verified from the supplied material.
5. Do not make editorial changes unless they improve clarity, correctness, consistency, usability, or maintainability.

## Core prose style

- Use International English.
- Prefer active voice and present tense.
- Use second person or imperative mood for instructions.
- Put the main idea at the start of each sentence.
- Keep sentences concise. Split long or multi-clause sentences when doing so improves clarity.
- Use headings, lists, and tables to make complex information easy to scan.
- State points positively where possible.
- Use simple, precise, and consistent terminology.
- Do not use different synonyms for the same technical concept.
- Avoid vague pronouns such as `this` or `it` when the noun reference is unclear.
- Avoid idioms, slang, trendy terms, unnecessary jargon, and contractions.
- Avoid `e.g.`, `i.e.`, `etc.`, `and/or`, and other Latin abbreviations. Rewrite in plain English.
- Avoid temporal wording such as `currently`, `now`, `latest`, or `previous version`. State the relevant product version or behavior directly.
- Prefer `because` over `since` when stating a cause.
- Prefer `see` for internal document cross-references.
- Do not use bold, italics, quotation marks, capitalization, or underlining only for emphasis.

## Self-contained technical explanations

Write comments and documentation so they remain understandable without access to a chat conversation, user prompt, handoff file, temporary planning note, design discussion, or architecture document.

Describe the current code behavior, requirement, constraint, limitation, invariant, assumption, or rationale directly.

Do not explain an implementation by referring to this conversation, the user’s choice, a handoff, a temporary plan, or an unrelated design document.

Do not write:

```text
Per ARCHITECTURE.md section 4, use polling.
The user chose polling instead of interrupts.
As discussed in the handoff, this is temporary.
This follows the design document recommendation.
The previous conversation specified this behavior.
```

Write:

```text
Polling is used because the device does not expose an interrupt signal for this status bit.
The retry limit prevents the initialization loop from blocking indefinitely.
The cache is invalidated before the DMA transfer so that the CPU reads updated data.
This path handles devices that report completion before the status register is updated.
```

If a reference is necessary for maintainability:

- Use only a stable, relevant artifact that future maintainers can access and verify.
- Prefer published specifications, stable API contracts, permanent issue IDs, or versioned interface requirements.
- State the technical requirement directly in addition to the reference.
- Do not use a reference as a substitute for a technical explanation.

For example:

```c
// The protocol requires a 10 ms delay after reset before the first command.
// See Device Protocol Specification, section 6.2.
delay_ms(10);
```

Do not include implementation history unless it explains an active and relevant technical constraint.

## Acronyms and abbreviations

- Define an acronym on first use: `Analog-to-Digital Converter (ADC)`.
- After defining an acronym, use either the acronym or the full term consistently. Prefer the acronym in longer technical content.
- Define the term again at first use in a new major section when helpful.
- Do not define an acronym used only once unless it is more familiar than the full term.
- Do not use apostrophes to pluralize acronyms. Write `MCUs`, not `MCU's`.
- Do not abbreviate units unless they use approved standard unit symbols.
- Do not use `PC` to mean personal computer. Use a specific term such as `Windows workstation` when required by the context.

## Procedures and GUI instructions

Use an ordered list for a multi-step procedure.

- Introduce every list with a sentence or phrase ending in a colon.
- Start each procedural step with a verb.
- Make each ordered-list item a complete sentence, with an initial capital letter and final period.
- Keep an action and its result in the same step.

Use the following verbs for GUI actions:

| Item | Preferred instruction |
|---|---|
| Menu or menu option | Select **File > Import**. |
| Button | Click **Print**. |
| Tab | Click the **Home** tab. |
| Key | Press **F1**. |
| Radio button or check box | Select or deselect **Option name**. |
| Window or dialog box | Open or close the Configuration window. |
| Field | Enter the value in the Device field. |

Use the exact capitalization and spelling shown in the user interface or source code.

## Lists

- Use ordered lists for steps, sequences, and order-dependent events.
- Use bulleted lists for unordered items.
- Keep list items parallel in grammar and syntax.
- Do not mix sentence fragments and complete sentences in the same list.
- Use a serial comma for three or more inline items: `code, compiler, and debugger`.
- Do not use `and`, `or`, or `but` as standalone text between list items.
- Do not nest lists more than two levels unless necessary.

## Numbers, units, and values

- Spell out numbers from zero through ten in normal prose, except when they appear with units, values above ten, logic values, or clock cycles.
- Use numerals for measurements: `10 MHz`, `5 V`, `32 KB`, `4 µs`.
- Place a non-breaking space between a number and a unit when supported.
- Do not use a space before `%`: `9%`.
- Do not insert commas in numbers: `1000`, not `1,000`.
- Use a period as the decimal separator: `12.34`.
- Write a number in full if it begins a sentence, or rephrase the sentence.
- Use `0x` followed by uppercase digits for hexadecimal values: `0xFFDD_00CC`.
- Use underscores to group hexadecimal addresses by 16-bit blocks: `0xAABB_CCDD_0000_1111`.
- Use `b` as the suffix for binary values: `1001001b`.
- Write a number range with a hyphen and no spaces: `12-19`.
- Write bit references as `bit [2]` or `bits [7:0]`. With a symbol name, write `CKS[2]` or `CKS[7:0]`.

## Registers and code

- On first use, write the descriptive register name followed by its short name in parentheses: `DTC Control Register (DTCCR)`.
- Use the short register name after first use.
- Capitalize `Register` when it is part of a descriptive register name.
- Use lowercase `register` for a generic reference or group of registers.
- Include parentheses when referring to a function: `foo()`.
- Use monospace formatting for code, commands, file names, program names, function names, and code examples.
- Preserve code syntax and case exactly.
- Use a space before, but not after, the pointer asterisk: `int *p = NULL;`.
- In comments, explain why the code exists, what it guarantees, or which edge case it handles. Do not restate obvious code behavior.

## Punctuation and formatting

- Use one space between sentences.
- Avoid comma splices. Use separate sentences or an appropriate conjunction.
- Use a serial comma.
- Do not use apostrophes for possessives in technical prose. Rewrite where practical.
- Do not use contractions.
- Do not use an ampersand in prose. Write `and`.
- Use a colon only to introduce a list, non-numbered example, or complex equation, or within required syntax such as `[7:0]`.
- Do not use a colon after `such as`, `including`, or a linking verb.
- Use a hyphen for numeric ranges, not an en dash.
- Use an em dash for reserved fields and blank cells in register tables.
- Do not use quotation marks for emphasis.
- Do not use bold, italics, underlining, or capitalization for emphasis.

## Cross-references

- Repeat a small amount of information instead of adding an unnecessary cross-reference.
- Avoid excessive or circular cross-references.
- Do not include document issue or version information unless a specific issue must be cited.
- Use concise cross-reference sentences:
  - `See section 5, Flash Memory.`
  - `Figure 4-2 shows the ICU block diagram.`
  - `Table 4.1 lists the I/O pins.`
- Use `to`, not `through`, for a range of references: `See Figure 1.1 to Figure 1.4.`
- Refer to every figure and table from preceding text.
- Do not use a cross-reference to explain a basic technical rationale that can be stated directly.

## Tables

For every table:

- Use a sentence-case title.
- Reference it from preceding text.
- Include column headings.
- Left-align the table and its entries unless a required format specifies otherwise.
- Do not leave cells empty. Use an em dash.
- Do not mix complete sentences and fragments in the same cell.
- End table-cell text with a period only when it contains one or more complete sentences.
- Use a table note for information that applies to the whole table.
- Use a numbered footnote for information that applies to specific cells.

## Figures and graphics

Use a figure only when it communicates information more efficiently than text, clarifies organization or relationships, highlights important information, or improves usability. Do not add graphics only for decoration.

General rules:

- Use sentence case for figure titles.
- Reference each figure from preceding text.
- Use 8 pt Arial where practical. Do not mix font sizes in one figure unless necessary.
- Use sentence case for annotations.
- Use color sparingly and consistently.
- Do not use color only for aesthetic reasons.
- Do not add tint, shading, drop shadows, or unnecessary dashed lines.
- Use figures for diagrams, screen captures, and other meaningful visual information.
- Do not create figures containing only text, example code, ordinary tables, photographs, or large schematics.
- Use PNG for screen captures and SVG or VSDX for scalable line drawings where supported.
- Use in-line graphics only for small icons, buttons, menu items, symbols, or similar visual elements. Do not assign them a figure number or title.

## Terminology checks

Apply these preferred forms where relevant:

- `Analog-to-Digital Converter (ADC)`
- `Digital-to-Analog Converter (DAC)`
- `active-low`, `active-high`
- `cacheable`
- `makefile`
- `microcontroller`
- `power up` and `power down` as verbs
- `powerup` and `powerdown` as nouns
- `setup` as a noun
- `set up` as a verb
- `login` as a noun or adjective
- `log in` as a verb
- `memory map` as a noun
- `memory-mapped` as an adjective
- `NUL` for the ASCII string-terminator character
- `NULL` for a C pointer value
- `IRQ interrupt` and `FIQ interrupt`
- `timing diagram`, not `timing chart`

## Review output format

When asked to review content, provide:

1. A revised version of the content.
2. A concise list of meaningful changes, grouped by:
   - Clarity and structure
   - Terminology and consistency
   - Grammar and punctuation
   - Technical-document formatting
   - Self-contained rationale and references
3. Questions or `[TBD: ...]` markers only for information that cannot be verified from the supplied material.

Do not rewrite correct content merely for stylistic variation.
