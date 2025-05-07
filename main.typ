#import "lib/template/versatile-apa/lib.typ": *
#import "lib/package/glossy/lib.typ": *
#show: init-glossary.with(yaml("glossary/gls.yaml"), term-links: true)
#import "glossary/theme.typ": theme-academic-custom
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, shapes
#import "@preview/drafting:0.2.2"
#import "@preview/fontawesome:0.5.0": *

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
= Literature Review

== Computer Architecture and @RISCV:short

=== The mathematics behind @ML:short

Understanding how modern @ML #footnote[This report uses a lot of abbreviations and complex terms. A glossary is available at #ref(<gls>, form: "page").] systems operate requires not only knowledge of computer architecture, but also the mathematical logic behind @NN:pl.

This research project will not focus on the training part of @ML models, but their #emph[@inference]. @inference[Inference] is the #quote(attribution: <mercadal1990dictionnary>)[process of deriving new facts from previously known facts]. In the case of @ML, it means deducting results on unseen data with previously used data.

We will consider an extremely simplistic #lower[@NN:long].\
Let $X = vec(x_1, x_2, x_3) in [|0,255|]^(3 times 1)$ the input layer. Here it is composed of three neurons. Let $W = mat(w_1, w_2, w_3) in [-5, 5]^(1 times 3)$ the respective weights of $X$. This @NN is illustrated in #lower[@simple-NN].

#apa-figure(
  caption: [A simple #lower[@NN:long]],
  label: "simple-NN",
)[
  #diagram(
    node-stroke: 1pt,
    node-fill: white,
    node-shape: circle,

    node(name: <input-layer-title>, (0, -1.5), [Input Layer], stroke: none, shape: rect),
    node(name: <x1>, (0, -1), [$x_1$]),
    node(name: <x2>, (0, 0), [$x_2$]),
    node(name: <x3>, (0, 1), [$x_3$]),

    node(name: <output-layer-title>, (1, -1.5), [Output Layer], stroke: none, shape: rect),
    node(name: <y>, (1, 0), [$y$]),
    node(name: <b>, (1, 0.75), [$b$], stroke: none, fill: none),

    edge(<x1>, "->", <y>, label-side: center)[$w_1$],
    edge(<x2>, "->", <y>, label-side: center)[$w_2$],
    edge(<x3>, "->", <y>, label-side: center)[$w_3$],
    edge(<b>, "-->", <y>),
  )
]

In order to _infer_ a result $y$ with a bias $b$, we will compute: $ y = W dot X + b $ <feed-forward>. @feed-forward is known as the "feed-forward". This is however, an extreme simplification of the mathematics behind @NN. The point of this example, is to demonstrate how modern @ML tasks deeply rely on vector/matrix dot products.

=== Transcribing the mathematics to a computing system

Computer architecture is the design and structure of a computer's internal components, such as the @CPU, memory, and @IO systems. Traditional @CPU:pl are designed for general-purpose tasks, handling sequential instructions efficiently. As we discussed in the previous section, @ML computations, such as @DL and @NN, require a lot of matrix computing capabilities, i.e. parallel processing (#cite(<abderrahmane2020Design>, form: "prose"), #cite(<kovacevic2022RISC-V>, form: "prose"), #cite(<BriefOverviewEdgeAIAccelerators>, form: "prose")). Here, architectures like the kinds used in @GPU:pl @EmbeddedEdgeAiDev or the @RISCV @kovacevic2022RISC-V become crucial.

