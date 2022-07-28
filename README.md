# MIPS Processor
This is a MIPS processor created for the purpose of learning how to create processors from the RTL level up to assembly. 

Features:
- 8-bit Arithmetic Logic Unit
- 2kb RAM
- 4kb Instruction Memory
- 4 general use registers
- Assembly compiler

# How to use
This was designed for the Xilinx Zynq-7000 SoC, and inside the repository is a Vivado project that can be used to generate the bitstream needed for the FPGA.

There is also sample assembly files written in a modified MIPS assembly language along with a compiler that can be used to generate the .coe files needed for initialization of the instruction memory.

After modifying the assembly code, the zassemble executable can be used to generate the .coe file for the memory initialization, which is done inside the Re-customize IP window for the instruction memory.
