module non_blocking
(
  input clock,
  input [3:0] in,
  output [3:0] out
);

// Internal registers
reg [3:0] x,y,z;
always @(posedge clock) begin
  x <= in;
  y <= x + 1;
  z <= y + 1;
  $display("[blk] time:%t, in: %h, x: %h, y:%h, z:%h",$time, in, x,y,z);
end
assign out = z;

always @(x) begin
  $display("time: %t, -- x:%h, clock: %h", $time, x, clock);
end
endmodule // non_blocking

