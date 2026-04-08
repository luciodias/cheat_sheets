
#let set_page(
  title,
  center_text: "",
  author: "Lúcio Dias da Silva",
  margin: (rest: 0.5cm),
  columns: 3,
  doc,
) = {
set page(
  paper:"a4", 
  flipped: true,
  margin: margin,
  columns: columns,
  footer: grid(columns:(1fr, 1fr, 1fr),
      [#title],
      align(center)[#center_text],
      align(right)[#author],
  )
)
show heading: set align(center)
set text(8pt)
set par(justify:true, spacing: 0.1em)
doc
}
