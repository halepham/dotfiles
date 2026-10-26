# Structure, lists, tables, and references

## Capitalization

- Keep uppercase letters to a minimum. Do not use them for emphasis.
- Copy the capitalization of a window, dialog box, or code element exactly from the screen or the code.
- Use title case for publication titles, chapter titles, section headings, and appendix headings: capitalize the first letter of every significant word. Keep short prepositions (`in`, `on`, `at`, `to`, `by`, `for`) and articles (`a`, `an`, `the`) in lowercase unless they begin the heading.
- The guide gives two forms for a hyphenated term in a title. Section 3.5 recommends lowercase for the second element. The hyphenation table capitalizes every part in chapter titles, headings, and defined acronyms: `Floating-Point`, `Power-On Reset (POR)`. The guide marks the lowercase recommendation as a recommendation, not a requirement.
- Use sentence case for figure titles, table titles, and table column headings. Capitalize only the first word. Keep the original form of a signal name or a special term: `Figure 13-1 POEG block diagram`, `Table 1.2 Trace function pins`.
- A word with a required form overrides these rules. For example, the function `clock()` is case-sensitive and stays in lowercase, even in a title.
- Write instruction mnemonics in uppercase (`WAIT`). Write hexadecimal digits in uppercase, with a lowercase `x`: `0x0FF1FF0F`.
- Signals, code examples, and names can be in uppercase. Follow the convention of your team or as they appear in the software or product.
- Write voltage and current symbols the same way they appear in the code (`Vdd` or `VDD`). Do not mix the forms in one document.
- Capitalize the first letter of the definition of an abbreviation, unless the term is normally lowercase.

## Lists

All lists:

- Introduce the list with a sentence or phrase that ends with a colon.
- If the list states a number of conditions, make the introduction clear about whether one, one or more, or all conditions apply.
- Keep items parallel in grammar, syntax, and punctuation.
- Use the default font. Do not use bold or italics.
- Capitalize the first word of each item.
- Do not mix complete sentences and fragments in one list.
- Do not give a list, or part of a list, its own heading.
- Do not write `and`, `or`, or `but` between items.
- Do not make the list part of a sentence that continues after the last item.
- Keep the first list item on the same page as the introduction.
- Do not state the number of items in the introduction.
- Required syntax inside an item, such as a final semicolon in a quoted `return;` statement, overrides the capitalization and punctuation rules.

Ordered lists:

- Use an ordered list for events that depend on order. Write procedures as ordered lists.
- An ordered list has more than one item.
- Prefix first-level items with Arabic numbers and second-level items with lowercase letters in parentheses: `(a)`, `(b)`.
- Write each item as a complete sentence with a capital letter and a final period.

Bulleted lists:

- Use a bulleted list for items that are not prioritized or time-dependent.
- A bulleted item can start in lowercase or uppercase. Use a final period on the last item.
- If any item is a complete sentence, capitalize every item and end every item with a period.
- List menu options and publication sections in the order in which they appear.

Run-in lists:

- Use letters or numbers in parentheses within a sentence: `(a) writing copy, (b) selling your book, and (c) promoting the work`.
- Do not use more than three or four items.

Nested lists:

- Combine list types where needed. Do not exceed two levels of nesting unless absolutely necessary.

## Notes, examples, and footnotes

- Use a `Note:` to draw attention to an important point. Place it after the text it relates to, as a separate paragraph, in the form `Note: text`.
- Write an example as a non-numbered example (a line of code or text) or a numbered example.
- Do not insert an example in the middle of a sentence.
- End the sentence that introduces a non-numbered example with a colon.
- Introduce an example sentence or paragraph with `For example,` followed by a comma.
- Number an example if it is standalone or if text other than the preceding sentence refers to it.
- If the example is code, make sure that you have permission to reproduce it. If it is part of the project deliverables, acknowledge the use of the code.
- In a figure, put expanded text for an annotation in a footnote within or below the figure, with a superscript indicator.
- In a table, put a footnote immediately after the table, with a superscript indicator in the relevant cell or cells.
- Use a `Note` for information that applies to the whole table. Use a footnote for information that applies to specific text, a figure item, or a table entry. Number footnotes sequentially.

## Cross-references

