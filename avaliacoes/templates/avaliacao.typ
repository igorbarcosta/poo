// Sistema editorial Typst para avaliações impressas.
// Conteúdo semântico permanece nos Markdown canônicos dos instrumentos.
#let ink = rgb("#202832")
#let muted = rgb("#687481")
#let accent = rgb("#245d78")
#let soft = rgb("#f3f6f7")
#let code-fill = white
#let rule = rgb("#d5dce0")

#let assessment(body) = {
  set page(paper: "a4", margin: (top: 10mm, bottom: 10mm, left: 10mm, right: 10mm),
    footer: context align(center, text(size: 7.4pt, fill: muted)[#counter(page).display() / #counter(page).final().at(0)]))
  set text(font: "Liberation Sans", size: 11.5pt, fill: ink, lang: "pt")
  set par(leading: 3.5pt, spacing: 3pt, justify: false)
  show raw: set text(font: "Ubuntu Mono", size: 9.5pt)
  body
}

#let exam-header() = {
  text(size: 11.5pt, weight: "regular")[IFPB - Campus Campina Grande]
  v(1pt)
  text(size: 11.5pt, weight: "regular")[Programação Orientada a Objetos - Checkpoint 01]
  v(4.5pt)
  let field = block(width: 100%, height: 4.5mm, stroke: (bottom: .5pt + rule))[]
  grid(columns: (auto, 1fr, auto, 29mm), column-gutter: 2.2mm, align: bottom,
    text(size: 10pt, weight: "medium")[Nome], field,
    text(size: 10pt, weight: "medium")[Nota], field)
}

#let scenario-block(body) = block(width: 100%, inset: (x: 3mm, y: 2mm), fill: soft, radius: 3pt)[#body]

#let section-kicker(label, title: none) = grid(columns: (auto, 1fr), column-gutter: 3mm, align: horizon,
  text(size: 9pt, weight: "bold", fill: accent, upper(label)),
  if title != none { text(size: 12pt, weight: "medium")[#title] })

#let write-slot(label, width: 21mm) = box(width: width, height: 7mm, inset: (x: 1.8mm, y: 1.25mm), stroke: .5pt + rule, radius: 3pt)[
  #text(size: 7.2pt, weight: "medium", fill: muted)[#label]
]

#let answer-sheet() = [
  #text(size: 10pt, weight: "bold", fill: accent)[RESPOSTAS]
  #v(2pt)
  #block(width: 100%, inset: (x: 3.5mm, y: 2.6mm), fill: soft, radius: 3pt)[
  #grid(columns: (7mm, 1fr), column-gutter: 2mm, row-gutter: 1.8mm, align: horizon,
    text(size: 8pt, weight: "bold", fill: accent)[1],
    [#for label in ("a", "b", "c", "d", "e", "f", "g") { write-slot(label); h(1.25mm) }],
    text(size: 8pt, weight: "bold", fill: accent)[2],
    [#for label in ("a", "b", "c", "d", "e") { write-slot(label, width: 26mm); h(1.5mm) }],
    [],
    [#for label in ("3", "4", "5", "6") {
      text(size: 8pt, weight: "bold", fill: accent)[#label]; h(1.3mm); write-slot("", width: 25mm); h(5mm)
    }])
  ]
]

#let code-panel(title, code, size: 9.5pt, inset: 4pt, numbered: false, markers: false) = block(breakable: false, width: 100%,
  inset: (x: inset, y: 2.6pt), fill: code-fill, stroke: (left: 1.15pt + accent), radius: (right: 2pt))[
  #if title != none and title != "" {
    text(font: "Ubuntu Mono", size: 8.5pt, weight: "bold", fill: accent)[#title]
    v(2.2pt)
  }
  #if numbered {
    let lines = code.text.split("\n")
    set text(font: "Ubuntu Mono", size: size)
    set par(leading: 2.4pt)
    if markers {
      grid(columns: (4.5mm, 1fr, 11mm), column-gutter: 1.5mm, row-gutter: .6pt,
        ..lines.enumerate().map(((i, line)) => {
          let parts = line.split("//")
          let source = parts.at(0)
          let marker = if parts.len() > 1 { "//" + parts.at(1) } else { "" }
          (
            align(right, text(size: 7.5pt, fill: muted)[#(i + 1)]),
            raw(source, lang: "java"),
            text(font: "Ubuntu Mono", size: 8pt, fill: muted)[#marker],
          )
        }).flatten())
    } else {
      grid(columns: (4.5mm, 1fr), column-gutter: 1.5mm, row-gutter: .6pt,
        ..lines.enumerate().map(((i, line)) => (
          align(right, text(size: 7.5pt, fill: muted)[#(i + 1)]),
          raw(line, lang: "java"),
        )).flatten())
    }
  } else {
    text(font: "Ubuntu Mono", size: size, fill: ink)[#code]
  }
]

#let question(number, points, body) = block(width: 100%, breakable: false)[
  #grid(columns: (auto, 1fr, auto), column-gutter: 2.5mm, align: horizon,
    text(size: 12.25pt, weight: "semibold", fill: accent)[#int(number)], line(length: 100%, stroke: .4pt + rule),
    text(size: 9.5pt, fill: muted)[#points pontos])
  #v(2.4pt)
  #body
]

#let subitem(label, body, points: none) = block(width: 100%)[
  #grid(columns: (5mm, 1fr), column-gutter: 1mm,
    text(weight: "bold", fill: accent)[#label)], body)
  #v(5.5pt)
]

#let alternative(label, body) = block(width: 100%)[
  #grid(columns: (5mm, 1fr), column-gutter: 1mm,
    text(size: 8.7pt, weight: "bold", fill: accent)[#label.],
    block(width: 100%)[#body])
  #v(5.5pt)
]

#let inline-code(body) = box(inset: (x: 1pt, y: .15pt), fill: soft, radius: 1.5pt)[
  #text(font: "Ubuntu Mono", size: .9em)[#body]
]
