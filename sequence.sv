class pos_seq extends uvm_sequence;
    `uvm_object_utils(pos_seq)

    transaction tr;
    int no_of_tr;

    function new(string name = "pos_seq");
        super.new(name);
        this.set_no_of_tr(1);
        `uvm_info("Pos Seq", "Constructed pos_seq", UVM_HIGH)
    endfunction

    function void set_no_of_tr(int no_of_tr);
        this.no_of_tr = no_of_tr;
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        repeat (no_of_tr) begin
            start_item(tr);
            if (!tr.randomize() with {
                    divisor[31] == 0;
                    dividend[31] == 0;
                })
                `uvm_fatal("Pos Seq", "Randomisation failed")
            finish_item(tr);
        end
    endtask

endclass
class pos_divisor_less_than_dividend_seq extends uvm_sequence;
    `uvm_object_utils(pos_divisor_less_than_dividend_seq)

    transaction tr;
    int no_of_tr;

    function new(string name = "pos_divisor_less_than_dividend_seq");
        super.new(name);
        this.set_no_of_tr(1);
        `uvm_info("Pos DLD Seq",
                  "Constructed pos_divisor_less_than_dividend_seq", UVM_HIGH)
    endfunction

    function void set_no_of_tr(int no_of_tr);
        this.no_of_tr = no_of_tr;
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        repeat (no_of_tr) begin
            start_item(tr);
            if (!tr.randomize() with {
                    divisor < dividend;
                    divisor[31] == 0;
                    dividend[31] == 0;
                })
                `uvm_fatal("Pos DLD Seq", "Randomisation failed")
            finish_item(tr);
        end
    endtask

endclass
class neg_seq extends uvm_sequence;
    `uvm_object_utils(neg_seq)


    transaction tr;
    int no_of_tr;


    function new(string name = "neg_seq");
        super.new(name);
        this.set_no_of_tr(1);
        `uvm_info("Neg Seq", "Constructed neg_seq", UVM_HIGH)
    endfunction

    function void set_no_of_tr(int no_of_tr);
        this.no_of_tr = no_of_tr;
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        repeat (no_of_tr) begin
            start_item(tr);
            if (!tr.randomize() with {
                    divisor[31] == 1;
                    dividend[31] == 1;
                })
                `uvm_fatal("Neg Seq", "Randomisation failed")
            finish_item(tr);
        end
    endtask

endclass
class same_seq extends uvm_sequence;
    `uvm_object_utils(same_seq)


    transaction tr;
    int no_of_tr;


    function new(string name = "same_seq");
        super.new(name);
        this.set_no_of_tr(1);
        `uvm_info("Same Seq", "Constructed same_seq", UVM_HIGH)
    endfunction

    function void set_no_of_tr(int no_of_tr);
        this.no_of_tr = no_of_tr;
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        repeat (no_of_tr) begin
            start_item(tr);
            if (!tr.randomize() with {divisor == dividend;})
                `uvm_fatal("Same Seq", "Randomisation failed")
            finish_item(tr);
        end
    endtask

endclass
