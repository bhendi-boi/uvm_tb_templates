class cov extends uvm_scoreboard;
    `uvm_component_utils(cov)


    transaction tr;
    uvm_analysis_imp #(transaction, cov) coverage_port;

    covergroup grp;
        option.per_instance = 1;
        option.auto_bin_max = 16;

        divisor: coverpoint tr.divisor;
        dividend: coverpoint tr.dividend;
        quotient: coverpoint tr.quotient {
            bins zero = {0}; bins positive[15] = {[0 : $]};
        }
        remainder: coverpoint tr.remainder {
            bins zero = {0}; bins positive[15] = {[0 : $]};
        }

    endgroup


    function new(string name = "cov", uvm_component parent);
        super.new(name, parent);
        grp = new();
        `uvm_info("Coverage", "Constructor Coverage", UVM_MEDIUM)
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr = transaction::type_id::create("transaction");
        coverage_port = new("coverage_port", this);
    endfunction

    function void write(transaction t);
        tr = t;
        grp.sample();
    endfunction


endclass
