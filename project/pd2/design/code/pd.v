module pd(
  input clock,
  input reset
);

    reg [31:0] f_pc;
    reg [31:0] f_inst;
    //reg [31:0] d_pc;
    reg [6:0] d_opcode;
    reg [4:0] d_rd;
    reg [4:0] d_rs1;
    reg [4:0] d_rs2;
    reg [2:0] d_funct3;
    reg [6:0] d_funct7;
    reg [31:0] d_imm;
    reg [4:0] d_shamt;

    imemory imemory_0(
        .clock(clock),
        .address(f_pc),
        .data_in('x),       // Don't care about the in-data if it's specified read-only below
        .read_write(0),     // Hard-wire to read only for instructions
        .data_out(f_inst)
    );

    decoder decoder_0(
        .f_inst(f_inst),
        .d_opcode(d_opcode),
        .d_rd(d_rd),
        .d_rs1(d_rs1),
        .d_rs2(d_rs2),
        .d_funct3(d_funct3),
        .d_funct7(d_funct7),
        .d_imm(d_imm),
        .d_shamt(d_shamt)
    );

    always @(posedge clock) begin
        if (reset) begin
            f_pc <= 32'h01000000;
        end else begin
            f_pc <= f_pc + 4;
        end

        // For future labs
        //d_pc <= f_pc;
    end
    // Instruction decoding
    // R-type: 0110011
    // I-type: 00x0011
    // S-type: 0100011
    // B-type: 1100011
endmodule
