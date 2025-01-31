class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)

    // ? STEP 2
    // declare DUT inputs as rand here
    rand logic reset_n;
    rand logic d_in;


    // declare DUT output as logic here
    logic q_out;

    function new(string name = "transaction");
        super.new(name);
    endfunction

    // write do_copy function
    // write do_compare function
    // write convert2string function

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        // Print a transaction's fields here
        printer.print_field_int("Reset", reset_n, 1, UVM_HEX);
        printer.print_field_int("D input", d_in, 1, UVM_HEX);
        printer.print_field_int("Q output", q_out, 1, UVM_HEX);
    endfunction

endclass
