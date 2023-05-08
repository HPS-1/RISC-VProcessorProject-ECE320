module memory_logic(
  input [6:0] m_opcode,
  input [2:0] m_funct3,
  input [31:0] m_data_rs2,
  input [31:0] m_alu_res,
  output reg [31:0] m_address,
  output reg [31:0] m_data_in,
  output reg m_rw,
  output reg [1:0] m_size_encoded
);

    initial begin
        m_address = 32'h00000000;
        m_data_in = 32'h00000000;
        m_rw= 1'b0;
        m_size_encoded = 2'b00;
    end

    always @(*) begin

        case (m_opcode) //decide result based on opcode
            7'b0000011: begin //LB-LHU
                m_address = m_alu_res;
                m_data_in = 32'h00000000;
                m_rw= 1'b0;
                m_size_encoded = 2'b00; //we don't actually care about the size for loads, just leave that part for writeback stage
            end
            
            7'b0100011: begin // SB-SW
                m_address = m_alu_res;
                m_data_in = m_data_rs2;
                m_rw= 1'b1;
                if ((m_funct3 == 3'b000) || (m_funct3 == 3'b100)) begin
                    //byte load
                    m_size_encoded = 2'b00;
                end else if ((m_funct3 == 3'b001) || (m_funct3 == 3'b101)) begin
                    //half-word load
                    m_size_encoded = 2'b01;
                end else if (m_funct3 == 3'b010) begin
                    //word load
                    m_size_encoded = 2'b10;
                end else begin
                    //error occurred, set size to 3 to trigger error code in dmemory.v
                    m_size_encoded = 2'b11;
                end
            end

            default: begin
                m_address = 32'h00000000;
                m_data_in = 32'h00000000;
                m_rw= 1'b0;
                m_size_encoded = 2'b00;//set the output to zero for memory-irrelevant insns
            end
        endcase
    end
endmodule
