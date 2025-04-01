import uvm_pkg::*;


`include "uvm_macros.svh"
`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "rand_test.sv"

module tb ();

    logic clk;

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    intf vif (.clk(clk));

    // ? STEP 10: Declare DUT
    divider_dshift dut (
        .i_clk(vif.clk),
        .i_rst(vif.rst),
        .i_dividend(vif.dividend),
        .i_divisor(vif.divisor),
        .i_start(vif.start),
        .o_ready(vif.ready),
        .o_quotient(vif.quotient),
        .o_remainder(vif.remainder)
    );

    initial begin
        uvm_config_db#(virtual intf)::set(null, "uvm_test_top*", "vif", vif);
        // ? Change uvm_test name here or you can do this from command line as well
        run_test("rand_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