@RISCV is a relatively new open-source @ISA designed to be customisable and flexible. Unlike proprietary @ISA:pl (such as or ARM or Intel's x86), @RISCV allows researchers and companies to modify its architecture to suit specific tasks, such as @AI acceleration. It also supports vector processing @verma2022EXTREM, which is key for @AI applications that rely heavily on parallel data processing. This makes @RISCV a strong candidate for accelerating @ML tasks in embedded systems, particularly in resource-constrained environments like @IoT devices. While @RISCV offers promise, the surrounding ecosystem, such as development tools and software support, is still maturing compared to more established platforms like @GPU:pl @torres-sanchez2020Develo.

== Addressing the Limitations of Cloud-Based Systems with Embedded @ML:short

Embedded @ML is increasingly necessary in comparison to traditional cloud computing due to its ability to address several key limitations of cloud-based systems. One of the primary advantages is the reduction of latency @ExploringRISCVBasedDNNAccelerators. By processing data locally, embedded @ML enables real-time decision-making, which is crucial for applications such as autonomous vehicles, industrial automation, and healthcare monitoring, where immediate responses are vital. Additionally, embedded @ML enhances data privacy (#cite(<plantec2023Big_da>, form: "prose"), #cite(<EmbeddedEdgeAiDev>, form: "prose")) by keeping sensitive information on the device rather than transmitting it to the cloud, reducing the risk of data breaches. Energy efficiency is another significant benefit @BriefOverviewEdgeAIAccelerators, as embedded @AI systems are optimised for low-power environments, making them ideal for edge devices like sensors and @IoT systems. This localised approach also helps to overcome bandwidth limitations @dai2019Indust, as it reduces the need to continuously send large amounts of data to the cloud, easing network congestion and cutting costs associated with data transmission​​.

== Gaps in the Literature: Lack of Comparative Analysis

Despite the significant progress in the field of embedded and edge @AI, most studies tend to focus on individual solutions like @GPU:pl, @ASIC:pl @kalapothas2023A_Surv, or @RISCV processors without providing accessible comparisons for engineers making practical decisions. The literature often lacks a holistic, engineering-oriented perspective that would assist in evaluating these technologies based on real-world performance factors.

Moreover, the advantages of local @NN processing, such as reduced bandwidth usage or energy savings, are frequently mentioned but rarely quantified in ways that can guide industry professionals. Very few papers offer clear comparisons across performance, energy efficiency, and cost—between different @NN acceleration technologies, making it difficult for engineers to choose the most suitable solution for their specific applications.

== Conclusion and Research Question
The lack of comparative studies between @NN acceleration solutions leaves a gap in understanding the true benefits of local @ML processing over cloud-based systems. While several publications discuss the advantages of embedded @ML, particularly for latency, privacy, and energy efficiency, there is little focus on how these benefits translate into real-world savings in bandwidth and operational costs. This opens up the following research question:

#line(length: 100%)

*How does @RISCV compare to other @NN acceleration technologies (e.g., @GPU, @ASIC:pl in terms of bandwidth usage, energy efficiency, and performance for locally processed @ML applications?*

#line(length: 100%)

#pagebreak()

= Findings

== State of the art in embedded @ML:short

=== The need for embedded @ML:short

In #cite(<krizhevsky2017ImageN>, form: "year"), #cite(<krizhevsky2017ImageN>, form: "author") used an Nvidia @GPU to create a model, AlexNet @krizhevsky2017ImageN @khan2021Advanc. It was not the first time someone used a @GPU[graphics card] for such application. However, #cite(<krizhevsky2017ImageN>, form: "author") had obtained such good results, computer scientists have relied almost exclusively on @GPU:pl for @ML tasks (including @inference) in the last decade @khan2021Advanc. This due to @GPU:pl' optimised design for parallel processing and widespread availability. However, @GPU:pl[graphics cards] are power-hungry and unsuitable for embedded @inference. In fact, achieving low-power @inference could reduce significantly the carbon output of @ML computing @tschand2025mlperfpowerbenchmarkingenergy.

In the last couple of years, researchers have explored alternative approaches focusing on low-energy consumption for inference computing. This in search of @IoIT. @IoIT, as the name suggests, is an advanced form of IoT, where devices not only collect and exchange data but also use AI to process information and make intelligent decisions at the edge @oliveira2024Intern. This has led to the term "@TinyML". @TinyML consists in using micro-controller and other low-power devices to execute @ML tasks.

=== @TFLM:short

@TFLite is an efficient, open-source deep learning framework tailored for mobile and embedded devices. It optimises on-device @ML inference by employing techniques. @TFLite was made for applications in mobile phones, @IoT devices, and other environments with limited resources.

@TFLM extends these capabilities to even more constrained devices, such as microcontrollers. It was designed to operate bare-metal on devices with minimal @RAM and no operating system. This enables the deployment of ML models on ultra-low-power devices, such as wearable technology and sensor networks.

=== Benchmarks

In this research, we will be using MLPerf @reddi2019MLPerf. The MLPerf benchmark suite is designed to evaluate the performance of different systems in @ML tasks by aiming to set up the same conditions for each test. MLPerf is part of a larger effort by MLCommons @MLCommons2025Jan, a group focused on advancing machine learning technology. Due to the limited time available for this research, our analysis will focus solely on the data provided by MLCommons to assess the performance and efficiency of ML inference systems. What is interesting about MLPerf is that it categorises systems by their scale, such as datacenters or embedded systems. The latter's metrics are benchmarked by 'MLPerf Tiny' @banbury2021mlperf. MLPerf Tiny is a specialised benchmark within the MLPerf suite, designed to evaluate the performance of machine learning systems specifically for small-scale or embedded environments. This benchmark targets systems with limited resources, such as those found in wearable devices or edge computing applications, which fit @IoIT[IoIT-related] tasks. MLPerf not only simplifies the process of replicating its benchmarks across various settings, ensuring consistent testing conditions, but it also actively collects and publishes the results of these benchmarks from a wide range of systems @MLPerfTinyWeb2024Nov @cm4mlperf-results.

== Simulation

=== gem5

==== The gem5 simulator

The gem5 simulator is a widely-used open-source simulator designed for computer architecture research. It allows researchers to model and simulate various components of computer systems, including processors, memory, and interconnects. Its flexibility and modularity make it a powerful tool for exploring new architectural designs and optimisations.

The gem5 project is primarily implemented in C++, leveraging the language's object-oriented features to create a modular and extensible simulation framework. The core components of a computer system, such as CPUs, memory controllers, and buses, are represented as C++ classes, known as `SimObjects`. These `SimObjects` encapsulate the behaviour and characteristics of the hardware components they model, allowing for detailed and accurate simulations.

The object-oriented design of gem5 facilitates the creation of complex models by enabling the reuse and combination of existing `SimObjects`. Researchers can easily extend or modify these objects to explore new architectural ideas or to model specific hardware configurations.

==== Using gem5

To understand how gem5 is used, let's explore the creation of a model within this simulator. Although it's unconventional to include code snippets in a report, gem5's approach to connecting different simulation objects is particularly interesting.

The first step in gem5 is to create the "system," an object that defines the simulation environment:

```python
system = System()
```

Additional objects can be added as attributes to this system. For example, to add a clock frequency:

```python
system.clk_domain = SrcClockDomain()
system.clk_domain.clock = '50MHz'
```

This clock frequency will be used by other simulated objects. For instance, a processor model named `RiscvMinorCpu` using the @RISCV instruction set can be added as follows:

```python
system.cpu = RiscvMinorCPU()
```

#block(breakable: false)[
  Next, we connect a memory bus. The gem5 simulator modifies the "`=`" operator to facilitate these connections:

  ```python
  system.membus = SystemXBar()
  system.cpu.icache_port = system.membus.cpu_side_ports
  system.cpu.dcache_port = system.membus.cpu_side_ports
  ```
]

This model is illustrated in @diagBusCPU[figure], showing the connection between the processor and the memory bus:

#figure(caption: [Processor-Memory Bus Connection])[
  #diagram(
    node((0, 0), [@CPU[Processor]], fill: rgb("#ffbe6f"), width: 16em, height: 4em),
    node((0, 1.1), [Memory bus], fill: rgb("#99c1f1"), width: 16em),
    node((-0.33, 0.50), [@IMEM:short port]),
    node((0.33, 0.50), [@DMEM:short port]),
    edge((-0.33, 1.1), (-0.33, 0.50), "<|-|>"),
    edge((0.33, 1.1), (0.33, 0.50), "<|-|>"),
  )
] <diagBusCPU>

