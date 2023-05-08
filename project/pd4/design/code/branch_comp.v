module branch_comp(
    input [31:0] in1,
    input [31:0] in2,
    input [6:0] e_opcode,
    input [2:0] e_funct3,
    input is_unsigned,

    output reg e_br_taken
    //output is_eq,
    //output is_lt
);

reg is_eq;
reg is_lt;

initial begin
    is_eq = 1'b0;
    is_lt = 1'b0;
end

always @(*) begin
    is_eq = in1 == in2;

    if (is_unsigned) begin
        is_lt = in1 < in2;
    end else begin
        is_lt = $signed(in1) < $signed(in2);
    end

    case (e_opcode) //decide result based on opcode
            7'b1100011: begin //branch inst
                case (e_funct3)
                    3'b000: begin //BEQ
                        e_br_taken = is_eq;
                    end

                    3'b001: begin //BNE
                        e_br_taken = !is_eq;
                    end

                    3'b110,
                    3'b100: begin //BLT + BLTU
                        e_br_taken = is_lt;
                    end

                    3'b111,
                    3'b101: begin //BGE + BGEU
                        e_br_taken = !is_lt;
                    end

                    default: begin
                        e_br_taken = 1'b0; //set the output to zero if inst is unknown
                    end
                endcase
            end

            default: begin
                e_br_taken = 1'b0; //set the output to zero if not a branch inst
            end
    endcase

end

endmodule
