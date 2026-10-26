# Punctuation, hyphenation, and typefaces

The local ASCII policy overrides the guide where they differ: do not use an em dash, an en dash, smart quotes, the ellipsis character, or a non-breaking space. Use a hyphen for a blank table cell, a Reserved field, and a number range.

## Punctuation

- **Ampersand:** Do not use `&` in text. Write `and`.
- **Apostrophes:** Do not use an apostrophe for the possessive in technical documents. Rewrite the sentence: write `Writing Guide`, not `Writers' Guide`. Exceptions are `Two's complement` and proper names in the possessive form, such as `Renesas' documentation`. Do not use an apostrophe for a contraction.
- **Colons:** Use a colon to introduce a list, a non-numbered example, or a complex equation, within a bit range such as `[7:0]`, and within a ratio such as `1:2`. Do not use a dash after a colon. Do not put a colon between a verb and its objects or after a preposition. Do not use a colon after `such as`, `including`, or a form of `to have` or `to be`.
- **Commas:** Use a comma to separate items in a series, to set off an appositive, and before the conjunction in a compound sentence. Use a comma after an introductory or transitional phrase: `First, turn on the device...`, `However, ...`, `Therefore, ...`. A comma does not replace a full stop.
- **Serial comma:** Write a comma before `and`, `or`, or `nor` that precedes the last item in a series: `The package includes the processor board, cables, and instructions for use.`
- **Commas in numbers:** Do not use a comma in a number greater than three digits. Write `1000`, not `1,000`. In many countries the comma is a decimal point.
- **Comma splices:** Avoid them. Use a period: write `The timer indicates the clock period length. You can use the timer in Auto mode or Manual mode.`
- **Contractions:** Do not use them in formal and highly technical writing, or in writing for an international audience. The phrase `don't care` is allowed to describe the special value `x` in a hardware description.

| Do not use | Use |
|---|---|
| `aren't` | `are not` |
| `it's` | `it is` |
| `isn't` | `is not` |
| `can't` | `cannot` |
| `doesn't` | `does not` |
| `don't` | `do not` |
| `that's` | `that is` |
| `couldn't` | `could not` |
| `shouldn't` | `should not` |
| `wouldn't` | `would not` |
| `won't` | `will not` |