In this setup, the "`=`" operator connects the processor's instruction and data memory ports to the memory bus's "`cpu_side`" port. The coherent data exchange between these components in gem5's backend.


=== Naive model

The first model in this simulation uses gem5's unmodified `RiscvMinorCPU`, providing a baseline for evaluating performance and efficiency in embedded ML applications. This model operates without any cache hierarchy, relying solely on DDR3 RAM for memory operations. It is a very simplistic model, essentially a generic microcontroller that has not been specifically designed for embedded ML. The model is illustrated in @first-model[figure].


#figure(caption: [First model])[
  #diagram(
    node(name: <minorcpu>, (0, 0), [@CPU[`RiscvMinorCPU` ]], fill: rgb("#ffbe6f"), width: 16em, height: 4em),
    node(name: <membus>, (0, 2), [Memory bus], fill: rgb("#99c1f1"), width: 12em),
    node(name: <imem-port>, (-0.33, 0.50), [@IMEM:short port]),
    node(name: <dmem-port>, (0.33, 0.50), [@DMEM:short port]),

    node(name: <ddr3>, (0, 3), [DDR3 @RAM], fill: rgb("#469652"), width: 16em),

    edge(<imem-port>, "<|-|>", <membus>),
    edge(<dmem-port>, "<|-|>", <membus>),
    edge(<ddr3>, "<|-|>", <membus>),
  )
] <first-model>

== Executing inference tasks on the model

=== High-level architecture

