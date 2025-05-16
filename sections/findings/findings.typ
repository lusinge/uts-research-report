#import "../../lib/template/versatile-apa/lib.typ": *
#import "../../lib/package/glossy/lib.typ": *
#show: init-glossary.with(yaml("../../glossary/gls.yaml"), term-links: true)
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, shapes
#import "@preview/fontawesome:0.5.0": *

= Findings

== State Of The Art In Embedded @ML:short

=== The Need For Embedded @ML:short

In #cite(<krizhevsky2017ImageN>, form: "year"), #cite(<krizhevsky2017ImageN>, form: "author") used an Nvidia @GPU to create a model, AlexNet @krizhevsky2017ImageN @khan2021Advanc. It was not the first time someone used a @GPU[graphics card] for such application. However, #cite(<krizhevsky2017ImageN>, form: "author") had obtained such good results, computer scientists have relied almost exclusively on @GPU:pl for @ML tasks (including @inference) in the last decade @khan2021Advanc. This due to @GPU:pl' optimised design for parallel processing and widespread availability. However, @GPU:pl[graphics cards] are power-hungry and unsuitable for embedded @inference. In fact, achieving low-power @inference could reduce significantly the carbon output of @ML computing @tschand2025mlperfpowerbenchmarkingenergy.

In the last couple of years, researchers have explored alternative approaches focusing on low-energy consumption for inference computing. This in search of @IoIT. @IoIT, as the name suggests, is an advanced form of @IoT. Here, devices not only collect, exchange data but also use AI to process information and make intelligent decisions at the edge @oliveira2024Intern. This has led to the term "@TinyML". @TinyML consists in using microcontroller and other low-power devices to execute @ML tasks.

=== @TFLM:short

@TFLite is an efficient, open-source deep learning framework tailored for mobile and embedded devices. It optimises on-device @ML inference by employing techniques. @TFLite was made for applications in mobile phones, @IoT devices, and other environments with limited resources.

@TFLM extends these capabilities to even more constrained devices, such as microcontrollers. It was designed to operate bare-metal on devices with minimal @RAM and no operating system. This enables the deployment of ML models on ultra-low-power devices, such as wearable technology and sensor networks.

=== Benchmarks

==== MLPerf

In this research, we will be using MLPerf @reddi2019MLPerf. The MLPerf benchmark suite is designed to evaluate the performance of different systems in @ML tasks by aiming to set up the same conditions for each test. MLPerf is part of a larger effort by MLCommons @MLCommons2025Jan, a group focused on advancing machine learning technology. Due to the limited time available for this research, our analysis will focus solely on the data provided by MLCommons to assess the performance and efficiency of ML inference systems. What is interesting about MLPerf is that it categorises systems by their scale, such as datacentres or embedded systems. The latter's metrics are benchmarked by 'MLPerf Tiny' @banbury2021mlperf. MLPerf Tiny is a specialised benchmark within the MLPerf suite, designed to evaluate the performance of machine learning systems specifically for small-scale or embedded environments. This benchmark targets systems with limited resources, such as those found in wearable devices or edge computing applications, which fit @IoIT[IoIT-related] tasks. MLPerf not only simplifies the process of replicating its benchmarks across various settings, ensuring consistent testing conditions, but it also actively collects and publishes the results of these benchmarks from a wide range of systems @MLPerfTinyWeb2024Nov @cm4mlperf-results.

==== Cross-Device MLPerf Tiny Results

We processed the data collected and published by MLPerf @banbury2021mlperf to evaluate the current feasibility of edge computing using @RISCV[RISCV-based] chips. To analyse the performance of various systems, we gathered data from the MLPerf Tiny benchmark, focusing on systems that had both latency and energy consumption metrics available. We then compiled this data from `v0.5` to `v1.2` of MLPerf Tiny to ensure having the highest number of computing systems. All the steps and data processing methods used in this analysis are replicable and can be found in an online repository @LuluGit2025Mar.

We chose to focus on @VWW and @IC as our primary ML applications for analysis. These applications were selected because they are popular use-cases within @ML tasks. @VWW involves detecting specific visual cues in real-time. Meanwhile, @IC requires recognising and categorising visual data @banbury2021mlperf.

#block(breakable: false)[
  #figure(caption: [MLPerf Inference Tiny MobileNetV1 0.25x Results])[
    #image("img/vww.svg")
  ] <vww-fig>

  #figure(caption: [MLPerf Inference Tiny MobileNetV1 0.25x Results Grouped By @ISA:short])[
    #image("img/isa-vww.svg")
  ] <isa-vww-fig>
]

