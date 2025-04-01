class div_by_mul_2_seq extends uvm_sequence;
    `uvm_object_utils(div_by_mul_2_seq)

    transaction tr;
    int no_of_tr;

    constraint divisor_lesser_than_dividend {
        this.tr.divisor < this.tr.dividend;
    }

    constraint divisor_is_multiple_of_2 {this.tr.divisor % 2 == 0;}

    function new(string name = "div_by_mul_2_seq");
        super.new(name);
        this.set_no_of_tr(1);
        `uvm_info("Div By Multiple of 2", "Constructed div_by_mul_2_seq",
                  UVM_HIGH)
    endfunction

    function void set_no_of_tr(int no_of_tr);
        this.no_of_tr = no_of_tr;
    endfunction

    task body();
        tr = transaction::type_id::create("tr");


        repeat (no_of_tr) begin
            start_item(tr);
            if (!tr.randomize())
                `uvm_fatal("Dummy Sequence", "Randomisation failed")
            finish_item(tr);
        end
    endtask

endclass


class div_by_mul_2_pos_seq extends div_by_mul_2_seq;
    `uvm_object_utils(div_by_mul_2_pos_seq)

    constraint divisor_is_positive {this.tr.divisor[31] == 0;}
endclass