- Repeat a small amount of information instead of adding a cross-reference. Do not repeat large sections, figures, or pages.
- Avoid an introductory paragraph with many links. Restructure the text, extract the links into a bulleted list or a table, or delay the detail until later in the section.
- Avoid sequential and circular cross-references: do not redirect the reader to information that the reader has already seen.
- Place a cross-reference where it does not distract the reader.
- Omit issue and version information from a cross-reference to a publication.
- Restrict a sentence that contains a cross-reference to `See <cross-reference>` or `See also <cross-reference>.`
- When you introduce a section, cross-refer to all of its subsections or to none, unless you advise the reader about which subsections to read.
- If the reason for a cross-reference is not obvious, introduce it with a short sentence: `The RX CPU can handle three types of data. See the RX Family User's Manual: Software for more information.`
- Cross-refer to every figure and table from the text.
- For a series, use `to`, not `through`: `See Figure 1.1 to Figure 1.4.`
- Refer to a chapter, section, or appendix with its number and title: `See section 5, Flash Memory.`
- Write a reference to a figure or table as the item followed by a verb: `Figure 4-2 shows a block diagram of the ICU`, `Table 4.1 lists the I/O pins.`
- Refer to a footnote in a table with a superscript indicator, and to an ordered-list item with the step number.

## Tables

Every table has:

- A title in sentence case.
- A cross-reference from the preceding text.
- Column headings in bold.
- Left alignment for the table and for the column entries.
- Column widths adjusted to fit the content, if possible.
- No empty cell. Use a hyphen (`-`) to indicate a blank cell. The ASCII policy replaces the em dash that the guide specifies.
- No mix of full sentences and phrases in one cell.
- A final period on a cell that contains one or more complete sentences, and on the last item of a list in a cell. Do not end other cell entries with a period.

## TBD

- Insert `[TBD: note]` before any note to yourself. Search for `TBD` before you release the document.
- Correct: `See [TBD: x-ref to Overview chapter] for a block diagram of the MCU.`, `The relevant register has [TBD: 32?] bits.`
- Incorrect: `[revisit]`, `** check with an engineer`, `(make this into a proper x-ref)`.
- Treat `revisit` and `work needed` in an engineering specification as the equivalent of a TBD. Do not use them in customer-facing documentation.

## Registers

- Use the short name to refer to a register, except in the title of the section that describes the register and at the first use of the register name.
- At first use, write the full register name followed by the abbreviation in parentheses: `DTC Control Register (DTCCR)`.
- Capitalize `Register` when it is part of the descriptive name: `The DTCVBR is the DTC Vector Base Register.`
- Use lowercase `register` for a generic reference or a group of registers: `The CRA and CRB registers are set independently of each other.`
- If the document supports hyperlinks, link to the register description instead of typing the name in the body text.
- For register fields and bit symbols, follow the guideline for the specific product.

## Revision history

- List only technical changes between released versions. Do not list editorial changes.
- Add a revision entry only after the first release.
- In the description, start with an action verb (`Added`, `Removed`, `Updated`) followed by the section number.

## Publications, websites, and trademarks

- Cite another publication in the form `See <publication title>`. Write the complete title in italics: `See the Example MCU Group Microcontrollers User's Manual for information on ICU.`
- Avoid external websites, because the company does not control them. Where a link is required, use the top-level URL with its prefix, such as `https://www.example.com`, without a trailing `/`.
- Use the trademark symbol (`®` or `™`) on the first occurrence of the term, as a superscript. In a large document, repeat it at the first occurrence in each chapter or section.
- Reproduce a third-party trademark acknowledgment exactly as the owner gives it.
- Do not use the company logo or a product logo without permission. Contact the legal department if you are unsure how to use a trademark.

## Keystrokes

- Write a single key name in normal font with its short name: `Del`, not `Delete`.
- Write a simultaneous keystroke with the key names separated by `+`: `Ctrl+Alt+Del`.
- For key names in instructions, see the typeface conventions.

## Subscript, superscript, and symbols

- Use subscript and superscript only for fractions that must appear as a fraction, equations, powers, the base of a logarithm, footnote indicators for tables and figures, and voltage and current symbols (`Vdd`, `Vss`).
- Use a symbol only for a unit of measurement, a direct quote from a screen, product, or code, a trademark or registered trademark, an equation, a menu option, or a defined operator.
