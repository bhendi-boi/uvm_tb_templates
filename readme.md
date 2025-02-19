# UVM Testbench template

## Overview

- This is a generic uvm testbench env intended to be used as a starting point for your next verification project.
- This project assumes you are going to use two agents, one active and one passive.
- Coverage is not included as of now.

## How to use

- Clone this repo using this command
  ```bash
  git clone -b passive-agent-with-io --single-branch https://github.com/bhendi-boi/uvm_tb_templates.git
  ```
- Open the cloned directory in your editor of choice.
- Follow the steps laid down below to customise the testbench for your project needs.
- After you are done with these steps, simulate the testbench with `UVM_VERBOSITY` set to `UVM_HIGH`.
- You should be able to see constructed message from all the uvm components.

## How to use the included `io_port` script.

- Download dependencies (Is dependent on pandas for now. Working on making the script run without pandas)
  ```
  pip install -r requirements.txt
  ```
- Run the script
  #### Windows
  ```
  python io_port.py
  ```
  #### Linux
  ```
  python3 io_port.py
  ```
- This script can populate [interface](interface.sv) and [seq_item](seq_item.sv) classes with io ports information. So if you are using this script, you can skip the first two steps.
- You can hit enter to consider the default value while using this script.
- #### Some Caveats
  This script is designed to work only with files that come out of the box i.e., if you change [interface](interface.sv) or [seq_item](seq_item.sv) before running the script, the script might not work properly.

### Steps

1. Define your interface signals in [interface.sv](interface.sv).
2. Declare interface signals, constraints and `do_print` function in [seq_item](seq_item.sv).
3. Add constraints or remove constraints required in [sequence.sv](sequence.sv).
4. [Optional] Change the [sequencer.sv](sequencer.sv) if required.
5. Fill the `drive` task in [driver.sv](driver.sv).
6. Fill the `sample` task in [monitor.sv](monitor.sv).
7. Fill the `compare` method in [scoreboard.sv](scoreboard.sv). If compare method has to consume some time, refactor it into a task.
8. [Optional] If you've changed analysis port name in scoreboard or monitor, update the same in [env.sv](env.sv) as well.
9. Declare sequences, instantiate them and start them on sequencer in [rand_test.sv](rand_test.sv).
10. Instantiate a dut instance and change the test name if required in [testbench.sv](testbench.sv).
