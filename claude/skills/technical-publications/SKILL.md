---
name: technical-publications
description: Create, edit, review, or format customer-facing technical documentation. Use for manuals, hardware user manuals, software guides, application notes, register descriptions, GUI procedures, code comments, API documentation, tables, figures, diagrams, and release documentation.
---

# Technical Publications Writing Guide

Use this skill when creating, revising, reviewing, or formatting customer-facing technical publications and associated technical content.

## Objective

Produce content that is clear, concise, accurate, consistent, easy to scan, and suitable for an international audience.

If a product-specific style guide, business-unit requirement, or repository convention conflicts with this skill, follow the more specific requirement.

## Reference files

Read the reference file that matches the task. Each file is self-contained.

| File | Use it for |
|---|---|
| `structure-and-references.md` | Capitalization of titles, lists, notes, examples, footnotes, cross-references, tables, TBD, registers, revision history, publication and website references, trademarks, keystrokes |
| `numbers-and-units.md` | Numbers in text, hexadecimal and binary, approved units and prefixes, dates and times, equations |
| `punctuation-and-typefaces.md` | Punctuation, hyphenation, contractions, typefaces (bold, italic, monospace), GUI instructions |
| `terminology.md` | Spelling and hyphenation of common terms, acronyms, words and phrases to avoid, common errors, misused words |
| `figures.md` | When to use a figure, PlantUML settings, rules for each diagram type, screen captures, in-line graphics |

## Writing workflow

Before drafting or revising content:

1. Identify the audience, purpose, scope, expected reader task, and the way the content is delivered.
2. Determine whether the content is conceptual, descriptive, reference material, a procedure, or code documentation.
3. Preserve correct product names, user interface labels, code, register names, signal names, file names, and legal text exactly as provided.
4. Identify technical details that need confirmation. Use `[TBD: description]` only when the information cannot be verified from the supplied material.
5. Do not make editorial changes unless they improve clarity, correctness, consistency, usability, or maintainability. Unnecessary changes increase review effort and translation cost.

While drafting:

- Organize content so that readers can find information quickly. Use headings, lists, and tables to break up complex material.
- Develop ideas in a logical order, from the overall flow of the document to the construction of each sentence and paragraph.
- Use transitional words and phrases between sentences and paragraphs to show relationships.
- Emphasize the most important points. Put the main idea at the start of a sentence, with supporting details after it.
- Remove information that does not help the reader perform a task.

## Core prose style

- Use International English. Use `initialize`, `analyze`, `color`, `behavior`, `canceled`, `labeled`, `learned`, and `dialog`. Do not change a name that comes from code or a user interface.
- Write all documentation, comments, commit messages, pull request descriptions, and changelog entries in English, regardless of the language used in the conversation or request. Do not switch to the conversation's language, for example Vietnamese, for these deliverables.
- Prefer active voice and present tense. Avoid past tense and future tense where possible.
- Use passive voice only when the agent is unknown, irrelevant, or sensitive, or when the text describes device behavior that the reader cannot control. For example, hardware manuals often describe function-driven and device-driven behavior in passive voice.
- Use second person or imperative mood for instructions. Avoid first person (`I`, `we`). Do not use `they` as a singular pronoun, and treat `anyone` and `everyone` as singular.
- Put the main idea at the start of each sentence.
- Keep sentences concise. Split long or multi-clause sentences when doing so improves clarity. If a sentence has a comma, check whether it reads well without one.
- Rewrite nominal constructions into direct statements: write `Take the measurements`, not `Measurements are taken`.
- Avoid `there is` and `there are` when a direct subject is clear. Check that the rewrite does not make the meaning less clear.
- Do not turn nouns into verbs.
- Place adjectives and adverbs next to the words they modify. Avoid long strings of nouns or adjectives used as modifiers.
- Keep essential articles (`a`, `an`, `the`) and relative pronouns (`that`, `who`).
- Use parallel structure in lists, headings of the same level, and table entries.
- State points positively where possible.
- Use headings, lists, and tables to make complex information easy to scan.
- Use simple, precise, and consistent terminology. Do not use different synonyms for the same technical concept.
- Avoid vague pronouns such as `this` or `it` when the noun reference is unclear.
- Avoid idioms, slang, trendy terms, unnecessary jargon, and contractions.
- Avoid `e.g.`, `i.e.`, `etc.`, `n.b.`, `and/or`, and other Latin abbreviations. Rewrite in plain English.
- Avoid temporal wording such as `currently`, `now`, `latest`, or `previous version`. State the relevant product version or behavior directly.
- Prefer `because` over `since` when stating a cause.
- Prefer `see` for internal document cross-references.
- Treat `data` as a mass noun with a singular verb.
- Do not use bold, italics, quotation marks, capitalization, or underlining only for emphasis. A required typeface convention, such as bold for GUI names and table column headings, is not emphasis.
- Check the word choices against the list in `terminology.md`.