To execute inference tasks on the model, I use a simple process that partly relies on existing research to speed up development: I used ELF executable files (elfies) compile by a previous research from #cite(<aymone2024riscvtflite>, form: "prose"). I then "flashed" it into my microcontroller model. Elfies are compiled binaries that contain the machine code needed to run specific programs or tasks. The elfies in question here, where MLPerf Tiny benchmarks compiled with @TFLM.

This high-level architecture is shown in @high-level-arch

#figure(caption: [High level architecture of the simulation])[
  #diagram(
    node((-2, 0))[
      MLPerf Tiny\
      Benchmarks
    ],

    edge("->"),

    node((-1, 0))[
      @TFLM
    ],

    edge("->"),

    node((0, 0))[
      #text(size: 32pt)[#fa-icon("file-binary")]\
      `elf`
    ],

    edge("->")[flash],
    node((2, 0))[
      #text(size: 32pt)[#fa-icon("microchip")]\
      Model
    ],

    edge("->")[execute],

    node((4, 0))[

      #text(size: 32pt)[#fa-icon("laptop-binary")]\
      Output
    ],
  )
] <high-level-arch>

== Results

This setup allows us to run inference tasks efficiently, although it caused some compatibility issues since the elfies weren't originally compiled for our system.

For now, the model is not capable of executing a whole `elf` file, as the basic `RiscvMinorCPU` from gem5 lacks some needed extension.

We get the following results:
#figure(caption: [Instructions from executing the MLPerf Tiny benchmarks in the first model])[
  #show raw: set text(size: 6pt)
  ```
  Beginning simulation!
  420000: system.cpu: T0 : 0x105c6 @_start    : auipc gp, 80               : IntAlu :  D=0x00000000000605c6
  440000: system.cpu: T0 : 0x105ca @_start+4    : addi gp, gp, 190           : IntAlu :  D=0x0000000000060684
  460000: system.cpu: T0 : 0x105ce @_start+8    : addi a0, gp, 1036          : IntAlu :  D=0x0000000000060a90
  460000: system.cpu: T0 : 0x105d2 @_start+12    : auipc a2, 81               : IntAlu :  D=0x00000000000615d2
  480000: system.cpu: T0 : 0x105d6 @_start+16    : addi a2, a2, -1870         : IntAlu :  D=0x0000000000060e84
  500000: system.cpu: T0 : 0x105da @_start+20    : c_sub a2, a0               : IntAlu :  D=0x00000000000003f4
  500000: system.cpu: T0 : 0x105dc @_start+22    : c_li a1, 0                 : IntAlu :  D=0x0000000000000000
  520000: system.cpu: T0 : 0x105de @_start+24    : jal ra, 139264             : IntAlu :  D=0x00000000000105e2
  980000: system.cpu: T0 : 0x325de @memset    : c_li t1, 15                : IntAlu :  D=0x000000000000000f
  [...]
  88000000: system.cpu: T0 : 0x2d898 @_findenv_r+86    : sub s0, a5, s3             : IntAlu :  D=0x0000000000000010
  88220000: system.cpu: T0 : 0x2d89c @_findenv_r+90    : c_lw a0, 0(s1)             : MemRead :  D=0x0000000000000000 A=0x60ac8
  88220000: system.cpu: T0 : 0x2d89e @_findenv_r+92    : c_beqz a0, -32             : IntAlu :
  src/cpu/minor/execute.cc:370: fatal: Received error response packet for inst: 0/49.87/308/876.876 pc: 0x2d87e (c_lwsp)
  Memory Usage: 690380 KBytes
  ```
] <results>

We can see in @results[listing] that the @RISCV instructions being executed in real time through the model defined previously. We hit an error when executing the instruction `c_lwsp`. This probably means the model is missing a piece necessary for the execution of the program. This could be a memory range or a @RISCV extension.

== Going Further

In my ongoing efforts to simulate the MLPerf Tiny benchmark on a C++ model of a @RISCV microcontroller, I need to identify and address the missing components in the model. Initially, I expect suboptimal performance results due to our "naive" approach, which does not utilise the @RISCV "V" Vector extension (RVV). This means the microcontroller operates without a dedicated block for matrix dot products.

Fortunately, researchers at the Technical University of Munich have developed the muRISCV-NN kernel @van2024muRISC, which enables the use of the vector extension in RISC-V microcontrollers for embedded AI applications. Released towards the end of last year, this kernel has the potential to significantly enhance my simulations.

= List of Figures
#outline(
  title: none,
  target: figure.where(kind: image),
)

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
