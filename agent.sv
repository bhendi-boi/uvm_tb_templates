class agnt extends uvm_agent;
    `uvm_component_utils(agnt)

    // agent defaults to active
    uvm_active_passive_enum is_active = UVM_ACTIVE;

    drv driver;
    mon monitor;
    seqr sequencer;

    function new(string name = "agnt", uvm_component parent);
        super.new(name, parent);
        `uvm_info("Agent", "Constructed agent", UVM_HIGH)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Agent", "Build phase agent", UVM_HIGH)

        if (this.is_active == UVM_ACTIVE) begin
            driver = drv::type_id::create("driver", this);
            // it is very unlikely that you'll extend a sequencer
            sequencer = new("sequencer", this);
        end

        monitor = mon::type_id::create("monitor", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("Agent", "Connect phase agent", UVM_HIGH)

        if (this.is_active == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
    endfunction

    function void set_active_or_passive(int active_or_passive);
        this.is_active = active_or_passive ? UVM_ACTIVE : UVM_PASSIVE;
    endfunction

endclass
