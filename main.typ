#import "lib/template/versatile-apa/lib.typ": *
#import "lib/package/glossy/lib.typ": *
#show: init-glossary.with(yaml("glossary/gls.yaml"), term-links: true)
#import "glossary/theme.typ": theme-academic-custom
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, shapes
#import "@preview/drafting:0.2.2"
#import "@preview/fontawesome:0.5.0": *

#let doc-title = [
  Optimising AI at the Edge: Performance and energy efficiency in RISC-V-based systems
]

#show: versatile-apa.with(
  title: doc-title,

  // // authors with different affiliations
  // authors: (
  //   (
  //     name: [Author Name 1],
  //     affiliations: ("AF-1", "AF-2"),
  //   ),
  //   (
  //     name: [Author Name 2],
  //     affiliations: ("AF-3",),
  //   ),
  //   (
  //     name: [Author Name 3],
  //     affiliations: ("AF-4", "AF-5", "AF-6"),
  //   ),
  // ),
  // affiliations: (
  //   (
  //     id: "P",
  //     name: [Affiliation Department 1],
  //   ),
  //   (
  //     id: "AF-2",
  //     name: [Affiliation Department 2],
  //   ),
  //   (
  //     id: "AF-3",
  //     name: [Affiliation Department 3],
  //   ),
  //   (
  //     id: "AF-4",
  //     name: [Affiliation Department 4],
  //   ),
  //   (
  //     id: "AF-5",
  //     name: [Affiliation Department 5],
  //   ),
  //   (
  //     id: "AF-6",
  //     name: [Affiliation Department 6],
  //   )
  // ),

  // authors with shared affiliations
  authors: (
    (
      name: [Lucien Gheerbrant],
      affiliations: ("UTS", "EMSE"),
    ),
  ),
  affiliations: (
    (
      id: "EMSE",
      name: [École des Mines de Saint-Étienne],
    ),
    (
      id: "UTS",
      name: [University of Technology Sydney],
    ),
  ),

  // custom-authors: [Author Name],
  // custom-affiliations: [Affiliation Department, Affiliation Name],

  // Student-specific fields
  course: [42003 Engineering Graduate Project - Autumn 2025],
  instructor: [Thuy Pham],
  // At the moment only supports English
  due-date: datetime.today().display(),

  // Professional-specific fields
  running-head: [Optimising AI at the Edge],
  // author-notes: [
  //   #include-orcid([Author Name], "0000-0000-0000-0000")

  //   #lorem(50)
  // ],
  // keywords: ("APA", "template", "Typst"),
  // abstract: lorem(100),

  // Common fields
  font-family: "Libertinus Serif",
  font-size: 12pt,
  region: "au",
  language: "en",
  paper-size: "a4",
  implicit-introduction-heading: false,
  abstract-as-description: true,
)

#include "sections/introduction.typ"

#pagebreak()
#outline()
#heading(outlined: false)[List of Figures]
#outline(
  title: none,
  target: figure.where(kind: image), 
)
#heading(outlined: false)[List of Tables]
#outline(
  title: none,
  target: figure.where(kind: table), 
)

#pagebreak()
#include "sections/literature-review/literature review.typ"

#pagebreak()
#include "sections/findings/findings.typ"

#pagebreak()
#include "sections/discussion/discussion.typ"

#pagebreak()
== Annex

#figure(
  caption: [Simulated Naive Model],
  placement: none,
)[
  #image("sections/findings/img/naive-system-se.svg")
] <model-baremetal>

#block(breakable: false)[
  #figure(
    caption: [Simulated Model With Cache],
    placement: none,
  )[
    #image("sections/findings/img/better-system-se.svg")
  ] <model-baremetal-better>
]


#pagebreak()
#glossary(
  sort: true, // Optional: whether or not to sort the glossary
  theme: theme-academic-custom, // Optional: defaults to theme-academic
  ignore-case: false, // Optional: ignore case when sorting terms
  //groups: ("Web"),  // Optional: Filter to specific groups
  show-all: false, // Optional; Show all terms even if unreferenced
) <gls>

#pagebreak()
== References
#bibliography(
  "bibliography/ref.bib", // or ref.yml
  full: true,
  title: none,
)

// #show: appendix.with(
//   heading-numbering: "A",
//   supplement: "Appendix",
// )
//
// #include "sections/appendix.typ"
//
// = List of Appendices
// #appendix-outline(title: none)