## Self-contained technical explanations

Write comments and documentation so they remain understandable without access to a chat conversation, user prompt, handoff file, temporary planning note, design discussion, or architecture document.

Describe the current code behavior, requirement, constraint, limitation, invariant, assumption, or rationale directly.

Do not explain an implementation by referring to this conversation, the user's choice, a handoff, a temporary plan, or an unrelated design document.

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

Describe only the code that the comment is attached to, in its current state. Do not describe change history or work status, such as `added`, `fixed`, `removed`, `refactored`, `temporary`, `work in progress`, or `no longer needed`. Put change history in the commit message, not in the code.

Do not include implementation history unless it explains an active and relevant technical constraint.

A comment shows why, and the code shows how. Explain the reason, guarantee, constraint, or edge case. Do not restate what the code does.

## Acronyms and abbreviations

- Define an acronym on first use: `Analog-to-Digital Converter (ADC)`.
- After defining an acronym, use either the acronym or the full term consistently. Prefer the acronym in longer technical content. Do not alternate between them in a short document.
- Define the term again at first use in a new major section or chapter of a long document.
- Do not define an acronym used only once unless it is more familiar than the full term.
- Do not define widely recognized acronyms such as `IC`, `RAM`, and `LED`.
- Do not use apostrophes or parentheses to pluralize acronyms. Write `MCUs`, not `MCU's` or `MCU(s)`.
- Do not capitalize the expansion of an acronym that is normally lowercase: `digital signal processing (DSP)`.
- Write `RW`, `RO`, and `WO` for the access types read and write, read-only, and write-only. Do not confuse `read and write` with `read-write`.
- Do not abbreviate units unless they use approved standard unit symbols.
- Do not use `PC` to mean personal computer. Use a specific term such as `Windows workstation` when required by the context. In technical documentation, `PC` means Program Counter.
- For common acronyms and their expansions, see `terminology.md`.

## Procedures and GUI instructions

Use an ordered list for a multi-step procedure.

- Introduce every list with a sentence or phrase ending in a colon.
- Start each procedural step with a verb.
- Make each ordered-list item a complete sentence, with an initial capital letter and final period.
- Keep an action and its result in the same step.
- Write the names of menus, menu options, buttons, tabs, keys, radio buttons, and check boxes in bold. Write the names of windows, dialog boxes, and fields in plain text.

For the GUI verbs and the list rules, see `punctuation-and-typefaces.md` and `structure-and-references.md`.

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

## Plain ASCII and formatting policy

This policy overrides the writing guide where they differ.

- Do not use an em dash (`—`). Replace it with a comma, colon, semicolon, parentheses, or a separate sentence, depending on which relationship the surrounding text expresses. Use a hyphen (`-`) for reserved fields and blank cells in register tables.
- Use a hyphen for numeric ranges, not an en dash.
- Use plain ASCII characters. Do not use emoji, decorative symbols, or pictographic icons in prose, headings, tables, comments, commit messages, or pull request descriptions.
- Use straight quotation marks (`"` and `'`), not curly or smart quotes (`“ ” ‘ ’`).
- Write three periods (`...`) for an ellipsis. Do not use the ellipsis character (`…`).
- Use a regular space. Do not use a non-breaking space or other non-ASCII whitespace character, except where the output format requires one between a number and a unit and supports it.
- Use the standard Markdown list marker (`-` or a number) for lists. Do not use decorative bullet glyphs (`•`, `●`, `▪`, `»`) in prose.
- Do not use arrow glyphs (`→`, `⇒`, `↔`) in prose. Write `to` or restructure the sentence. Arrows remain allowed inside a figure or diagram where they convey a flow or connection.
- Do not use symbol shorthand such as `✓`, `✗`, `★`, or `⚠` to indicate status or severity. Use a word such as `Pass`, `Fail`, `Yes`, `No`, `Warning`, or `Note`.
- An approved standard unit or mathematical symbol required for technical accuracy, such as `µ`, `Ω`, `°`, `×`, or `±`, remains allowed when no ASCII substitute preserves the technical meaning and the output format supports it.

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
