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


    initial begin
        vif.clk = 0;
        forever #10 vif.clk = ~vif.clk;
    end

    intf vif ();

    // ? STEP 10: Declare DUT
    d_ff dut (
        .clk(vif.clk),
        .reset_n(vif.reset_n),
        .d_in(vif.d_in),
        .q_out(vif.q_out)
    );

    initial begin
        uvm_config_db#(virtual intf)::set(null, "uvm_test_top", "vif", vif);
        // ? Change uvm_test name here or you can do this from command line as well
        run_test("rand_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
