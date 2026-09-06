# 8-bit Processor Design and RTL Verification using Verilog HDL

## Overview

This project implements a modular **8-bit processor architecture** using Verilog HDL. The design integrates fundamental processor components including an Arithmetic Logic Unit (ALU), register file, control unit, processing unit, program counter, instruction memory, CPU core, and top-level CPU system.

The processor supports arithmetic, logical, and shift operations and executes a predefined sequence of instructions stored in instruction memory.

The project was developed and verified using **Verilog HDL, Intel Quartus Prime, and ModelSim**.

---

## Key Features

* 8-bit data path
* 8 general-purpose registers
* 3-bit opcode-based instruction decoding
* Arithmetic operations
* Logical operations
* Unary NOT operation
* Left and right shift operations
* Carry, overflow, and zero status flags
* Program counter for sequential instruction execution
* 16-bit instruction memory
* External register loading for simulation and initialization
* Modular RTL architecture
* Module-level and system-level verification testbenches


# Architecture Modules

## 1. Arithmetic Logic Unit

**File:** `alu_8bit.v`

The 8-bit ALU performs arithmetic, logical, and shift operations on two 8-bit operands.

### Supported Operations

| Opcode | Operation   | Description |
| ------ | ----------- | ----------- |
| `000`  | ADD         | A + B       |
| `001`  | SUB         | A - B       |
| `010`  | AND         | A & B       |
| `011`  | OR          | A | B       |
| `100`  | XOR         | A ^ B       |
| `101`  | NOT         | ~A          |
| `110`  | SHIFT LEFT  | A << 1      |
| `111`  | SHIFT RIGHT | A >> 1      |

### Status Flags

The ALU generates:

* **Carry**
* **Overflow**
* **Zero**

The carry flag is generated during addition and shift operations. The overflow flag is calculated for signed addition and subtraction. The zero flag is asserted when the ALU result is `8'b00000000`.

---

## 2. Register File

**File:** `register_file.v`

The processor contains:

* **8 registers**
* Each register is **8 bits wide**
* 3-bit register addressing
* Two asynchronous read ports
* One synchronous write port

### Register Structure

```text
R0
R1
R2
R3
R4
R5
R6
R7
```

Each register stores an 8-bit value.

### Write Operation

Data is written into the selected register on the positive edge of the clock when `write_enable` is asserted.

### Read Operation

Two registers can be read simultaneously using:

* `read_address_a`
* `read_address_b`

---

## 3. Control Unit

**File:** `control_unit.v`

The control unit decodes the 3-bit opcode and generates:

* ALU operation control signals
* Register write enable signal

For each supported instruction, the control unit maps the opcode to the corresponding ALU operation and enables register write-back.

---

## 4. Processing Unit

**File:** `processing_unit.v`

The processing unit integrates:

* Register file
* 8-bit ALU


## 5. CPU Core

**File:** `cpu_core.v`

The CPU core integrates:

* Control unit
* Processing unit
* Register write-back logic

The CPU core supports two operating modes:

### External Register Loading

Registers can be initialized externally using:

```text
load_enable
load_address
load_data
```

This feature is primarily used for simulation and testing.

### Normal CPU Operation

During normal operation:

1. The opcode is decoded by the control unit.
2. Source registers are read.
3. The ALU performs the requested operation.
4. The result is written back into the destination register.

---

## 6. Program Counter

**File:** `program_counter.v`

The program counter is an 8-bit sequential counter.

### Operation

```text
Reset → PC = 0
Clock Edge → PC = PC + 1
```

The program counter sequentially accesses instructions from instruction memory.

---

## 7. Instruction Memory

**File:** `instruction_memory.v`

The processor uses a 16-bit instruction memory.

The instruction memory contains a predefined demonstration program that performs multiple operations.

The current instruction sequence includes:

```text
PC 0 → ADD
PC 1 → ADD
PC 2 → SUB
PC 3 → AND
PC 4 → OR
PC 5 → NOT
PC 6 → SHIFT LEFT
PC 7 → SHIFT RIGHT
```

