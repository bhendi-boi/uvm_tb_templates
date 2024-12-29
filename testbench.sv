import uvm_pkg::*;


`include "uvm_macros.svh"
`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "coverage.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "rand_test.sv"

module tb ();

    logic clk;

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    intf vif ();

    // ? STEP 10: Declare DUT
    // dut_design_name dut ();

    initial begin
        uvm_config_db#(virtual intf)::set(null, "*", "vif", vif);
        // ? Change uvm_test name here or you can do this from command line as well
        run_test("rand_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
