class agnt extends uvm_agent;
    `uvm_component_utils(agnt)

    drv  driver;
    mon  monitor;
    seqr sequencer;
    cov  coverage;

    function new(string name = "agnt", uvm_component parent);
        super.new(name, parent);
        `uvm_info("Agent", "Constructed agent", UVM_HIGH)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Agent", "Build phase agent", UVM_HIGH)
        driver = drv::type_id::create("driver", this);
        // it is very unlikely that you'll extend a sequencer
        sequencer = new("sequencer", this);
        monitor = mon::type_id::create("monitor", this);
        coverage = cov::type_id::create("coverage", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("Agent", "Connect phase agent", UVM_HIGH)
        driver.seq_item_port.connect(sequencer.seq_item_export);
        monitor.monitor_port.connect(coverage.coverage_port);
    endfunction

endclass
