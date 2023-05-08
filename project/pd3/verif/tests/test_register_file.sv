// DO NOT rely on this file, it will be changed with a fresh one
`include "signals.h"

module top(
  input wire[4:0] addr_rs1,
  input wire[4:0] addr_rs2,
  input wire[4:0] addr_rd,
  input wire write_enable,
  input wire[31:0] data_rd,
  output wire[31:0] data_rs1,
  output wire[31:0] data_rs2
);
  wire clock, reset;
  // logic write_enable;
  // logic [4:0] addr_rs1; 
  // logic [4:0] addr_rs2;
  // logic [4:0] addr_rd;
  // logic [31:0] data_rd;
  // logic[31:0] data_rs1;
  // logic[31:0] data_rs2;
  clockgen clkg(
    .clk(clock),
    .rst(reset)
  );
  register_file rf(
    .clock(clock),
    .addr_rs1(addr_rs1),
    .addr_rs2(addr_rs2),
    .addr_rd(addr_rd),
    .data_rd(data_rd),
    .data_rs1(data_rs1),
    .data_rs2(data_rs2),
    .write_enable(write_enable)
  );

endmodule