- **Dashes:** Use a hyphen to indicate a number range, with no space: `12-13`. Use a hyphen in a Reserved field and a blank table cell. Never use a dash after a colon.
- **In-line lists:** Use a comma between all items of a list of three or more items: `The code, the compiler, and the debugger.`
- **Parentheses:** Use them sparingly to enclose non-essential information that is too important to omit. If the text inside the parentheses is important, rewrite the sentence. Put the full stop of a complete sentence inside the parentheses only when the parentheses enclose the whole sentence. Write `The pointer indicates one of these locations (see Table 19).`, not `... locations. (See Table 19.)`
- **Braces and square brackets:** Do not use braces in text. Do not use square brackets in text, except for bits and bit ranges such as `[7:0]`. You can use both in mathematical or syntactical material.
- **Period:** Use a period only for a complete sentence. Place it outside parentheses that end the sentence.
- **Quotation marks:** Avoid quotation marks unless necessary. Do not use them for emphasis. To quote text, include the quotation as a separate paragraph without quotation marks, copy it word for word, mark an omission with an ellipsis, and introduce it with a lead-in sentence that identifies the source. Use straight quotation marks where they are needed. Code extracts must keep their quotation marks exactly as in the original code.
- **Semicolons:** Use a semicolon to join two independent clauses that are not connected by a coordinating conjunction (`and`, `or`, `yet`, `but`): `It was raining hard; we decided to stay inside.`
- **Spaces:** Use one space between sentences. Do not put a space between a minus sign and the number, or between the numbers and the dash in a range. Put a space between a number and its unit. Do not use en spaces or em spaces. In code, the guide says to use spaces and not tabs. Follow the repository formatting convention if it differs. Do not put a space before or after a forward slash or parentheses.
- **Forward slash and backslash:** Do not use them except in code. Exceptions: `start/stop`, `on/off`, `A/D`, `include/exclude`, `I/O`, `input/output`, `read/write`, URLs, and path names (`/` for UNIX, `\` for Microsoft Windows). Do not use a slash to replace `or`, `and`, or `either`. Write `one or both of X and Y` for `X and/or Y`.
- **Ellipses:** Avoid them. Do not end a sentence with one. Use three periods (`...`) for an omission. In a vertical list or a table, put the ellipsis on a separate line or row.

## Hyphenation

| Rule | Examples |
|---|---|
| Add a hyphen when it gives the correct meaning. A hyphen is not an alternative to a space. If you do not use a hyphen, join the text together, unless that changes the meaning. | `Recreation` (refreshment), `Re-creation` (create again), `Small-appliance industry` (an industry that makes small appliances) |
| Hyphenate compound adjectives. | `Single-sided`, `A well-established rule`, `Floating-point`, `Single-precision`, `Double-precision`, `Half-precision`, `5 V-tolerant port` |
| Hyphenate compound verbs. | `Double-click`, `Right-click` |
| Hyphenate compound numbers. | `Forty-eight` |
| Hyphenate `non` only if the main body of the word begins with a vowel, an `n`, or an uppercase letter. If the main body is already hyphenated, use a space instead of a hyphen. | `Non-existent`, `Non-native`, `Non-secure`, `non-ModelGen`, `Non-Confidential`, `Nonvolatile`, `Nonrecurrent`, `Nonreentrant`, `Non word-aligned` |
| Hyphenate the prefixes `bi`, `pre`, and `re` only if the main body of the word begins with a vowel. Exceptions: `react`, `reentrant`, `reentry`, `reenter`, `reuse`, `preempt`, `preemption`, `deassert`. | `Bidirectional`, `Re-align` |
| Do not hyphenate words to prevent them from spreading over a line. | - |
| Be consistent with both industry-standard and non-industry-standard terminology. | `Runtime`, `Real-time`, `Halfword`, `Quadword`, `Doubleword` |
| In chapter titles, headings, and defined acronyms, capitalize all hyphenated words. | `Floating-Point`, `Power-On Reset (POR)` |
| Use a hyphen for an adjectival bit width. Do not apply the rule when bits are a unit of measure. | `32-bit instruction`, `64-bit register`; `an instruction uses 16 bits` |

For a word you are unsure about, consult the Merriam-Webster's Collegiate Dictionary.

## Typefaces

Use bold, italic, and monospace only for the items in the table. Do not use them for emphasis. Do not underline words for emphasis. Use underlining only to indicate a permitted abbreviation for a command or option, and write that text in monospace.

| Item | Typeface | Comment |
|---|---|---|
| Abbreviation definition | Italic | Write the abbreviation in the default font. |
| Assembler directives | Monospace and uppercase | - |
| Binary numbers | No special formatting | - |
| Button names | Bold | From the GUI. |
| Code examples | Monospace | As entered at the keyboard. Do not use bold. |
| Code snippets | Monospace | The guide also allows underline, depending on the context. The ASCII policy and the no-underline rule favor monospace. |
| Code variables | See the capitalization rules | Match the capitalization in the code. |
| Cross references | - | See the cross-reference rules. |
| Column headings in tables | Bold | - |
| Commands | Monospace | As entered at the keyboard. |
| Directory names | Monospace | In graphics, follow the directory name with a `/`. |
| Drop-down list items | Bold | - |
| Field names | No special formatting | In register descriptions, do not use bold, monospace, or italics. |
| File names | Monospace | As entered at the keyboard. |
| Functions | Monospace | Include parentheses: `foo()`. |
| Hexadecimal numbers | Uppercase digits | - |
| Instructions | Monospace and uppercase | - |
| Menu names, menu options | Bold | When referring to a GUI item. |
| Module names | No special formatting | Match the capitalization and spelling in the code. |
| Program names | Monospace | When the program name is entered at the command line. |
| Programming language keywords | Bold and monospace | Do not use bold in example code. |
| Pseudo instructions | Monospace and uppercase | - |
| Pseudocode | Monospace | - |
| Radio button names | Bold | - |
| Replaceable text other than in an instruction | Italic | - |
| Signal names | No special formatting | - |
| Tab names | Bold | From the GUI. |
| Titles | Bold | All titles within the publication. |
| Window panes, window views | Bold | - |
| Windows | No special formatting | - |
| Publication names in a reference | Italic | Write the complete title. |

## Instructions and GUI actions

- Start each instruction with a verb.
- For a single-step instruction, write `Action to result`: `Select **File > Print** to print the current document.`
- For a multiple-step instruction, introduce the steps and use an ordered list with one action per step: `To print the current document:`
- If an action has a result, keep the action and the result in the same step: `Click **OK** to display the Configuration window.`
- Write a menu path with `>` between the bold names: `Select **File > Import > Format**.`
- Write the name of a button, tab, key, radio button, check box, menu, or menu option in bold.
- Write the name of a window, dialog box, or field in plain text.

| Item | Instruction |
|---|---|
| Menu or option | `Select **File > Import**.` |
| Button | `Click **Print**.` |
| Tab | `Click the **IoT Home** tab.` |
| Key | `Press **F1**.` Use the short key name. |
| Radio button or check box | `Select **Customize**.`, `Deselect **Options**.` |
| Window or dialog box | `Open the Initialization window.` |
| Field | `Enter the device specification in the Device field.` |
