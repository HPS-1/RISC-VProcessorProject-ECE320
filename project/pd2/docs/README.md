# PD2

In this PD, you are required to developed the Fetch stage and Decode stage.
You will also need to develop a testbench.

## Probes

You will need to fill in the `signals.h` in this PD.

## Tests

You will **not** need to pass any predefined tests in this PD.

However, you will need to make sure that your testbench (`test_pd.v`) is compiled **without warnings** and that your output matches **exactly** the format specified in the project deliverable document.

### Warning check

We include a test named `test_pd2` that you can use for testing the instantiation of your modules and it can be invoked with:
```
make run SIMULATOR_NAME=1 TEST=test_pd2 MEM_PATH=/path/to/memory.x
```
However, the test is just for you to check whether your module compiles and will not be used when grading.

## Testbench

You will need to update your own testbench as specified in the project manual.

Make sure that your design will not report any warning during compilation.

Make sure your testbench correctly when running with different `MEM_PATH` supplied to the `make` command.

For verilator, the command would be `make run VERILATOR=1 TEST=test_pd MEM_PATH=/path/to/memory.x`.

For verilator users, you may use `make run VERILATOR=1 TEST=test_pd MEM_PATH=/path/to/memory.x VCD=1` to get a `.vcd` file in `project/pd2/verif/sim/verilator/test_pd/`. 
Please be aware that `$dumpfile` and `$dumpvars` are not supported in verilator installed on ECE Linux Servers and calling them can lead to compilation errors.

## Submission

In `project/pd1/verif/scripts/`, use `make package VERILATOR=1` to package your code and create a `package.verilator.tar.gz`

You will need to upload the `package.verilator.tar.gz` to learn when done.

Note that you must set your simulator properly as the package name will include
information about the simulator you are using.
The tests may fail if you are not providing the proper simulator name.

