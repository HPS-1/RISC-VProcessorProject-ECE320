module writeback_logic(
  input [6:0] w_opcode,
  input [31:0] alu_res,
  input [31:0] mem_data,
  input [31:0] w_pc,
  input [2:0] w_funct3,
  output reg w_enable,
  output reg [31:0] w_data
);

initial begin
    w_enable = 1'b0;
    w_data = 32'h00000000;
end

always @(*) begin
    case (w_opcode) //decide result based on opcode
        7'b0110111, //LUI
        7'b0010111, //AUIPC
        7'b0010011, // I-type
        7'b0110011: begin // R-type
            w_enable = 1;
            w_data = alu_res;
        end

        7'b1101111, //JAL
        7'b1100111: begin //JALR
            w_enable = 1;
            w_data = w_pc + 4;
        end

        7'b1100011: begin //BEQ-BGEU
            w_enable = 0;
            w_data = 0;
        end

        7'b0000011: begin // Load instructions
            w_enable = 1;
            //process read date from memory!
            if (w_funct3 == 3'b000) begin
                //byte load
                w_data = {{24{mem_data[7]}}, mem_data[7:0]};
            end else if (w_funct3 == 3'b001) begin
                //half load
                w_data = {{16{mem_data[15]}}, mem_data[15:0]};
            end else if (w_funct3 == 3'b010) begin
                //word load
                w_data = mem_data[31:0];
            end else if (w_funct3 == 3'b100) begin
                //U-byte load
                w_data = {{24{1'b0}}, mem_data[7:0]};
            end else if (w_funct3 == 3'b101) begin
                //U-half load
                w_data = {{16{1'b0}}, mem_data[15:0]};
            end else begin
                //error occurred, set w_data to 0!
                w_data = 32'h00000000;
            end
        end

        7'b0100011: begin // Store instructions
            w_enable = 0;
            w_data = 0;
        end

        default: begin
            w_enable = 0; // Don't write anything for unknown instruction type
            w_data = 0;
        end
    endcase
end
endmodule
