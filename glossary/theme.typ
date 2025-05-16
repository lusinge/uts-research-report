#let theme-academic-custom = (
  section: (title, body) => {
    heading(level: 2, title)
    v(1em)
    body
  },
  group: (name, index, total, body) => {
    if name != "" and total > 1 {
      [=== #eval(name, mode:"markup")]
    }
    body
  },
  entry: (entry, index, total) => {
    let short-display = [#entry.short]
    let long-display = if entry.long == none {
      []
    } else {
      [ ‒ #eval(entry.long, mode: "markup")]
    }

    let description = if entry.description == none {
      []
    } else {
      eval(entry.description, mode: "markup")
    }

    block(
      below: 1em,
      text(
        size: 0.95em,
        {
          grid(
            columns: (1fr, auto),
            gutter: 0.5em,
            block(breakable: false)[
              / #short-display#emph[#long-display]: #description#entry.label
            ],
            entry.pages,
          )
        },
      ),
    )
  },
)
