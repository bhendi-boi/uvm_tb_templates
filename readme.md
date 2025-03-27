# D Flipflip DPI C Model Example

## Overview

- This is a generic uvm testbench for a D Flip Flop created using the template from [main](https://github.com/bhendi-boi/uvm_tb_template/dpi-c-model-with-io) branch.
- This project assumes you are going to use only one agent i.e; the agent is active.
- This template assumes that you would like to use a C model to predict your `dut`'s response.
- Coverage is not included as of now.

## How to use

- Clone this particular branch using this command

  git clone -b d_ff-dpi-example --single-branch https://github.com/bhendi-boi/uvm_tb_templates.git

- Open the cloned directory in your editor of choice.
- After you are done with these steps, simulate the testbench with `UVM_VERBOSITY` set to `UVM_HIGH`.
- You should be able to see constructed message from all the uvm components.
