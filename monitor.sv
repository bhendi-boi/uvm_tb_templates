class mon extends uvm_monitor;
    `uvm_component_utils(mon)


    virtual intf vif;
    transaction tr;

    uvm_analysis_port #(transaction) monitor_port;

    function new(string name = "mon", uvm_component parent);
        super.new(name, parent);
        `uvm_info("Monitor", "Constructed monitor", UVM_HIGH)
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        `uvm_info("Monitor", "Build phase monitor", UVM_HIGH)
        monitor_port = new("monitor_port", this);

        if (!(uvm_config_db#(virtual intf)::get(this, "", "vif", vif)))
            `uvm_fatal("Monitor", "Couldn't get vif in monitor!")
    endfunction

    task run_phase(uvm_phase phase);

        super.run_phase(phase);
        `uvm_info("Monitor", "Build phase monitor", UVM_HIGH)
        tr = transaction::type_id::create("item");
        reset_dut();

        forever begin
            sample ();
            `uvm_info("Monitor", "Sampled a sequence", UVM_NONE)
            `uvm_info("Monitor", tr.convert2string(), UVM_NONE)
            monitor_port.write(tr);
        end

    endtask

    task sample ();
        @(posedge vif.start);
        tr.divisor  = vif.divisor;
        tr.dividend = vif.dividend;
        @(posedge vif.ready);
        tr.quotient  = vif.quotient;
        tr.remainder = vif.remainder;
    endtask

    task reset_dut();
        @(posedge vif.clk);
        // @(posedge vif.clk);
    endtask

endclass