#block(breakable: false)[
  #figure(caption: [MLPerf Inference Tiny ResNet-V1 Results])[
    #image("img/ic.svg")
  ] <ic-fig>

  #figure(caption: [MLPerf Inference Tiny ResNet-V1 Results Grouped By @ISA:short])[
    #image("img/isa-ic.svg")
  ] <isa-ic-fig>
]
@vww-fig illustrates the performance of various systems in terms of latency and energy consumption for ML inference using the MLPerf Tiny benchmark with the MobileNetV1 0.25x model @howard2017Mobile, used in @VWW applications. Systems closer to the bottom-left corner are ideal for real-time, energy-constrained applications. @isa-vww-fig illustrates the performance, but grouped by @ISA instead of individual systems. Similarly, @ic-fig and @isa-ic-fig show the results from executing ResNet-V1 model @he2015Deep_R for @IC purposes.

In figures @vww-fig[] to @isa-ic-fig[], we can observe significant superior performances for the sole @RISCV system on the MLPerf Tiny benchmark that has both energy consumption and latency measured. That system is the "GAP9" by GreenWaves @gap9site#footnote[As of writing this paper, GreenWaves is no longer an operational entity. They have been liquidated in early 2025. Details are not disclosed to the public yet.] <uh-oh>. While these findings are intriguing, it is crucial to recognise that the sample size (of n=1) is objectively too small to conclude any opinion on the advantages of @RISCV#footnote[Especially given the context of the above footnote.]. The MLPerf Benchmark results does have more data for @RISCV systems, but only for energy consumption per @inference. That is why to address the sample limitation, we employed another data set, containing only energy consumption this time. @box-vww and @box-ic respectively present a box plot of the energy consumption of MobileNetV1 and ResNet-V1 in the MLPerf Inference Tiny benchmark, comparing ARM and RISC-V architectures. This visualisation provides more insights into the distribution and variability of energy consumption across different systems (especially in @RISCV).
#block(breakable: false)[
  #figure(
    caption: [Box Plot of Latency In Inference Application of MobileNetV1in (@VWW) MLPerf Inference Tiny (Lower Is Better)],
  )[
    #image("img/boxplot-vww.svg", height: 37.5%)
  ] <box-vww>

  #figure(
    caption: [Box Plot of Box Plot of Latency In Inference Application of ResNet-V1 (@IC) in MLPerf Inference Tiny (Lower Is Better)],
  )[
    #image("img/boxplot-ic.svg", height: 37.5%)
  ] <box-ic>
]
First, we can infer from @box-vww and @box-ic that @ARM dominates largely the embedded @NN market. ARM indeed represents between 88% and 90% of the systems registered in MLPerf Tiny.

Secondly, it will still be hard to give any conclusion on the superiority/inferiority of @RISCV in the current state-of-the-art. Indeed, we need to consider the still relatively small sample size (n $in$ {5,6}) for this @ISA. That means the hypothesis that @ISA:pl do not infer in performance *cannot* be dismissed here. Furthermore, both @ISA:pl show single-digit-millisecond outliers and >800 ms outliers. Those extremes dilute any performance narrative. Coupled with the low sample size for @RISCV systems, one odd point can skew the median. Finally, those plot do not show the whole picture: @RAM, memory bandwidth and other characteristics can greatly influence inference performance.

However, this data set does not deserve to be fully discarded still limited. It offers a more robust starting point for analysis. We will nevertheless consider the criticism made in the previous paragraph. MLPerf Tiny results are still evolving and this is just a starting point. In both cases (for @IC and @VWW applications), median latency favours RISC-V by roughly \~25-40%. Furthermore, the dispersion also seems to give points to @RISCV systems. However, the fastest systems are, according to MLCommons, using @ARM @banbury2021mlperf.

== Simulation

=== The Case for Modelling

To better understand the performance of different @ISA:pl, we sought to supplement our results with simulation-based analysis. This approach allows us to introduce additional sources of comparison by simulating a larger number of system configurations. Moreover, simulation helps us confirm and recreate MLPerf Tiny results, even without access to specialised hardware. While acquiring the exact same setups as those used in the original study would be ideal, digital models enable us to replicate their findings without any particular budget. Additionally, simulations provide a platform for exploring the effects of different system characteristics. By varying the simulation parameters (e.g., RAM size, memory bandwidth...), we can investigate how these factors influence inference performance. Finally, modelling enables us to generate a more comprehensive and generalisable dataset. By exploring multiple system configurations and ISA variations, we can develop a more nuanced picture of the performance landscape and identify potential avenues for further research or optimisation.

