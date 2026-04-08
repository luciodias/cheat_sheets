#import "@preview/cetz:0.4.2"
#import "@preview/cetz-venn:0.1.4": venn2
#import cetz.draw: *

//#set page(width: auto, height: auto, margin: 10pt)
#set text(size: 9pt)

#cetz.canvas({
  import cetz.draw: *
  // === CORES PADRÃO ===
  let sc = rgb("#2196F3")      // 
  let text_color = black
  let r = 1.2
  let s = 0.5 //1-sobreposição

  // === FUNÇÃO BASE PARA VENN ===
  let venn = (pos, label, code, color) => {
      let (x, y) = pos
      let (a, b, c) = color
      // círculos base
      translate(x:x,y:y)
      venn2(a-fill: a, b-fill: c, ab-fill: b)
      
      // título
    
      content((0, 1.3), text(weight: "bold")[#label])
    
      // código
      content((0, -2.4), block(
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
    (none,sc,none)
  )

  venn(
    (5, 0),
    "FULL OUTER JOIN",
    "SELECT * FROM A\nFULL OUTER JOIN B ON A.id = B.id;",
    (sc,sc,sc)
  )

  venn(
    (-5, -5),
    "LEFT JOIN",
    "SELECT * FROM A\nLEFT JOIN B ON A.id = B.id;",
    (sc,sc,none)
  )

  venn(
    (5, 0),
    "RIGHT JOIN",
    "SELECT * FROM A\nRIGHT JOIN B ON A.id = B.id;",
    (none,sc,sc)
  )

  // === LINHA 2 ===
  venn(
    (-5, -5),
    "LEFT ONLY",
    "SELECT * FROM A\nLEFT JOIN B ON A.id = B.id\nWHERE B.id IS NULL;",
    (sc,none,none)
  )

  venn(
    (5, 0),
    "RIGHT ONLY",
    "SELECT * FROM A\nRIGHT JOIN B ON A.id = B.id\nWHERE A.id IS NULL;",
    (none,none,sc)
  )

  // venn(
  //   (6, -12),
  //   "OUTER ONLY",
  //   "SELECT * FROM A\nFULL OUTER JOIN B ON A.id = B.id\nWHERE A.id IS NULL OR B.id IS NULL;",
  //   "outer"
  // )
})