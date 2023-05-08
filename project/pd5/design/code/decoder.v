module decoder(
  input  [31:0] f_inst,
  output reg [6:0] d_opcode,
  output reg [4:0] d_rd,
  output reg [4:0] d_rs1,
  output reg [4:0] d_rs2,
  output reg [2:0] d_funct3,
  output reg [6:0] d_funct7,
  output reg [31:0] d_imm,
  output reg [4:0] d_shamt
);

initial begin
  //f_inst = 32'h00000000; I think we don't need to initialize input?
  d_opcode = 7'b0000000;
  d_rd = 5'b00000;
  d_rs1 = 5'b00000;
  d_rs2 = 5'b00000;
  d_funct3 = 3'b000;
  d_funct7 = 7'b0000000;
  d_imm = 32'h00000000;
  d_shamt = 5'b00000;
end

always @(*) begin

        case (f_inst[6:0]) //opcode

            7'b0110011: begin
                d_opcode = f_inst[6:0];
                d_rd = f_inst[11:7];
                d_rs1 = f_inst[19:15];
                d_rs2 = f_inst[24:20];
                d_funct3 = f_inst[14:12];
                d_funct7 = f_inst[31:25];
                d_imm = 0;
                d_shamt = 5'b00000;
            end

            // 0010011 opcode may have shamt field, so we need to distinguish here
            7'b0010011: begin
                case (f_inst[14:12])
                    //shamt
                    3'b101,
                    3'b001: begin
                        d_opcode = f_inst[6:0];
                        d_rd = f_inst[11:7];
                        d_rs1 = f_inst[19:15];
                        d_rs2 = 5'b00000;
                        d_funct3 = f_inst[14:12];
                        d_funct7 = f_inst[31:25];
                        d_imm = 0;
                        d_shamt = f_inst[24:20];
                    end

                    //no shamt
                    default: begin
                        d_opcode = f_inst[6:0];
                        d_rd = f_inst[11:7];
                        d_rs1 = f_inst[19:15];
                        d_rs2 = 5'b00000;
                        d_funct3 = f_inst[14:12];
                        d_funct7 = 7'b0000000;
                        d_imm = {{20{f_inst[31]}}, f_inst[31:20]};
                        d_shamt = 5'b00000;
                    end
                endcase
            end

            7'b0100011: begin
                d_opcode = f_inst[6:0];
                d_rd = 5'b00000;
                d_rs1 = f_inst[19:15];
                d_rs2 = f_inst[24:20];
                d_funct3 = f_inst[14:12];
                d_funct7 = 7'b0000000;
                d_imm = {{20{f_inst[31]}}, f_inst[31:25], f_inst[11:7]};
                d_shamt = 5'b00000;
            end

            7'b0000011: begin
                d_opcode = f_inst[6:0];
                d_rd = f_inst[11:7];
                d_rs1 = f_inst[19:15];
                d_rs2 = 5'b00000;
                d_funct3 = f_inst[14:12];
                d_funct7 = 7'b0000000;
                d_imm = {{20{f_inst[31]}}, f_inst[31:20]};
                d_shamt = 5'b00000;
            end

            7'b1100011: begin
                d_opcode = f_inst[6:0];
                d_rd = 5'b00000;
                d_rs1 = f_inst[19:15];
                d_rs2 = f_inst[24:20];
                d_funct3 = f_inst[14:12];
                d_funct7 = 7'b0000000;
                d_imm = { {19{f_inst[31]}}, f_inst[31], f_inst[7], f_inst[30:25], f_inst[11:8], 1'b0};
                //I fixed here: should have a 0 at the end, and such one bit less of replication at the beginning as mentioned in lecture
                d_shamt = 5'b00000;
            end

            7'b1100111: begin
                d_opcode = f_inst[6:0];
                d_rd = f_inst[11:7];
                d_rs1 = f_inst[19:15];
                d_rs2 = 5'b00000;
                d_funct3 = f_inst[14:12];
                d_funct7 = 7'b0000000;
                d_imm = {{20{f_inst[31]}}, f_inst[31:20]};
                d_shamt = 5'b00000;
            end

            7'b1101111: begin
                d_opcode = f_inst[6:0];
                d_rd = f_inst[11:7];
                d_rs1 = 5'b00000;
                d_rs2 = 5'b00000;
                d_funct3 = 3'b000;
                d_funct7 = 7'b0000000;
                d_imm = {{11{f_inst[31]}}, f_inst[31], f_inst[19:12], f_inst[20], f_inst[30:21], 1'b0};//also need 1'b0 here
                d_shamt = 5'b00000;
            end

            // TODO: Look into spec, do we really zero-extend at the end?
            // FRED: I think so. Someone asked in @88 on piazza but the answers are a bit unclear
            7'b0010111,
            7'b0110111: begin
                d_opcode = f_inst[6:0];
                d_rd = f_inst[11:7];
                d_rs1 = 5'b00000;
                d_rs2 = 5'b00000;
                d_funct3 = 3'b000;
                d_funct7 = 7'b0000000;
                d_imm = {f_inst[31:12], 12'b000000000000};
                d_shamt = 5'b00000;
            end

            //ECALL here: unsure if this is correct, maybe just $finish
            // Don't finish, we want our pipeline to run through and we
            // don't need an exit condition.
            7'b1110011: begin
                //d_opcode = f_inst[6:0];
                //d_rd = f_inst[11:7];
                //d_rs1 = f_inst[19:15];
                //d_rs2 = 5'b00000;
                //d_funct3 = f_inst[14:12];
                //d_funct7 = 7'b0000000;
                //d_imm = {{20{f_inst[31]}}, f_inst[31:20]};
                //d_shamt = 5'b00000;
                // $finish;
            end

            //above we have dealed with all the opcodes given on p7 of the lab manual (except the red ones)
            //for now we just use below to deal with unvalid ones
            default: begin
                d_opcode = 0; // Invalid
                //$display("Unexpected opcode %b", f_inst[6:0]);
                //$finish;
            end
        endcase
    end
endmodule
