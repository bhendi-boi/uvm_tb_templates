class drv extends uvm_driver #(transaction);
    `uvm_component_utils(drv)

    virtual intf vif;
    transaction  tr;

    function new(string name = "driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info("Driver", "Constructed driver", UVM_HIGH)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Driver", "Build phase driver", UVM_HIGH)

        if (!(uvm_config_db#(virtual intf)::get(this, "", "vif", vif))) begin
            `uvm_fatal("Driver", "Driver couldn't get vif")
        end
    endfunction

    task run_phase(uvm_phase phase);

        super.run_phase(phase);
        `uvm_info("Driver", "Run phase driver", UVM_HIGH)
        tr = transaction::type_id::create("tr");
        reset_dut();

        forever begin
            seq_item_port.get_next_item(tr);
            drive(tr);
            `uvm_info("Driver", "Drove a transaction", UVM_NONE)
            `uvm_info("Driver", tr.convert2string(), UVM_NONE)
            seq_item_port.item_done();
        end
    endtask

    task drive(transaction tr);
        @(posedge vif.clk);
        vif.start <= 1;
        vif.divisor <= tr.divisor;
        vif.dividend <= tr.dividend;
        @(posedge vif.ready);
        vif.start <= 0;
    endtask

    task reset_dut();
        @(posedge vif.clk);
        vif.rst <= 0;
        @(posedge vif.clk);
        vif.rst <= 1;
    endtask

endclass
