class base_seq extends uvm_sequence;
    `uvm_object_utils(base_seq)

    transaction tr;
    int no_of_tr;

    constraint divisor_lesser_than_dividend {
        this.tr.divisor < this.tr.dividend;
    }

    function new(string name = "base_seq");
        super.new(name);
        this.set_no_of_tr(1);
        `uvm_info("Base Seq", "Constructed base_seq", UVM_HIGH)
    endfunction

    function void set_no_of_tr(int no_of_tr);
        this.no_of_tr = no_of_tr;
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        repeat (no_of_tr) begin
            start_item(tr);
            if (!tr.randomize()) `uvm_fatal("Sequence", "Randomisation failed")
            finish_item(tr);
        end
    endtask

endclass


class div_by_mul_2_seq extends base_seq;
    `uvm_object_utils(div_by_mul_2_seq)

    constraint divisor_is_multiple_of_2 {this.tr.divisor % 2 == 0;}

endclass


class div_by_mul_2_pos_seq extends div_by_mul_2_seq;
    `uvm_object_utils(div_by_mul_2_pos_seq)

    constraint divisor_is_positive {this.tr.divisor[31] == 0;}
endclass