The processor executes these instructions sequentially using the program counter.

---

## 8. CPU System

**File:** `cpu_system.v`

The `cpu_system` module is the top-level integration module.

It connects:

```text
Program Counter
      │
      ▼
Instruction Memory
      │
      ▼
Instruction Decoder
      │
      ▼
CPU Core
      │
      ▼
Result and Status Flags
```

The instruction is decoded as:

```text
Instruction[15:13] → Opcode
Instruction[12:10] → Destination Register
Instruction[9:7]   → Source Register A
Instruction[6:4]   → Source Register B
```

---

# Instruction Execution Example

The test program begins by loading:

```text
R1 = 10
R2 = 5
```

The predefined program then performs operations including:

### Instruction 1

```text
R3 = R1 + R2
R3 = 10 + 5
R3 = 15
```

### Instruction 2

```text
R4 = R3 + R2
R4 = 15 + 5
R4 = 20
```

### Instruction 3

```text
R5 = R4 - R1
R5 = 20 - 10
R5 = 10
```

The program continues with logical and shift operations.

---

# Verification

The project includes dedicated Verilog testbenches for individual modules and system-level verification.

## Testbenches Included

```text
alu_8bit_tb.v
register_file_tb.v
control_unit_tb.v
processing_unit_tb.v
program_counter_tb.v
instruction_memory_tb.v
cpu_core_tb.v
cpu_system_tb.v
```

### ALU Verification

The ALU testbench verifies:

* Addition
* Subtraction
* AND
* OR
* XOR
* NOT
* Shift left
* Shift right
* Carry flag
* Overflow flag
* Zero flag

The testbench compares generated outputs against expected results and displays PASS or FAIL messages.

---

## Processing Unit Verification

The processing unit testbench verifies:

* Register write operation
* Register read operation
* ALU integration
* Arithmetic operations
* Logical operations

---

## CPU System Verification

The system-level testbench verifies sequential program execution through the instruction memory.

The test sequence checks expected results for:

```text
ADD
ADD with write-back
SUB
AND
OR
NOT
SHIFT LEFT
SHIFT RIGHT
```

The testbench monitors:

* Program counter
* Current instruction
* ALU result
* Carry
* Overflow
* Zero flag

---

# Tools Used

### Hardware Description Language

* Verilog HDL

### Design and Compilation

* Intel Quartus Prime

### Simulation and Verification

* ModelSim


# How to Run the Project

## Using ModelSim

1. Compile all Verilog source files.
2. Compile the required testbench.
3. Start the simulation.
4. Observe the waveform and simulation output.
5. Verify the expected results.

Example simulation target:

```text
cpu_system_tb
```

This testbench demonstrates sequential execution of the predefined instruction program.

---

## Using Quartus Prime

1. Open the Quartus project file.
2. Add the Verilog source files if required.
3. Set the appropriate top-level entity.
4. Compile the design.
5. Review compilation and synthesis results.

---

# Key Learning Outcomes

Through this project, I gained practical experience in:

* RTL design using Verilog HDL
* Modular digital system design
* Processor datapath design
* Register file implementation
* ALU design
* Control logic design
* Program counter implementation
* Instruction decoding
* Instruction memory design
* Register write-back
* Testbench development
* RTL simulation and verification
* Debugging digital logic designs using ModelSim
* FPGA-oriented compilation using Quartus Prime

---

# Future Improvements

Possible extensions to the processor include:

* Conditional branch instructions
* Jump instructions
* Load and store instructions
* Immediate operands
* Expanded instruction set
* Separate instruction decoder module
* General-purpose data memory
* Memory-mapped I/O
* Pipeline architecture
* FPGA hardware implementation
* Automated self-checking system-level verification

---

# Project Status

**Completed RTL Design and Simulation Verification**

The current implementation demonstrates a functional modular 8-bit processor architecture with a predefined instruction sequence and dedicated testbenches for module-level and system-level verification.

---

## Author

**P Bhavitha**

B.Tech – Electronics and Communication Engineering
PDPM IIITDM Jabalpur
