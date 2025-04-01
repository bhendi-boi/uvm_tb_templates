class rand_test extends uvm_test;
    `uvm_component_utils(rand_test)

    env environment;
    pos_seq s0;
    neg_seq s1;
    pos_divisor_less_than_dividend_seq s2;
    same_seq s3;

    function new(string name = "rand_test", uvm_component parent);
        super.new(name, parent);
        `uvm_info("Rand Test", "Constructed Rand Test", UVM_HIGH)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Rand Test", "Build phase Rand Test", UVM_HIGH)
        environment = env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);

        // ? instantiate sequences
        s0 = pos_seq::type_id::create("pos_seq");
        s1 = neg_seq::type_id::create("neg_seq");
        s2 = pos_divisor_less_than_dividend_seq::type_id::create("pos_dld_seq");
        s3 = same_seq::type_id::create("same_seq");

        s0.set_no_of_tr(10000);
        s1.set_no_of_tr(10000);
        s2.set_no_of_tr(10000);
        s3.set_no_of_tr(10);

        s0.start(environment.agent.sequencer);
        s1.start(environment.agent.sequencer);
        s2.start(environment.agent.sequencer);
        s3.start(environment.agent.sequencer);

        #100;

        phase.drop_objection(this);
    endtask

endclass


