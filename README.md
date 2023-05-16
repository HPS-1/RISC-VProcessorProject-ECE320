# Note from Peisen

The final product of this project, which is a 5-stage pipelined RISC-V processor written in verilog, is located in the folder PD5. Most interested files are placed here: https://github.com/HPS-1/RISC-VProcessorProject-ECE320/tree/main/project/pd5/design/code, with self-explaining comments.

Here's a bit further introduction about each file:

**alu.v**: The arithmetic-logic unit.

**branch_comp.v**: The branch-comparing unit used for branching instructions.

**decoder.v**: The decoder that decodes the fetched instructions.

**dmemory.v**: The memory used to store data. (Data memory)

**imemory.v**: The memory where instructions are stored and fetched. (Instruction memory)

**memory_logic.v**: This file represents the memory stage logics of the processor, in charge of read from / write to the data memory.

**pd.v**: The top level design file of the whole processor, which wires the low-level components up and drives them using the provided clock signal.

**register_file.v**: The register file. There're 32 registers in total.

**writeback_logic.v**: This file represents the writeback stage logics of the processor, which is responsible for writing back to the register file.

Also thanks to Kevin Brennan's contribution to this project as my teammate.

/////////////////////////////////////////////////

# Course Project

- [PD0](project/pd0/docs/README.md)
- [PD1](project/pd1/docs/README.md)
- [PD2](project/pd2/docs/README.md)
- [PD3](project/pd3/docs/README.md)
- [PD4](project/pd4/docs/README.md)
- [PD5](project/pd5/docs/README.md)


# Credits

The project structure heavily borrows the AWS EC2 FPGA HDK structure, [see here](https://github.com/aws/aws-fpga).

