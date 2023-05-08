/**
* Exercise 3.4
* you can change the code below freely
  * */
module reg_and_reg(
  input wire clock,
  input wire reset,
  input wire x,
  input wire y,
  output reg z
);

  reg reg_x;
  reg reg_y;

  always @(posedge clock) begin
    if (reset) begin
        reg_x <= 0;
        reg_y <= 0;
        z <= 0;
    end else begin
        reg_x <= x;
        reg_y <= y;
        z <= reg_x & reg_y;
    end
  end
endmodule
