module imemory(
  input  clock,
  input  [31:0] address,
  input  [31:0] data_in,
  input  read_write,
  output reg [31:0] data_out
);

reg [7:0] mem [`MEM_DEPTH-1:0];
reg [31:0] temp_mem [`LINE_COUNT-1:0];

integer line_num, current_byte_num;
initial begin
    // Read the data file into our temporary array
    $readmemh(`MEM_PATH, temp_mem);

    // Each 32 bit word line
    for (line_num = 0; line_num < `LINE_COUNT; line_num = line_num + 1) begin
        // ... has 4 bytes
        current_byte_num = line_num * 4;
        mem[current_byte_num] = temp_mem[line_num][7:0];
        mem[current_byte_num + 1] = temp_mem[line_num][15:8];
        mem[current_byte_num + 2] = temp_mem[line_num][23:16];
        mem[current_byte_num + 3] = temp_mem[line_num][31:24];

        //$display("%h%h%h%h:%h", mem [current_byte_num + 3], mem [current_byte_num + 2],mem [current_byte_num + 1], mem [current_byte_num],
        //    temp_mem [line_num]); //For debugging only
    end
end

always @(*) begin
    data_out[7:0] = mem[address];
    data_out[15:8] = mem[address + 1];
    data_out[23:16] = mem[address + 2];
    data_out[31:24] = mem[address + 3];
end

always @ (posedge clock) begin
    // Write the value to the stored memory
    if (read_write) begin
        mem[address] <= data_in [7:0];
        mem[address + 1] <= data_in [15:8];
        mem[address + 2] <= data_in [23:16];
        mem[address + 3] <= data_in [31:24];
    end
end

endmodule
