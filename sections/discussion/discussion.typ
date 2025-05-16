#import "../../lib/template/versatile-apa/lib.typ": *
#import "../../lib/package/glossy/lib.typ": *
#show: init-glossary.with(yaml("../../glossary/gls.yaml"), term-links: true)

== Discussion

=== Comparative Analysis of Researched and Experimental Results

The three simulation rounds depicted from @result-naive to @result-kernel[] trace a clear arc: from a bare-bones microcontroller that stalls on every memory access, to a cache-equipped platform, and finally to a vector-aware build whose software utilises RVV extension. The naive prototype (@result-naive) is slower than any registered device in the MLPerf Tiny database. Indeed, the @IC benchmark stalls at 2.51~s/inference per inference and the @VWW benchmark at 2.13~s/inference. That is two full orders of magnitude slower than anything reported in MLPerf Tiny and therefore of interest only as a pedagogical lower bound. The numbers simply expose the cost of walking across DDR3 for every weight and activation, and does not allow us to conclude anything about utilising @RISCV (or comparing it to any other @ISA) at its full advantage.

Introducing a modest two-level cache hierarchy (@result-better) slashes latency to 154~ms/inference for @IC purposes and 139~ms/inference for @VWW applications. These values land inside the interquartile range of the RISC-V boxes in @box-ic and @box-vww[], and are in the same order of magnitude as the median latencies (\~10²~ms/inference) that dominate the current MLPerf Tiny database. In other words, once a conventional memory hierarchy is in place, the gem5 model behaves like a typical edge board rather than an outlier.

A second lift comes from recompiling the benchmark with muRISCV-NN, thereby allowing the compiler to compute dot-product with specialised and faster instructions. The specialised build (@result-kernel) pushes latency down to 93~ms/inference (@IC) and 53~ms/inference (@VWW), settling in above the median of the @RISCV distributions and even competing against the 75th percentile of ARM submissions for @VWW. However, none of the boards listed by MLPerf Tiny has yet shipped with muRISCV-NN, so the simulation points to spare performance that current hardware could reach by changing only the software stack.

#block(breakable: false)[
  #figure(
    caption: [Box Plot of Latency In Inference Application of MobileNetV1in (@VWW) MLPerf Inference Tiny *Compared To Our Simulated Results* (Lower Is Better) ],
    placement: none,
  )[
    #image("img/boxplot-vww-better.svg", width: 95%)
  ] <bloxplot-vww-better>

  #figure(
    caption: [
      Box Plot of Box Plot of Latency In Inference Application of ResNet-V1 (@IC) in MLPerf Inference Tiny *Compared To Our Simulated Results* (Lower Is Better)
    ],
    placement: none,
  )[
    #image("img/boxplot-ic-better.svg", width: 95%)
  ] <bloxplot-ic-better>
]

Taken together, the three runs confirm two levers. First, keeping weights and activations close to the core is essential; second, packing multiply-accumulates with RVV lifts throughput again. Because the final latencies lie on top of the real-world curves, the gem5 setup looks trustworthy, but it remains a model.

=== Recommendations For Going Further

We will be served best by moving beyond gem5 and exercising the same software stack on real silicon. A board that matches the simulated core, cache sizes, and clock rate allows us to replay the MLPerf Tiny workloads under the current muRISCV-NN build. When its latency and energy are measured, we will see whether the cycle counts reported in simulation hold up in practice.

With that baseline in place, we will be positioned to refine the model and close the gap still further. Empirical figures for DRAM bandwidth, cache-miss penalties, and branch costs can be folded back into the configuration, after which newer kernel releases, tighter loop scheduling, or a longer vector length can be explored in simulation. The most promising tweaks will then be migrated to the board for a fresh round of validation. Each pass through this loop is expected to shorten the path from idea to tested result.

Comparing specialised hardware to a traditional CPU under identical conditions is much harder. The gem5 simulator targets instruction-set processors and cannot describe data-flow fabrics or fine-grained clocking, so an @FPGA or @ASIC must be evaluated with different tools that rely on other timing models. Aligning the assumptions across simulators is painful, which is why having the FPGA or ASIC on the bench beside the CPU board would give a cleaner, fairer comparison.

We must also remain aware that embedded @AI is a moving target. Fresh convolution kernels, compression methods, and even entirely new workloads continue to enter the MLPerf Tiny database, shifting the definition of competitive performance. By keeping both the tool-chain and the model flexible, we will be ready to absorb emerging techniques as they appear in the literature.

Power was left outside the present scope, so the current figures offer hope rather than proof. A hardware prototype that re-uses the same tool-chain therefore stands as the natural next step to secure agreement between simulation and reality.

== Conclusion

This study set out to measure how well a small RISC-V core can serve modern edge-@ML workloads and to see whether a cycle-accurate model can predict the behaviour recorded in the MLPerf Tiny database. Three successive simulations were carried out. The first, a bare configuration with no cache, proved two orders of magnitude slower than any published system. The second introduced a modest L1/L2 cache hierarchy and landed squarely in the middle of the latency band observed for real RISC-V devices. The third re-compiled the same benchmarks with the muRISCV-NN kernel, reached 93~ms per inference for @IC:long and 53~ms for @VWW:long. This aligned with the faster half of all entries, including many ARM boards. In every case the simulated trend mirrored the empirical data, so the model captured the main performance levers.

From these results we draw three findings. First, local memory is indispensable; moving weights and activations away from external DRAM collapses latency. Second, vector-length parallelism opens another tier of efficiency once an adequate cache is present. Third, when both factors are addressed, a low-power @RISCV platform can equal or surpass established solutions in its class, suggesting that open-source hardware is a competitive path for embedded inference.

Looking forward, the next priority is to replay the same software stack on real silicon that mirrors the simulated parameters, measure latency and energy, and fold the numbers back into the model for another optimisation pass. Iterating between hardware and simulation, while staying alert to new kernels and workloads entering MLPerf Tiny, will keep the platform at the leading edge of embedded @ML.