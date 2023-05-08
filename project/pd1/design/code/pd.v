module pd(
  input clock,
  input reset
);

  reg [31:0] imemory_address;
  reg [31:0] imemory_data_in;
  reg imemory_read_write;
  wire [31:0] imemory_data_out;

  imemory imemory_0(
    .clock(clock),
    .address(imemory_address),
    .data_in(imemory_data_in),
    .read_write(imemory_read_write),
    .data_out(imemory_data_out)
  );

  always @(posedge clock) begin
    if (reset) begin
        imemory_address <= 32'h01000000;
    end else begin
        imemory_address <= imemory_address + 4;
    end
  end
endmodule
