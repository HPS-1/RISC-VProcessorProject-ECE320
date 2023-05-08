# PD1

In this PD, you are required to developed a memory module as specified in the PD1 manual.

## Probes

You need to fill in the path to the following probes in `project/pd1/design/signals.h`:

```
`define F_PC                ???
`define F_INSN              ???
```

- `F_PC` is the 32-bit `address` input port, which acts as the PC for the fetch stage.
- `F_INSN` is the 32-bit `data_out` output port, which acts as the instruction for the fetch stage.

## Macros

We provide a `\`LINE_COUNT` macro that represents the number of lines in the program file.

## Tests

We provide simple tests that test for signal presence and basic timing correctness.

To run these tests, go to `project/pd1/verif/scripts` and use one of the following commands:

```
make run IVERILOG=1 TEST=test_pd
make run VERILATOR=1 TEST=test_pd
```

## Testbench

Apart from the test we provided, you may write your own testbench.

Your testbench will need to be put in a module called `top`.
It should be put in the folder `project/pd1/verif/tests/` such as `project/pd1/verif/tests/test_my_pd.v`.
You may refer to `test_pd.v` and extend from that file.

By creating `test_my_pd.v`, you will be able to run the test in `project/pd1/verif/scripts` using `make run TEST=test_my_pd YOUR_SIM=1`, where `YOUR_SIM` is either `VERILATOR` or `IVERILOG`.

Make sure that your design will not report any warning during compilation.

### Verilator

For verilator users, we provide the `project/pd1/verif/tests/test_pd.cpp` that drives your testbench. 
However, your testbench should not depend on the modification to the `test_pd.cpp` as it will not be packaged for submission.

## Submission

In `project/pd1/verif/scripts/`, use `make package VERILATOR=1` to package your code and create a `package.verilator.tar.gz`

You will need to upload the `package.verilator.tar.gz` to learn when done.

Note that you must set your simulator properly as the package name will include
information about the simulator you are using.
The tests may fail if you are not providing the proper simulator name.

