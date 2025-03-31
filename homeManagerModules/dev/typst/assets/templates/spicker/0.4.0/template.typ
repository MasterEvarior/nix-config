#let spicker(doc) = {
    set page(
        paper: "a4",
        margin: 15pt,
        flipped: true,
        columns: 3
    )

    set columns(gutter: 3pt)

    set text(
        font: "Cascadia Code",
        size: 5pt,
        lang: "ch"
    )

    set par(
        leading: 0.9em
    )

    show raw.where(block: false): box.with(
        fill: luma(240),
        inset: (x: 2.5pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
    )
    
    show raw.where(block: true): block.with(
        fill: luma(240),
        inset: 2.5pt,
        radius: 2.5pt,
        width: 100%,
        above: 1em
    )

    show heading.where(level: 1): block.with(
        fill: yellow,
        breakable: false,
        inset: 2.5pt,
        radius: 3pt,
        width: 75%,
        outset: 1pt,
        above: 0.5em
    )

    doc
}