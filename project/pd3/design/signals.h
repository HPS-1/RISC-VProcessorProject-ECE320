
/* Your Code Below! Enable the following define's 
 * and replace ??? with actual wires */
// ----- signals -----
// You will also need to define PC properly
`define F_PC                f_pc
`define F_INSN              f_inst

`define D_PC                d_pc
`define D_OPCODE            d_opcode
`define D_RD                d_rd
`define D_RS1               d_rs1
`define D_RS2               d_rs2
`define D_FUNCT3            d_funct3
`define D_FUNCT7            d_funct7
`define D_IMM               d_imm
`define D_SHAMT             d_shamt

`define R_WRITE_ENABLE      r_write_enable
`define R_WRITE_DESTINATION r_addr_rd
`define R_WRITE_DATA        r_data_rd
`define R_READ_RS1          d_rs1
`define R_READ_RS2          d_rs2
`define R_READ_RS1_DATA     d_data_rs1
`define R_READ_RS2_DATA     d_data_rs2

`define E_PC                e_pc
`define E_ALU_RES           e_alu_res
`define E_BR_TAKEN          e_br_taken

// ----- signals -----

// ----- design -----
`define TOP_MODULE                 pd
// ----- design -----
