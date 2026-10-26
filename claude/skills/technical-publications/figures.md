# Figures and diagrams

This file applies the figure rules of the writing guide to text-based documents. Create diagrams as PlantUML source in Markdown so that the diagram is reviewable and diffable. The guide specifies drawing-tool settings, such as line weights in points. PlantUML measures in pixels, so the values here are approximations.

## When to use a figure

Use a figure or an in-line graphic when it:

- Saves text.
- Gives information that text cannot give efficiently, for example the organization of parts.
- Highlights important information.
- Reinforces the text or adds impact.
- Increases the general usability of the document.

Do not use a figure for aesthetic value.

A figure can be a bitmap screen capture or a line drawing: a block diagram, a timing diagram, a state diagram, a two-dimensional representation of a three-dimensional object, a flowchart, a circuit diagram segment, a register diagram, or a directory structure diagram.

Do not create a figure that includes photographs, large circuit diagrams or schematics, tables (except a drawing of a package outline with dimensions), example code, or only text.

The guide lists only these types. As a local extension, use another type, such as a sequence diagram, only when none of the listed types can express the information.

## Rules for every figure

- Use a sentence-case figure title. Put the title in the Markdown caption, not in the diagram.
- Reference the figure from the preceding text, with the item followed by a verb: `Figure 4-2 shows a block diagram of the ICU.`
- Place the figure on the same page as the associated text where possible.
- Use sentence case for annotations and labels.
- Use color sparingly and consistently. Do not add color for aesthetic reasons. Explain the color scheme in a legend unless the figure conveys its meaning clearly without one.
- Do not use tint or shading, drop shadows, or dotted and dashed lines. Exceptions: dashed vertical lines for timing intervals and tint for undefined periods in timing diagrams, and dashed lines for clock domains in block diagrams.
- Use solid black lines, square line caps, a solid black arrowhead for every line that depicts a flow, and text centered in its block both vertically and horizontally, unless the block contains sub-blocks. Center-align an annotation of two or more lines.
- Use one font size in a figure unless a second size is absolutely necessary.
- Fit the figure on a page of 172 mm by 222 mm. Split a large diagram into several figures.
- Export a figure as SVG or PNG. Do not resize an SVG figure. Design it to fit a standard page.
- Make sure that the diagram text is plain ASCII.

## PlantUML settings

Start each diagram with the following settings. These approximate the default construction rules of the guide: Arial at 8 pt, solid black 0.5 pt lines, no shadow, and monochrome output.

```plantuml
@startuml
skinparam monochrome true
skinparam shadowing false
skinparam defaultFontName Arial
skinparam defaultFontSize 8
skinparam defaultTextAlignment center
skinparam roundCorner 0
skinparam lineThickness 0.5
skinparam arrowThickness 0.5
@enduml
```

These skinparam names have not been verified against a specific PlantUML version. Run the renderer and correct any setting that it rejects.

## Diagram types

### Block diagrams

- Use a block diagram to show the elements of a module or software component and how they interact.
- Write block names and signal names in the same 8 pt font. The guide writes signal names in bold.
- Draw an element and a single signal line at 0.5 pt. Draw a bus (multiple signal lines) at 1.5 pt.
- Make an arrowhead touch the element without overlapping it.
- Label every signal line at the start of the line.

### Flowcharts

- Use a flowchart to illustrate a procedure or process flow, including execution flow.
- Put the flow input at the top center and the flow output at the bottom center of a procedure or process block.
- Put the output of a decision block, a manual input block, or a data block at the side.
- Put the input of an on-page reference or a data block at the side.
- A procedure or process block can have manual inputs or data inputs and outputs at either side.
- Put the `Yes` and `No` labels close to the decision block.
- Start with a Start block and end with an End block.

### State diagrams

- The guide gives no specific rules for state diagrams. Follow the rules for every figure.
- In the example of the guide, each state is an oval and each transition is labeled with its condition.

### Timing diagrams

