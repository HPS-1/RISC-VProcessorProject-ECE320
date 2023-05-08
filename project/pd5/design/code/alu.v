module alu(
  input [6:0] e_opcode,
  input [2:0] e_funct3,
  input [6:0] e_funct7,
  input [4:0] e_shamt,
  input [31:0] e_pc,
  input [31:0] e_imm,
  input [31:0] r_data_rs1,
  input [31:0] r_data_rs2,
  output reg [31:0] e_alu_res
);

    initial begin
      e_alu_res = 32'h00000000;
    end

    always @(*) begin

        case (e_opcode) //decide result based on opcode
            7'b0110111: begin //LUI
                e_alu_res = e_imm;
            end

            7'b0010111: begin //AUIPC
                e_alu_res = e_pc + e_imm;
            end

            7'b1101111: begin //JAL
                e_alu_res = e_pc + e_imm;
            end

            7'b1100111: begin //JALR
                e_alu_res = r_data_rs1 + e_imm;
                e_alu_res[0] = 1'b0;
            end

            7'b1100011: begin //BEQ-BGEU
                e_alu_res = e_pc + e_imm;
            end

            7'b0000011,
            7'b0100011: begin //LB-LHU + SB-SW
                e_alu_res = r_data_rs1 + e_imm;
            end

            7'b0010011: begin
                case (e_funct3)
                    3'b000: begin //ADDI
                        e_alu_res = r_data_rs1 + e_imm;
                    end

                    3'b010: begin //SLTI
                        e_alu_res = ($signed(r_data_rs1) < $signed(e_imm)) ? 32'h00000001 : 32'h00000000;
                    end

                    3'b011: begin //SLTIU
                        e_alu_res = (r_data_rs1 < e_imm) ? 32'h00000001 : 32'h00000000;
                    end

                    3'b100: begin //XORI
                        e_alu_res = r_data_rs1 ^ e_imm;
                    end

                    3'b110: begin //ORI
                        e_alu_res = r_data_rs1 | e_imm;
                    end

                    3'b111: begin //ANDI
                        e_alu_res = r_data_rs1 & e_imm;
                    end

                    3'b001: begin //SLLI
                        e_alu_res = r_data_rs1 << e_shamt;
                    end

                    3'b101: begin //SRLI + SRAI
                        case (e_funct7)
                            7'b0000000: begin //SRLI
                                e_alu_res = r_data_rs1 >> e_shamt;
                            end

                            7'b0100000: begin //SRAI
                                e_alu_res = $signed(r_data_rs1) >>> e_shamt;
                            end

                            default: begin
                                e_alu_res = 32'h00000000; //set the output to zero for unknown inst type
                            end
                        endcase
                    end

                    default: begin
                        e_alu_res = 32'h00000000; //set the output to zero for unknown inst type
                    end
                endcase
            end

            ////////////////////////////////////////////////////////////////////////////////////////////////////

            7'b0110011: begin
                case (e_funct3)
                    3'b000: begin //ADD + SUB
                        case (e_funct7)
                            7'b0000000: begin //ADD
                                e_alu_res = r_data_rs1 + r_data_rs2;
                            end

                            7'b0100000: begin //SUB
                                e_alu_res = r_data_rs1 - r_data_rs2;
                            end

                            default: begin
                                e_alu_res = 32'h00000000; //set the output to zero for unknown inst type
                            end
                        endcase
                    end

                    3'b001: begin //SLL
                        e_alu_res = r_data_rs1 << (r_data_rs2[4:0]);
                    end

                    3'b010: begin //SLT
                        e_alu_res = ($signed(r_data_rs1) < $signed(r_data_rs2)) ? 32'h00000001 : 32'h00000000;
                    end

                    3'b011: begin //SLTU
                        e_alu_res = (r_data_rs1 < r_data_rs2) ? 32'h00000001 : 32'h00000000;
                    end

                    3'b100: begin //XOR
                        e_alu_res = r_data_rs1 ^ r_data_rs2;
                    end

                    3'b101: begin //SRL + SRA
                        case (e_funct7)
                            7'b0000000: begin //SRL
                                e_alu_res = r_data_rs1 >> (r_data_rs2[4:0]);
                            end

                            7'b0100000: begin //SRA
                                e_alu_res = $signed(r_data_rs1) >>> (r_data_rs2[4:0]);
                            end

                            default: begin
                                e_alu_res = 32'h00000000; //set the output to zero for unknown inst type
                            end
                        endcase
                    end

                    3'b110: begin //OR
                        e_alu_res = r_data_rs1 | r_data_rs2;
                    end

                    3'b111: begin //AND
                        e_alu_res = r_data_rs1 & r_data_rs2;
                    end

                    default: begin
                        e_alu_res = 32'h00000000; //set the output to zero for unknown inst type
                    end
                endcase
            end

            default: begin
                e_alu_res = 32'h00000000; //set the output to zero for unknown inst type
            end
        endcase
    end
endmodule
