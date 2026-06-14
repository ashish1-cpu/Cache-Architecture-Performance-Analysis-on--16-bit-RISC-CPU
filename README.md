# Cache-Architecture-Performance-Analysis-on--16-bit-RISC-CPU

A Verilog-based implementation of a **16-bit RISC Processor** integrated with multiple cache architectures for studying memory hierarchy performance. The project compares **Direct Mapped**, **Fully Associative**, and **2-Way Set Associative** caches under different memory access patterns and analyzes their impact on cache performance.

---

## Overview

Modern processors rely heavily on cache memory to reduce the latency of main memory accesses. This project implements a complete memory hierarchy consisting of:

- 16-bit RISC Processor
- Register File
- Instruction Memory
- Main Memory with Configurable Latency
- Direct Mapped Cache
- Fully Associative Cache
- 2-Way Set Associative Cache
- Performance Monitoring Unit

The processor can switch between different cache architectures and evaluate their behavior under multiple workload patterns.

---

## Features

### Processor
- 16-bit RISC CPU
- General Purpose Register File (8 × 16-bit Registers)
- ALU and Control Unit
- Instruction Fetch and Execute Logic
- Memory Access Support

### Cache Architectures
- Direct Mapped Cache
- Fully Associative Cache
- 2-Way Set Associative Cache
- Cache Hit/Miss Detection
- Cache Stall Handling
- Main Memory Latency Modeling

### Performance Monitoring
- Total Memory Accesses
- Cache Hits
- Cache Misses
- Hit Ratio
- Miss Ratio
- Stall Cycles

---

## System Architecture

```text
                 +------------------+
                 | 16-bit RISC CPU  |
                 +---------+--------+
                           |
                           v
                 +------------------+
                 |  Cache System    |
                 |------------------|
                 | Direct Mapped    |
                 | Fully Associative|
                 | 2-Way Set Assoc. |
                 +---------+--------+
                           |
                           v
                 +------------------+
                 |   Main Memory    |
                 +------------------+
```

---

## Cache Access Patterns

The processor evaluates cache performance using four memory access patterns.

### Pattern 0 – Temporal Locality

Repeated access to the same address.

```text
5 5 5 5 5 5 ...
```

Expected Behavior:

- First access → Miss
- Remaining accesses → Hits

---

### Pattern 1 – Spatial Locality

Sequential memory accesses.

```text
0 1 2 3 4 5 ...
```

Used to evaluate how caches respond to consecutive addresses.

---

### Pattern 2 – Conflict Locality

Addresses intentionally chosen to create cache conflicts.

```text
0 8 0 8 0 8 ...
```

Used to compare Direct Mapped and Associative cache performance.

---

### Pattern 3 – Random Access

Pseudo-random memory accesses.

```text
0 13 26 39 52 ...
```

Represents unpredictable memory behavior.

---

# Experimental Results

The following results were obtained using Xilinx Vivado Simulator (XSim).

---

## Pattern 0 – Temporal Locality

Address Sequence:

```text
5 5 5 5 5 5 ...
```

| Cache Type | Accesses | Hits | Misses | Hit Ratio |
|------------|----------|-------|---------|-----------|
| Direct Mapped | 164 | 163 | 1 | 99% |
| Fully Associative | 164 | 163 | 1 | 99% |
| 2-Way Set Associative | 164 | 163 | 1 | 99% |

### Observation

- All cache architectures perform equally well.
- Only the first access misses.
- Demonstrates strong temporal locality.

---

## Pattern 1 – Spatial Locality

Address Sequence:

```text
0 1 2 3 4 5 ...
```

| Cache Type | Accesses | Hits | Misses | Hit Ratio |
|------------|----------|-------|---------|-----------|
| Direct Mapped | 44 | 2 | 42 | 4% |
| Fully Associative | 42 | 0 | 42 | 0% |
| 2-Way Set Associative | 42 | 0 | 42 | 0% |

### Observation

