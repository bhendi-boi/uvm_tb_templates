class scb extends uvm_scoreboard;
    `uvm_component_utils(scb)

    // ? STEP 8: Change the analysis imp port if you want
    uvm_analysis_imp #(transaction, scb) scoreboard_port;
    transaction trs[$];
    transaction tr;
    int i = 0;

    // Declare variables which may be needed to make comparison

    function new(string name = "scb", uvm_component parent);
        super.new(name, parent);
        `uvm_info("Scoreboard", "Constructed scoreboard", UVM_HIGH)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Scoreboard", "Build phase scoreboard", UVM_HIGH)
        // change the analysis imp port name here as well
        scoreboard_port = new("scoreboard_port", this);
    endfunction

    function void compare(transaction tr);
        // ? Fill this method with your comparison logic
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("Scoreboard", "Run phase scoreboard", UVM_HIGH)
        tr = transaction::type_id::create("item", this);
        forever begin
            wait (!(trs.size() == 0));
            tr = trs.pop_front();
            i++;
            tr.print();
            compare(tr);
            `uvm_info("Tr count", $sformatf("Tr count = %d", i), UVM_NONE)
        end
    endtask

    function void write(transaction tr);
        trs.push_back(tr);
        `uvm_info("Scoreboard", "Write method Scoreboard", UVM_HIGH)
    endfunction

endclass