=== gem5

==== The gem5 Simulator

The gem5 simulator is a widely-used open-source simulator designed for computer architecture research. It allows researchers to model and simulate various components of computer systems, including processors, memory, and interconnects. Its flexibility and modularity make it a powerful tool for exploring new architectural designs and optimisations.

The gem5 project is primarily implemented in C++, leveraging the language's object-oriented features to create a modular and extensible simulation framework. The core components of a computer system, such as CPUs, memory controllers, and buses, are represented as C++ classes, known as `SimObjects`. These `SimObjects` encapsulate the behaviour and characteristics of the hardware components they model, allowing for detailed and accurate simulations.

This project employs an event-driven architecture, which is fundamental to its operation as a discrete-event simulator. In this architecture, the simulation progresses by processing events that are scheduled to occur at specific simulation times. Each event represents a change in the state of the system, such as a CPU instruction execution, a memory access, or an interrupt. The event-driven nature of gem5 allows for efficient simulation of complex systems by only processing events when they occur, rather than continuously simulating every component.


The object-oriented design of gem5 facilitates the creation of complex models by enabling the reuse and combination of existing `SimObjects`. Researchers can easily extend or modify these objects to explore new architectural ideas or to model specific hardware configurations.

gem5 is utilised by various companies and academic institutions for research and educational purposes. Some notable users include @ARM #footnote[The company that owns the @ARM @ISA intellectual property, not the @ISA itself.], which uses gem5 for research and development in processor architecture. AMD employs gem5 for exploring new designs and optimizing existing architectures. Intel utilizes gem5 for simulating and testing new architectural designs. IBM leverages gem5 for research in computer architecture and system design. Qualcomm uses gem5 for modeling and simulating mobile processor architectures.

==== Using gem5

To understand how gem5 is used, it is better to explore the creation of a model within this simulator. The first step in gem5 is to create the "system," an object that defines the simulation environment:

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

#block(breakable: false)[
  === Naive Model <naive-model>
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


  The first model in this simulation uses gem5's unmodified `RiscvMinorCPU`, providing a baseline for evaluating performance and efficiency in embedded ML applications. This model operates without any cache hierarchy, relying solely on DDR3 @RAM for memory operations. It is a very simplistic model, essentially a generic microcontroller that has not been specifically designed for embedded ML. The model is illustrated in @first-model[figure].
]
#block(breakable: false)[
  ==== Executing Inference Tasks On The Model

  ===== High-level architecture

  To execute inference tasks on the model, We use a simple process that partly relies on existing research to speed up development: I used ELF executable files (elfies) compile by a previous research from #cite(<aymone2024riscvtflite>, form: "prose"). We then "flashed" it into my microcontroller model. Elfies are compiled binaries that contain the machine code needed to run specific programs or tasks. The elfies in question here, where MLPerf Tiny benchmarks compiled with @TFLM.

  This high-level architecture is shown in @high-level-arch
  #figure(caption: [High level architecture of the simulation])[
    #image("img/simple-toolchain.png")
  ] <high-level-arch>
]

==== Results

#figure(
  caption: [Simulation Results Of First Naive Model],
  placement: none,
)[
  #table(
    columns: 6,
    table.header(
      [Benchmark],
      [@ISA],
      [CPU Model],
      [Illustrative Figure],
      [Simulation Mode],
      [Latency],
    ),

    [@IC], [@RISCV], [minor], [@model-baremetal], [ES], [2.51~s/inf.],
    [@VWW], [@RISCV], [minor], [@model-baremetal], [ES], [2.13~s/inf.],
  )
] <result-naive>

@result-naive shows the statistics of our first gem5 experiment. Compared to @box-ic and @box-vww[], it immediately reveals a blunt truth: the prototype is painfully slow. The @IC benchmark completes a single inference in 2.51~s, while @VWW needs 2.13 s per inference. Whereas the systems in the MLPerf Tiny database achieve that in less than a second.

These disappointing numbers were, however, entirely anticipated. The simulated core is the unmodified `RiscvMinorCPU` running against plain DDR3, with no cache hierarchy whatsoever. @NN workloads need constant access to data (containing weights and values). Without an L1/L2 cache, every weight or activation must travel to external DDR3, so most of the time is lost waiting on memory.

