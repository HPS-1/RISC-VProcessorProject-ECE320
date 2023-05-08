module top;
reg [3:0] in;
reg clock;
wire [3:0] out;

always begin
  #5 clock = ~clock;
end
non_blocking nb( .clock(clock), .in(in),.out(out) );
initial begin
  $dumpfile("non-blocking.vcd");
  $dumpvars(0,nb);
  #0 clock = 1;
  #0 in = 3'h1;
  #100 $finish;
end
endmodule // dut
