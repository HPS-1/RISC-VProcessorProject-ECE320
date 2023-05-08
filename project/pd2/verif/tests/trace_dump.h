/** Trace format per cycle
* [F] pc_address content
* [D] pc_address opcode rd rs1 rs2 funct3 funct7 imm shamt
* [R] rs1 rs2 rd data_rs1 data_rs2 we
* [E] pc_address alu_result branch_taken
* [M] pc_address memory_address read_write memory_size memory_data
* [W] pc_address write rd datard
*/
integer __trace_fd;
initial begin
  __trace_fd = $fopen(`TRACE_FILE, "w");
end
always @(negedge clock) begin
  if(reset == 0) begin
  // F stage trace dump
  $fwrite(__trace_fd, "[F] %x %x\n",
    dut.core.`F_PC,
    dut.core.`F_INSN);
  $fflush(__trace_fd);
  
  // D stage trace dump
  $fwrite(__trace_fd, "[D] %x %x %x %x %x %x %x %x %x\n",
    dut.core.`D_PC,
    dut.core.`D_OPCODE,
    dut.core.`D_RD,
    dut.core.`D_RS1,
    dut.core.`D_RS2,
    dut.core.`D_FUNCT3,
    dut.core.`D_FUNCT7,
    dut.core.`D_IMM,
    dut.core.`D_SHAMT);
  $fflush(__trace_fd);
  
  end
end