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

    intf vif (.i_clk(clk));

    // ? STEP 10: Declare DUT
    divider_dshift dut (
        .i_clk(intf.clk),
        .i_rst(intf.rst),
        .i_dividend(intf.dividend),
        .i_divisor(intf.divisor),
        .i_start(intf.start),
        .o_ready(intf.ready),
        .o_quotient(intf.quotient),
        .o_remainder(intf.remainder)
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
