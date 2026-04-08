#import "@preview/cetz:0.4.2"
#import "@preview/cetz-venn:0.1.4": venn2
#import cetz.draw: *

#set page(width: auto, height: auto, margin: 10pt)
#set text(size: 9pt)

#cetz.canvas({
  import cetz.draw: *

  // === CORES PADRÃO ===
  let left_color = rgb("#4CAF50")       // verde
  let right_color = rgb("#2196F3")      // azul
  let overlap_color = rgb("#FFC107")    // amarelo
  let text_color = black
  let r = 1.2
  let s = 0.5 //1-sobreposição

  // === FUNÇÃO BASE PARA VENN ===
  let venn = (pos, label, code, highlight) => {
    let (x, y) = pos

    // círculos base
    circle((x - s*r, y), radius: r, fill: left_color.lighten(70%), stroke: left_color)
    circle((x + s*r, y), radius: r, fill: right_color.lighten(70%), stroke: right_color)

    // destaque (interseção ou lados)
    if highlight == "inner" {
      circle((x, y), radius: r, fill: overlap_color)
    } else if highlight == "left" {
      circle((x - 1.2, y), radius: r, fill: left_color.lighten(40%))
    } else if highlight == "right" {
      circle((x + 1.2, y), radius: r, fill: right_color.lighten(40%))
    } else if highlight == "outer" {
      // nada preenchido = apenas bordas
    }

    // título
    content((x, y + 1.8), text(weight: "bold")[#label])

    // código
    content((x, y - 2.0), block(
      fill: luma(240),
      inset: 4pt,
      radius: 3pt
    )[
      #raw(code, lang: "sql")
    ])
  }

  // === LINHA 1 ===
  venn(
    (0, 0),
    "INNER JOIN",
    "SELECT * FROM A\nINNER JOIN B ON A.id = B.id;",
    "inner"
  )

  venn(
    (6, 0),
    "LEFT JOIN",
    "SELECT * FROM A\nLEFT JOIN B ON A.id = B.id;",
    "left"
  )

  venn(
    (12, 0),
    "RIGHT JOIN",
    "SELECT * FROM A\nRIGHT JOIN B ON A.id = B.id;",
    "right"
  )

  // === LINHA 2 ===
  venn(
    (0, -6),
    "FULL OUTER JOIN",
    "SELECT * FROM A\nFULL OUTER JOIN B ON A.id = B.id;",
    "inner"
  )

  venn(
    (6, -6),
    "LEFT ONLY",
    "SELECT * FROM A\nLEFT JOIN B ON A.id = B.id\nWHERE B.id IS NULL;",
    "left"
  )

  venn(
    (12, -6),
    "RIGHT ONLY",
    "SELECT * FROM A\nRIGHT JOIN B ON A.id = B.id\nWHERE A.id IS NULL;",
    "right"
  )

  // venn(
  //   (6, -12),
  //   "OUTER ONLY",
  //   "SELECT * FROM A\nFULL OUTER JOIN B ON A.id = B.id\nWHERE A.id IS NULL OR B.id IS NULL;",
  //   "outer"
  // )
})