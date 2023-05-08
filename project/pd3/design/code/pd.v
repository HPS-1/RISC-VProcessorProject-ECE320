module pd(
    input clock,
    input reset
);

//below are registers for fetch stage
reg [31:0] f_pc;
reg [31:0] f_inst;

//below are registers for decode stage
reg [31:0] d_inst;
reg [31:0] d_pc;
reg [6:0] d_opcode;
reg [4:0] d_rd;
reg [4:0] d_rs1;
reg [4:0] d_rs2;
reg [2:0] d_funct3;
reg [6:0] d_funct7;
reg [31:0] d_imm;
reg [4:0] d_shamt;

//reg [4:0] r_addr_rs1;
//reg [4:0] r_addr_rs2;
reg [4:0] r_addr_rd;
reg [31:0] r_data_rd;
reg r_write_enable;
reg [31:0] d_data_rs1;
reg [31:0] d_data_rs2;

//below are registers for execute stage
reg [31:0] e_pc;
reg e_br_taken;

reg [6:0] e_opcode;
reg [4:0] e_rd;
//reg [4:0] e_rs1;
//reg [4:0] e_rs2;
reg [2:0] e_funct3;
reg [6:0] e_funct7;
reg [31:0] e_imm;
reg [4:0] e_shamt;
reg [31:0] e_data_rs1;
reg [31:0] e_data_rs2;
reg [31:0] e_alu_res;

//reg BrEq;
//reg BrLT;
reg BrUn;

//below are registers for memory stage
//reserved for pd4
//below are registers for write-back stage
//reserved for pd4

//below are module(s) for fetch stage
imemory imemory_0(
    .clock(clock),
    .address(f_pc),
    .data_in('x),       // Don't care about the in-data if it's specified read-only below
    .read_write(0),     // Hard-wire to read only for instructions
    .data_out(f_inst)
);

//below are module(s) for decode stage
decoder decoder_0(
    //.f_inst(f_inst),
    .f_inst(d_inst),
    .d_opcode(d_opcode),
    .d_rd(d_rd),
    .d_rs1(d_rs1),
    .d_rs2(d_rs2),
    .d_funct3(d_funct3),
    .d_funct7(d_funct7),
    .d_imm(d_imm),
    .d_shamt(d_shamt)
);

register_file register_file_0(
    .clock(clock),
    .addr_rs1(d_rs1),
    .addr_rs2(d_rs2),
    .addr_rd(r_addr_rd),
    .data_rd(r_data_rd),
    .write_enable(r_write_enable),
    .data_rs1(d_data_rs1),
    .data_rs2(d_data_rs2)
);

//below are module(s) for execute stage
branch_comp branch_comp_0(
    .in1(e_data_rs1),
    .in2(e_data_rs2),
    .e_opcode(e_opcode),
    .e_funct3(e_funct3),
    .is_unsigned(BrUn),
    .e_br_taken(e_br_taken)
    //.is_eq(BrEq),
    //.is_lt(BrLT)
);

alu alu_0(
  .e_opcode(e_opcode),
  .e_funct3(e_funct3),
  .e_funct7(e_funct7),
  .e_shamt(e_shamt),
  .e_pc(e_pc),
  .e_imm(e_imm),
  .r_data_rs1(e_data_rs1),
  .r_data_rs2(e_data_rs2),
  .e_alu_res(e_alu_res)
);

//below are module(s) for memory stage
//reserved for pd4

//below are module(s) for write-back stage
//reserved for pd4

always @(posedge clock) begin
    if (reset) begin
        f_pc <= 32'h01000000;
    end else begin
        f_pc <= f_pc + 4;
    end

    d_inst <= f_inst;
    d_pc <= f_pc;

    e_pc <= d_pc;
    e_opcode <= d_opcode;
    e_rd <= d_rd;
    e_funct3 <= d_funct3;
    e_funct7 <= d_funct7;
    e_imm <= d_imm;
    e_shamt <= d_shamt;
    e_data_rs1 <= d_data_rs1;
    e_data_rs2 <= d_data_rs2;

    // BLTU or BGEU
    // We don't care if this is actually a branch instruction
    // The branch comparator can output garbage if it wants
    BrUn <= d_inst[14:12] == 'h6 || d_inst[14:12] == 'h7;
end

endmodule