- Use tint to show undefined periods.
- Use vertical dashed lines to show timing intervals.
- Right-align signal names. The timing example of the guide does not write them in bold, although the font table specifies bold for default signal names. Use plain text.
- The example keeps a gap of 2 mm to 4 mm after the waveform and a waveform height of 4 mm. These values do not apply to PlantUML.
- Place the text for a waveform inside the waveform. If there is no room, put it below the waveform. If it still does not fit, use a text block with a curved line.

### Circuit diagrams

- Include only small segments of circuit or logic diagrams. Do not include a complete circuit or logic diagram.
- Draw lines in solid black at 0.5 pt.

### Directory structures

- Write the structure as text in a monospace font, in a code block or a PlantUML `salt` or `wbs` diagram.
- End each directory name with a `/`. Do not add a `/` to a file name.

```text
$PROJECTSIM/platform/traceintegration/
  source/
    test_code/
  verilog/
    tbench/
  makefile
```

### Register diagrams

- Show the bit pattern of a register in a diagram, followed by a table of the bits that describes the meaning of each setting.
- Use a hyphen (`-`) for a Reserved bit and for an empty cell. The ASCII policy replaces the em dash in the guide.
- Include in the diagram the base address, the offset address, the bit position, the bit field, and the value after reset.
- Define the access types in a table note: `R/W` is read and write, `W` is write-only (the read value is undefined), and `R` is read-only (writing has no effect).
- Add a note for a Reserved bit: use the specified value when you write to the bit or field, otherwise the correct operation is not guaranteed. Add a note for a setting-prohibited value: the correct operation is not guaranteed if the setting is performed.
- For a flag, describe the setting condition and the clearing conditions after the table, in bulleted lists.
- In the table, write the bit, symbol, function, and access type (`R/W`, `W`, `R`) in separate columns. Put the setting values (`0:`, `1:`) in the Function cell.
- Describe a Reserved bit as the product guide specifies. For example: `This bit is read as 0. The write value should be 0.`

### Screen captures

- Capture the window with the default or classic theme.
- If possible, capture at 100%. You can increase the size for clarity, but scale all captures of the same kind by the same amount.
- Keep the aspect ratio of the captured item.
- Crop the capture if you do not need the complete window or dialog box.
- Annotate a capture only with identification annotations and callouts. Do not add tint or shading.
- Use PNG for a screen capture.

## In-line graphics

An in-line graphic is a small icon, button, menu option, symbol, or similar element in the text. It is usually used only in software publications.

- Insert the graphic by file reference. Do not copy and paste it.
- Use PNG for a screen capture, BMP for a screen capture in an online help file, and SVG for a line drawing.
- Put the graphic next to the associated text. It can be outside the normal text margin. Put its top level with the top of the text and at least 2 mm of white space around it.
- Do not give the graphic a figure number or a title.
- Do not reference it from the text.
- Do not put a graphic in the middle of a paragraph if it increases the line spacing.
- Do not add text to the graphic.

## Annotations and callouts

These rules apply to every figure except register diagrams.

- Use a block annotation to label a block: 8 pt, centered in the block.
- Use a signal line annotation to label a signal line or flow line: place it at the start of the line.
- Use an identification annotation to identify part of a figure when a block or signal line annotation cannot. Use a leader line for every identification annotation.
- Draw a leader line straight, solid black, and thin (0.2 pt). Start it at the annotation and end it close to, but not touching, the item. Do not use horizontal or vertical leader lines. Do not cross leader lines. If one annotation links to several items, start all lines at the same point next to the annotation.
- Use a callout for a magnified view of part of a figure, with a white fill and a leader line to the item.
- Use a cutaway when a figure shows only part of an object.
- A screen capture can have identification annotations and callouts.

## Guide rules that do not apply to text diagrams

The guide also specifies the following. A text-based diagram cannot follow them, so do not apply them to PlantUML:

- The drawing details of leader lines (angle, line weight, white backing), callouts, and cutaways on pictures of boards.
- Layout diagrams of a board.
- Line weights and fonts by use, in points.
- The width of a clock cycle in a timing diagram.
- Insertion of a figure into a Visio frame.
