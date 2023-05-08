module pd0(
  input clock,
  input reset
);
  /* demonstrating the usage of assign_and */
  reg assign_and_x;
  reg assign_and_y;
  wire assign_and_z;
  assign_and assign_and_0 (
    .x(assign_and_x),
    .y(assign_and_y),
    .z(assign_and_z)
  );

  /* Exercise 3.3 module/probes */
  reg arst_and_x;
  reg arst_and_y;
  wire arst_and_z;
  reg arst_areset;
  reg_and_arst arst_and_0 (
    .clock(clock),
    .areset(arst_areset),
    .x(arst_and_x),
    .y(arst_and_y),
    .z(arst_and_z)
  );

  /* Exercise 3.4 module/probes */
  reg rr_and_x;
  reg rr_and_y;
  wire rr_and_z;
  reg_and_reg rr_and_0 (
    .clock(clock),
    .reset(reset),
    .x(rr_and_x),
    .y(rr_and_y),
    .z(rr_and_z)
  );
endmodule
