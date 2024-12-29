class rand_test extends uvm_test;
    `uvm_component_utils(rand_test)

    // ? STEP 10: Declare sequences

    function new(string name = "rand_test", uvm_component parent);
        super.new(name, parent);
        `uvm_info("Rand Test", "Constructed Rand Test", UVM_HIGH)
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);

        // ? instantiate sequences

        // Set no of transaction a sequence should generate
        //  example syntax
        // dummy_sequence.set_no_of_tr(1024);

        // ? start them on sequencer

        // ? add any extra simulation delay

        phase.drop_objection(this);
    endtask

endclass


