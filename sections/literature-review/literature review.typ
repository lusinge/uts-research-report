#import "../../lib/template/versatile-apa/lib.typ": *
#import "../../lib/package/glossy/lib.typ": *
#show: init-glossary.with(yaml("../../glossary/gls.yaml"), term-links: true)
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, shapes
#import "@preview/fontawesome:0.5.0": *

= Literature Review

== Computer Architecture and @RISCV:short

=== The Mathematics Behind @ML:short

Understanding how modern @ML #footnote[This report uses a lot of abbreviations and complex terms. A glossary is available at #ref(<gls>, form: "page").] systems operate requires not only knowledge of computer architecture, but also the mathematical logic behind @NN:pl.

This research project will not focus on the training part of @ML models, but their #emph[@inference]. @inference[Inference] is the #quote(attribution: <mercadal1990dictionnary>)[process of deriving new facts from previously known facts]. In the case of @ML, it means deducting results on unseen data with previously used data.

We will consider an extremely simplistic #lower[@NN:long].\
Let $X = vec(x_1, x_2, x_3) in [|0,255|]^(3 times 1)$ the input layer. Here it is composed of three neurons. Let $W = mat(w_1, w_2, w_3) in [-5, 5]^(1 times 3)$ the respective weights of $X$. This @NN is illustrated in #lower[@simple-NN].

#apa-figure(
  caption: [A Simple @NN:long],
  label: "simple-NN",
)[
  #diagram(
    node-stroke: 1pt,
    node-fill: white,
    node-shape: circle,

    node(
      name: <input-layer-title>,
      (0, -1.5),
      [Input Layer],
      stroke: none,
      shape: rect,
    ),
    node(name: <x1>, (0, -1), [$x_1$]),
    node(name: <x2>, (0, 0), [$x_2$]),
    node(name: <x3>, (0, 1), [$x_3$]),

    node(
      name: <output-layer-title>,
      (1, -1.5),
      [Output Layer],
      stroke: none,
      shape: rect,
    ),
    node(name: <y>, (1, 0), [$y$]),
    node(name: <b>, (1, 0.75), [$b$], stroke: none, fill: none),

    edge(<x1>, "->", <y>, label-side: center)[$w_1$],
    edge(<x2>, "->", <y>, label-side: center)[$w_2$],
    edge(<x3>, "->", <y>, label-side: center)[$w_3$],
    edge(<b>, "-->", <y>),
  )
]

In order to _infer_ a result $y$ with a bias $b$, we will compute: $ y = W dot X + b $ <feed-forward>. @feed-forward is known as the "feed-forward". This is however, an extreme simplification of the mathematics behind @NN. The point of this example, is to demonstrate how modern @ML tasks deeply rely on vector/matrix dot products.

=== Transcribing The mathematics To A Computing System

Computer architecture is the design and structure of a computer's internal components, such as the @CPU, memory, and @IO systems. Traditional @CPU:pl are designed for general-purpose tasks, handling sequential instructions efficiently. As we discussed in the previous section, @ML computations, such as @DL and @NN, require a lot of matrix computing capabilities, i.e. parallel processing (#cite(<abderrahmane2020Design>, form: "prose"), #cite(<kovacevic2022RISC-V>, form: "prose"), #cite(<BriefOverviewEdgeAIAccelerators>, form: "prose")). Here, architectures like the kinds used in @GPU:pl @EmbeddedEdgeAiDev or the @RISCV @kovacevic2022RISC-V become crucial.

@RISCV is a relatively new open-source @ISA designed to be customisable and flexible. Unlike proprietary @ISA:pl (such as or ARM or Intel's x86), @RISCV allows researchers and companies to modify its architecture to suit specific tasks, such as @AI acceleration. It also supports vector processing @verma2022EXTREM, which is key for @AI applications that rely heavily on parallel data processing. This makes @RISCV a strong candidate for accelerating @ML tasks in embedded systems, particularly in resource-constrained environments like @IoT devices. While @RISCV offers promise, the surrounding ecosystem, such as development tools and software support, is still maturing compared to more established platforms like @GPU:pl @torres-sanchez2020Develo.

== Addressing the Limitations of Cloud-Based Systems with Embedded @ML:short

Embedded @ML is increasingly necessary in comparison to traditional cloud computing due to its ability to address several key limitations of cloud-based systems. One of the primary advantages is the reduction of latency @ExploringRISCVBasedDNNAccelerators. By processing data locally, embedded @ML enables real-time decision-making, which is crucial for applications such as autonomous vehicles, industrial automation, and healthcare monitoring, where immediate responses are vital. Additionally, embedded @ML enhances data privacy (#cite(<plantec2023Big_da>, form: "prose"), #cite(<EmbeddedEdgeAiDev>, form: "prose")) by keeping sensitive information on the device rather than transmitting it to the cloud, reducing the risk of data breaches. Energy efficiency is another significant benefit @BriefOverviewEdgeAIAccelerators, as embedded @AI systems are optimised for low-power environments, making them ideal for edge devices like sensors and @IoT systems. This localised approach also helps to overcome bandwidth limitations @dai2019Indust, as it reduces the need to continuously send large amounts of data to the cloud, easing network congestion and cutting costs associated with data transmission​​.

== Gaps in the Literature: Lack of Comparative Analysis

Despite the rapid progress in embedded and edge @AI, most publications still treat each hardware avenue in isolation. Papers commonly centre on a single instruction-set architecture (@ISA), such as @RISCV or @ARM, or even on one custom accelerator like @ASIC:pl or @FPGA:pl @kalapothas2023A_Surv without laying them side by side. Engineers who must choose between a lean @RISCV core, an @ARM\-based SoC, or a dedicated @ASIC/@FPGA.


