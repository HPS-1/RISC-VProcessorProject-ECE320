// Verilator testbench
#include <iostream>
#include <verilated.h>
#ifdef VCD
#include "verilated_vcd_c.h"
#define mkstring(x) #x
#define mkstring2(x) mkstring(x)
#define VCD_FILE_STR mkstring2(VCD_FILE)
#endif
#include "Vtop.h"
#include "svdpi.h"
#include "Vtop__Dpi.h"
#define assertm(exp, msg) { \
  if(!(exp)) {                \
    std::cerr << "[ERROR] " << msg << std::endl; \
    assert(exp);                \
  }                           \
}

extern void toggleClock();

Vtop *top;
vluint64_t main_time;
double sc_time_stamp () {     // Called by $time in Verilog
  return main_time;           // converts to double, to match
}

void nextCycle() {
  toggleClock();
  top->eval();
  toggleClock();
  top->eval();
}

void test_initial_values() {
  for(int i = 0; i < 32; i++) {
    top->addr_rs1 = i;
    top->eval();
    if(i == 2) {
      assertm(top->data_rs1 == MEM_DEPTH + 0x01000000, 
          "x" << i << " should be initialized to `MEM_DEPTH + 32'h01000000");
    } else {
      assertm(top->data_rs1 == 0, 
          "x" << i << " should be initialized to 0");
    }
  }
}

void test_write() {
  for(int i = 0; i < 32; i++) {
    top->write_enable = 1;
    top->addr_rd = i;
    top->data_rd = i + 1;
    nextCycle();
    top->addr_rs1 = i;
    top->eval();
    if(i == 0) {
      assertm(top->data_rs1 == 0, "x0 should be 0 after being written " << i + 1 << ".");
    } else {
      assertm(top->data_rs1 == i + 1, "x" << i << " should be " << i + 1 << " after being written " << i + 1 << ".");
    }
  }
}

void test_read() {
  top->addr_rs1 = 3;
  top->eval();
  assertm(top->data_rs1 == 0, "read on port 1 (addr_rs1, data_rs1) should complete within the same cycle.");
  top->addr_rs1 = 2;
  top->eval();
  assertm(top->data_rs1 == MEM_DEPTH + 0x01000000, "read on port 1 (addr_rs1, data_rs1) should complete within the same cycle.");

  top->addr_rs2 = 3;
  top->eval();
  assertm(top->data_rs2 == 0, "read on port 2 (addr_rs2, data_rs2) should complete within the same cycle.");
  top->addr_rs2 = 2;
  top->eval();
  assertm(top->data_rs2 == MEM_DEPTH + 0x01000000, "read on port 2 (addr_rs2, data_rs2) should complete within the same cycle.");
}
void test_no_forwarding() {
  top->addr_rs1 = 3;
  top->addr_rs2 = 3;
  top->write_enable = 1;
  top->addr_rd = 3;
  top->data_rd = 42;
  top->eval();
  assertm(top->data_rs1 != 42, "register file should not forward.");
  assertm(top->data_rs2 != 42, "register file should not forward.");

}

void test_sensitivity_list() {
  top->addr_rs2 = 3;
  top->write_enable = 1;
  top->data_rd = 43;
  top->addr_rd = 3;
  nextCycle();
  assertm(top->data_rs2 == 43, "sensitivity list should include register array.");
  top->data_rd = 44;
  nextCycle();
  assertm(top->data_rs2 == 44, "sensitivity list should include register array.");
}

int main(int argc, char** argv) {
  Verilated::commandArgs(argc, argv);   // Remember args
  top = new Vtop;
  svSetScope(svGetScopeFromName("TOP.top.clkg"));

  top->eval();
  top->write_enable = 0;
  top->data_rd = 0;
  top->addr_rd = 0;

  test_initial_values();
  test_read();
  test_write();
  test_no_forwarding();
  test_sensitivity_list();

  std::cout << "[INFO] Test passed" << std::endl;

  top->final();
  delete top;
  return 0;
}
