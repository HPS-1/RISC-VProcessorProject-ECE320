task check_F;
  input integer idx;
  output reg res;
  output reg[4095:0] msg;
  begin : check_F_func
    reg[31:0]       pc;
    reg[31:0]       insn;
 
    reg[127:0] p;
    p = pattern[idx][`__F_RNG];
    
    pc              = p[`__F_PC];
    insn            = p[`__F_INSN];
    if(
      (^pc !== 1'bx && pc !== dut.core.`F_PC) ||
      (^insn !== 1'bx && insn !== dut.core.`F_INSN) 
    ) begin
      $sformat(msg, "F stage mismatch: expected PC=%x, INSN=%x, got PC=%x, INSN=%x", 
        pc, insn,
        dut.core.`F_PC, dut.core.`F_INSN);
      res = 0;
    end else begin
      res = 1;
    end
  end
endtask