=== Second Model <second-model>

==== Cache Hierarchy

To address the memory bottleneck revealed by Table 1, I rebuilt the simulation around the reference platform described by #cite(<aymone2024riscvtflite>, form: "author"). The compute core is still a plain `RiscvMinorCPU`, yet the memory side is no longer bare. The second model contains two small on-chip caches: 32 KiB for @IMEM and 32 KiB for @DMEM. Additionally, a unified 256 KiB L2 stands behind them.


==== Results

#figure(
  caption: [Simulation Results Of The Model With Cache],
  placement: none,
)[
  #table(
    columns: 6,
    table.header(
      [Benchmark],
      [@ISA],
      [CPU Model],
      [Illustrative Figure],
      [Simulation Mode],
      [Latency],
    ),

    [@IC], [@RISCV], [minor], [@model-baremetal-better], [ES], [154~ms/inf.],
    [@VWW], [@RISCV], [minor], [@model-baremetal-better], [ES], [139~ms/inf.],
  )
] <result-better>

@result-better now shows latencies of 154~ms per inference for @IC and 139~ms for @VWW. Those values fall inside the central band of the @RISCV box plots drawn from the MLPerf Tiny data in @box-vww and @box-ic[]. In those boxes, the latency averages around the 100~ms order mark. Our simulated numbers sit right in that window, so the cache-enabled model behaves like a typical RISC-V edge board instead of the outlier we saw in @result-naive. This match confirms that adding the two-level cache brought the model in line with real-world observations and removed the extreme memory stall that had pushed the naive run into the second magnitude order.

=== Specialised Kernel

Our next step is not to rewrite the whole CPU model but simply to rebuild the @NN binary with a smarter software stack. The plain build we used so far ignores the @RVV extension, so every dot-product call falls back to slow scalar code.

The @RVV:long extension lets a single instruction process many data elements at once. This is fitting for vector operations such as the repetitive weight $times$ activation loops inside a @NN. Version 1.0 of the spec was only ratified recently @riscv_rvv_1_0, so hardware and compilers are still settling. Because support is still incomplete, most default firmware leaves RVV switched off. Re-building the neural-network binary with a kernel that does target RVV is therefore a simple way to gain speed without touching the underlying microcontroller model.

Fortunately, researchers at the Technical University of Munich have developed the muRISCV-NN kernel @van2024muRISC, which enables the use of the vector extension in @RISCV microcontrollers for embedded AI applications. Released towards the end of last year, this kernel has the potential to significantly enhance my simulations. Instead of patching the simulator, We will re-compile the MLPerf Tiny kernels against muRISCV-NN. With the same microcontroller core but vector-aware kernels, the binary should issue packed dot-product instructions directly, and we can measure how much speed-up comes purely from using the right compiler support. This toolchain is illustrated in @better-toolchain.

#figure(caption: [Toolchain utilising muRISCV-NN])[
  #image("img/better-toolchain.png")
] <better-toolchain>

==== Results

@result-kernel displays the output of MLPerf Tiny benchmark re-defined by #cite(<van2024muRISC>, form: "author"). compiled with their muRISCV-NN kernel. They chose to have 24 consequents inferences.

#figure(
  caption: [Simulation Results Of MLPerf Tiny Benchmarks With A Specialised Kernel And Cache Hierarchy],
  placement: none,
)[
  #table(
    columns: 6,
    table.header(
      [Benchmark],
      [@ISA],
      [CPU Model],
      [Illustrative Figure],
      [Simulation Mode],
      [Latency],
    ),

    [@IC], [@RISCV], [minor], [@model-baremetal-better], [ES], [93~ms/inf.],
    [@VWW], [@RISCV], [minor], [@model-baremetal-better], [ES], [53~ms/inf.],
  )
] <result-kernel>

Using the muRISCV-NN kernel, we obtained results 39% (for @IC) and 62% (for @VWW) faster than with bare-metal execution of MLPerf tiny benchmark. This in the better, faster part of the box plot of @box-vww and @box-ic[]. Because these numbers come from a cycle-accurate simulation, they offer promise rather than proof, yet they still reveal the extra performance headroom a vector-aware kernel can unlock. It is also important to note that none of the reference systems currently listed in the MLPerf Tiny database use muRISCV-NN as it was released end of 2024.