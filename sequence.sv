class dummy_seq extends uvm_sequence;
    `uvm_object_utils(dummy_seq)

    transaction tr;
    int no_of_tr;

    function new(string name = "dummy_sequence");
        super.new(name);
        `uvm_info("Dummy sequence", "Constructed dummy_seq", UVM_HIGH)
    endfunction

    // using a setter funciton to set no_of_tr dynamically from uvm_test. Can be replaced uvm_config_db as well.
    function void set_no_of_tr(int no_of_tr);
        this.no_of_tr = no_of_tr;
    endfunction

    task body();
        tr = transaction::type_id::create("tr");

        // ? STEP 3: Add constraints here

        repeat (no_of_tr) begin
            start_item(tr);
            if (!tr.randomize());
            finish_item(tr);
        end
    endtask

endclass