- Current cache implementation uses single-word cache blocks.
- Sequential accesses do not benefit from block prefetching.
- Multi-word cache blocks would improve spatial locality performance.

---

## Pattern 2 – Conflict Locality

Address Sequence:

```text
0 8 0 8 0 8 ...
```

| Cache Type | Accesses | Hits | Misses | Hit Ratio |
|------------|----------|-------|---------|-----------|
| Direct Mapped | 44 | 2 | 42 | 4% |
| Fully Associative | 161 | 159 | 2 | 98% |
| 2-Way Set Associative | 161 | 159 | 2 | 98% |

### Observation

- Direct Mapped cache suffers from conflict misses.
- Fully Associative and 2-Way caches successfully retain both addresses.
- Associativity significantly improves performance.

---

## Pattern 3 – Random Access

Address Sequence:

```text
0 13 26 39 52 ...
```

| Cache Type | Accesses | Hits | Misses | Hit Ratio |
|------------|----------|-------|---------|-----------|
| Direct Mapped | 44 | 2 | 42 | 4% |
| Fully Associative | 42 | 0 | 42 | 0% |
| 2-Way Set Associative | 42 | 0 | 42 | 0% |

### Observation

- Random accesses provide little locality.
- All cache architectures experience mostly misses.
- Demonstrates the limitations of caching for unpredictable workloads.

---

## Performance Summary

| Pattern | Direct Mapped | Fully Associative | 2-Way Set Associative |
|----------|--------------|-------------------|----------------------|
| Temporal Locality | 99% Hit Rate | 99% Hit Rate | 99% Hit Rate |
| Spatial Locality | 4% Hit Rate | 0% Hit Rate | 0% Hit Rate |
| Conflict Locality | 4% Hit Rate | 98% Hit Rate | 98% Hit Rate |
| Random Access | 4% Hit Rate | 0% Hit Rate | 0% Hit Rate |

---

## Key Findings

### Temporal Locality

All cache architectures perform nearly identically because the same memory location is repeatedly accessed.

### Conflict Locality

Direct Mapped cache suffers severe performance degradation due to conflicts, while Fully Associative and 2-Way caches effectively eliminate those misses.

### Spatial Locality

The current implementation uses single-word cache blocks; therefore, sequential accesses do not gain additional cache benefits.

### Random Access

Random memory references reduce cache effectiveness because locality is minimal.

---

## Project Structure

```text
├── Risc_16_bit.v
├── Datapath_Unit.v
├── Control_Unit.v
├── ALU.v
├── ALU_control.v
├── GPRs.v
├── Instruction_Memory.v
├── cache_system.v
├── cache_direct.v
├── cache_fully.v
├── cache_2way.v
├── main_memory.v
├── performance_monitor.v
├── benchmark_generator.v
├── tb_cpu_cache_compare.v
└── README.md
```

---

## Tools Used

- Verilog HDL
- Xilinx Vivado 2025.1
  

---

## Concepts Demonstrated

- Computer Architecture
- Cache Memory Design
- Memory Hierarchy
- Cache Associativity
- Direct Mapped Caches
- Fully Associative Caches
- Set Associative Caches
- Locality of Reference
- FSM Design
- RTL Design
- Hardware Performance Analysis

---

## Future Enhancements

- Multi-word Cache Blocks
- Write-Back Cache Policy
- Write-Through Cache Policy
- Cache Replacement Policies
- AMAT Analysis
- CPI Analysis
- Pipelined Processor
- FPGA Implementation
- RISC-V ISA Support

---

## Conclusion

This project demonstrates the impact of cache organization on processor performance. While all cache architectures perform similarly for temporal locality workloads, higher associativity significantly reduces conflict misses. The results validate the effectiveness of Fully Associative and 2-Way Set Associative caches in improving memory access efficiency compared to Direct Mapped caches.

---

## Author

**Ashish Kumar Das**  & **Aman Anand**

---

## License

This project is intended for educational and research purposes.
