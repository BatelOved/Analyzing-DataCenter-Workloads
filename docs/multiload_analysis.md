## 3.2. Multiload Analysis

Multichase - a pointer chaser benchmark.\
Multiload - a superset of multichase which runs latency, memory bandwidth, and loaded-latency.

### AWS Configurations -

- `Intel machine (32 VCPU):` m5.8xlarge
- `ARM machine (32 VCPU):` m6g.8xlarge
- `Machine disk size (gp2):` 8 GB
- `AWS region:` us-west-1b
- `Run iterations:` 5

### Analysis -

Analyzing the latency and bandwidth effects of the machines we employed is crucial for gaining a deeper insight into the impediments that hinder the enhancement of their performance.

#### Multichase: Memory Read Latency by Byte/Thread and Architecture

In this benchmark the Multichase "simple" test is running, in which a single thread with variable amount of bytes compute, and measured is the average of ChaseNS (Multichase nano seconds <=> latency) out of 5 iterations.

![Alt text](utils/multiload/multichase/memory_read_latency_by_byte_per_thread.png "Memory Read Latency by Byte per Thread and Architecture")

#### Multiload: Memory BW by Load Threads and Architecture

The results are for Byte/Thread = 1,073,741,824.

- **memcpy-libc:**
1:1 rd:wr ratio - glibc memcpy()

![Alt text](utils/multiload/memory_bandwidth/memcpy-libc.png "Memory BW by Load Threads and Architecture")

- **memset-libc:**
0:1 rd:wr ratio - glibc memset() non-zero data

![Alt text](utils/multiload/memory_bandwidth/memset-libc.png "Memory BW by Load Threads and Architecture")

- **memsetz-libc:**
0:1 rd:wr ratio - glibc memset() zero data

![Alt text](utils/multiload/memory_bandwidth/memsetz-libc.png "Memory BW by Load Threads and Architecture")

- **stream-sum:**
1:0 rd:wr ratio - lmbench stream sum instructions: s+=a[i] (actual binary depends on compiler & -O level)

![Alt text](utils/multiload/memory_bandwidth/stream-sum.png "Memory BW by Load Threads and Architecture")

- **stream-triad:**
2:1 rd:wr ratio - lmbench stream triad instructions: a[i]=b[i]+(scalar*c[i])

![Alt text](utils/multiload/memory_bandwidth/stream-triad.png "Memory BW by Load Threads and Architecture")


> [Back](./stream_analysis.md)

> [Next](./sysbench_analysis.md)
