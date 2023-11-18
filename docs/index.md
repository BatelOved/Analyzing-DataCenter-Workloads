# Table of Contents
1. [Introduction](./index.html)
2. [Benchmarks](./benchmarks.html)
3. [Analysis](./sysbench_analysis.html)
    1. [Sysbench Analysis](./sysbench_analysis.html)
    2. [Multiload Analysis](./multiload_analysis.html)
    3. [Fleetbench Analysis](./fleetbench_analysis.html)
4. [Conclusions](./conclusions.html)

# 1. Introduction

Analyzing data-center workloads is a crucial task in understanding the performance and efficiency of modern computing infrastructures. Over the years, data-center architectures have evolved from the classical Von Neumann and Turing models to embrace new technologies that push the boundaries of computational capabilities. The relentless progression of Moore’s Law has been a driving force, enabling the continuous advancement of processing power and the development of future architectures such as quantum computing, artificial intelligence (AI), and graphics processing units (GPUs). However, central processing units (CPUs) are significantly impacted by the *memory wall*, which represents a bottleneck in data transfer between computational and memory components. Additionally, the deceleration of Moore's Law compels us to explore inventive methods for enhancing performance.

The increasing popularity of cloud computing has introduced a new dimension to data-center workloads, with multiple cloud providers offering scalable and flexible resources for a wide range of applications. Furthermore, the landscape of data-center hardware has diversified with the emergence of different processor architectures, including those from Intel, ARM, AMD and more. To assess the effectiveness of these architectures and their associated workloads, various performance metrics and benchmarks are employed.

In this work, we delve into the analysis of data-center workloads, examining the current architectures, exploring performance metrics and benchmarks, and considering the impact of cloud providers on data-center operations.

## AWS EC2 Comparison: M5 vs. M6g -
In this work we compared between the M5 and M6g [EC2 instance types](https://aws.amazon.com/ec2/instance-types/).

- <ins>M5 Features:</ins>\
Up to 3.1 GHz Intel Xeon Scalable processor (Skylake 8175M or Cascade Lake 8259CL) with new Intel Advanced Vector Extension (AVX-512) instruction set.\
Memory channels (total): 6\
Supported memory: DDR4-2666/DDR4-2933 (2666/2933 Date Rate (MT/s) accordingly)

- <ins>M6g Features:</ins>\
Custom built AWS Graviton2 Processor with 64-bit Arm Neoverse cores.\
Memory channels (total): 8\
Supported memory: DDR4-3200 (3200 Date Rate (MT/s))

<ins>The maximum theoretical bandwidth is expected to be as follows:</ins>\
DDR4 memory modules transfer data on a bus that is 8 bytes (64 data bits) wide.\
Each DDR4 peak transfer rate calculated as follows: `Date Rate (MT/s) * Bus Width (B/T)`.\
In order to get to the theoretical memory BW the peak transfer rate should also be multiplied by the number of memory channels.\
Hence, the maximum theoretical bandwidth of M6g is 204.8 GB/s, whereas M5 expected to reach 127.9 GB/s and 140.7 GB/s for DDR4-2666 and DDR4-2933 accordingly.

More information about Graviton2 can be found [here](https://pages.awscloud.com/rs/112-TZM-766/images/2020_0501-CMP_Slide-Deck.pdf) and [here](https://github.com/aws/aws-graviton-getting-started).\
And more information about Intel Xeon can be found [here](https://www.cpu-world.com/CPUs/Xeon/Intel-Xeon%208175M.html) and [here](https://www.cpu-world.com/CPUs/Xeon/Intel-Xeon%208259CL.html).

> [Next](./benchmarks.md)

### Contact

`Email:` _bateloved1@gmail.com_