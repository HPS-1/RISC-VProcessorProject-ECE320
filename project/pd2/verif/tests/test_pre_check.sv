// DO NOT rely on this file, it will be changed with a fresh one
`include "signals.h"

module top(
  input wire reset,
  input wire clock,
  output wire[31:0] F_PC,
  output wire[31:0] F_INSN,
  output wire[31:0] D_PC
);
design_wrapper dut(
  .clock(clock),
  .reset(reset)
);
assign F_PC = dut.core.`F_PC;
assign F_INSN = dut.core.`F_INSN;
assign D_PC = dut.core.`D_PC;

endmodule
