class rand_test extends uvm_test;
    `uvm_component_utils(rand_test)

    env environment;
    dummy_seq dummy_sequence;
    // ? STEP 9: Declare sequences

    function new(string name = "rand_test", uvm_component parent);
        super.new(name, parent);
        `uvm_info("Rand Test", "Constructed Rand Test", UVM_HIGH)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Rand Test", "Build phase environment", UVM_HIGH)
        environment = env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);

        // ? instantiate sequences
        dummy_sequence = dummy_seq::type_id::create("dummy_sequence");
        // Set no of transaction a sequence should generate
        //  example syntax
        dummy_sequence.set_no_of_tr(100);

        // ? start them on sequencer
        dummy_sequence.start(environment.act_agent.sequencer);

        // ? add any extra simulation delay

        phase.drop_objection(this);
    endtask

endclass


