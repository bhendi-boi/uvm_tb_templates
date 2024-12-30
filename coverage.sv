class cvg extends uvm_subscriber #(transaction);
    `uvm_component_utils(cvg)

    uvm_analysis_imp #(transaction, cvg) cvg_port;

    transaction item;
    covergroup func;
    // ? Step 11: Wrtie coverpoints
    endgroup

    function new(string name = "cvg", uvm_component parent);
        super.new(name, parent);
        func = new();
        `uvm_info("cvg", "Constructor cvg", UVM_MEDIUM)
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item = transaction::type_id::create("tr");
        cvg_port = new("cvg_port", this);
    endfunction

    function void write(transaction t);
        item = t;
        func.sample();
    endfunction

endclass
