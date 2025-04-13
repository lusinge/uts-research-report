#import "lib/template/versatile-apa/lib.typ": *
#import "lib/package/glossy/lib.typ": *
#show: init-glossary.with(yaml("glossary/gls.yaml"), term-links: true)
#import "glossary/theme.typ": theme-academic-custom

#let doc-title = [
  Optimising AI at the Edge: UPDATE 1
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
  running-head: [UPDATE 1],
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

#outline()
#pagebreak()

= #doc-title
//#include "sections/introduction.typ"

== Literature Review

=== Computer Architecture and @RISCV:short

Understanding how @ML #footnote[This report uses a lot of abbreviations and complex terms. A glossary is available at #ref(<gls>, form: "page").] systems operate requires knowledge of computer architecture, which is essentially the design and structure of a computer's internal components, such as the @CPU, memory, and @IO systems. Traditional @CPU:pl are designed for general-purpose tasks, handling sequential instructions efficiently. However, @ML computations, such as @DL and @NN, require parallel processing capabilities (#cite(<abderrahmane2020Design>, form: "prose"), #cite(<kovacevic2022RISC-V>, form: "prose"), #cite(<BriefOverviewEdgeAIAccelerators>, form: "prose")). Here, architectures like the kinds used in @GPU:pl @EmbeddedEdgeAiDev or the @RISCV @kovacevic2022RISC-V become crucial.

@RISCV is a relatively new open-source @ISA designed to be customisable and flexible. Unlike proprietary @ISA:pl (such as or ARM or Intel's x86), @RISCV allows researchers and companies to modify its architecture to suit specific tasks, such as @AI acceleration. It also supports vector processing @verma2022EXTREM, which is key for @AI applications that rely heavily on parallel data processing. This makes @RISCV a strong candidate for accelerating @AI tasks in embedded systems, particularly in resource-constrained environments like @IoT devices. While @RISCV offers promise, the surrounding ecosystem, such as development tools and software support, is still maturing compared to more established platforms like @GPU:pl @torres-sanchez2020Develo.

=== Addressing the Limitations of Cloud-Based Systems with Embedded @ML:short

Embedded @ML is increasingly necessary in comparison to traditional cloud computing due to its ability to address several key limitations of cloud-based systems. One of the primary advantages is the reduction of latency @ExploringRISCVBasedDNNAccelerators. By processing data locally, embedded @AI enables real-time decision-making, which is crucial for applications such as autonomous vehicles, industrial automation, and healthcare monitoring, where immediate responses are vital. Additionally, embedded @AI enhances data privacy (#cite(<plantec2023Big_da>, form: "prose"), #cite(<EmbeddedEdgeAiDev>, form: "prose")) by keeping sensitive information on the device rather than transmitting it to the cloud, reducing the risk of data breaches. Energy efficiency is another significant benefit @BriefOverviewEdgeAIAccelerators, as embedded @AI systems are optimised for low-power environments, making them ideal for edge devices like sensors and @IoT systems. This localised approach also helps to overcome bandwidth limitations @dai2019Indust, as it reduces the need to continuously send large amounts of data to the cloud, easing network congestion and cutting costs associated with data transmission​​.

== Gaps in the Literature: Lack of Comparative Analysis

Despite the significant progress in the field of embedded and edge @AI, most studies tend to focus on individual solutions like @GPU:pl, @ASIC:pl @kalapothas2023A_Surv, or @RISCV processors without providing accessible comparisons for engineers making practical decisions. The literature often lacks a holistic, engineering-oriented perspective that would assist in evaluating these technologies based on real-world performance factors.

Moreover, the advantages of local @AI processing, such as reduced bandwidth usage or energy savings, are frequently mentioned but rarely quantified in ways that can guide industry professionals. Very few papers offer clear comparisons across performance, energy efficiency, and cost—between different @AI acceleration technologies, making it difficult for engineers to choose the most suitable solution for their specific applications.

== Conclusion and Research Question
The lack of comparative studies between @AI acceleration solutions leaves a gap in understanding the true benefits of local @AI processing over cloud-based systems. While several publications discuss the advantages of embedded @AI, particularly for latency, privacy, and energy efficiency, there is little focus on how these benefits translate into real-world savings in bandwidth and operational costs. This opens up the following research question:

#line(length: 100%)

*How does @RISCV compare to other @AI acceleration technologies (e.g., @GPU, @ASIC:pl in terms of bandwidth usage, energy efficiency, and performance for locally processed @AI applications?*

#line(length: 100%)

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
