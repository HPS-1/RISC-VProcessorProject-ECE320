module register_file(
    input clock,
    input [4:0] addr_rs1, 
    input [4:0] addr_rs2, 
    input [4:0] addr_rd,
    input [31:0] data_rd, 
    input write_enable,

    output reg [31:0] data_rs1,
    output reg [31:0] data_rs2
);

reg [31:0] register_data [31:0];

initial begin
    integer i;
    for (i = 0; i < 32; i = i + 1) begin
        register_data[i] = 0;
    end

    // Stack pointer initialization
    register_data[2] = 32'h01000000 + `MEM_DEPTH;
end

// Write on clock
always @(posedge clock) begin
    if (write_enable) begin
        register_data[addr_rd] <= data_rd;
    end
end

// Read whenever
always @(*) begin
    // Always return a zero value if addr_rs* == 0 is requested

    if (addr_rs1 == 0)
        data_rs1 = 0;
    else
        data_rs1 = register_data[addr_rs1];

    if (addr_rs2 == 0)
        data_rs2 = 0;
    else
        data_rs2 = register_data[addr_rs2];
end

endmodule
