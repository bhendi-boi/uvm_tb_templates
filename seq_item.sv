class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)

    // ? STEP 2
    // declare DUT inputs as rand here


    // declare DUT output as logic here

    function new(string name = "transaction");
        super.new(name);
    endfunction

    // write do_copy function
    // write do_compare function
    // write convert2string function

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        // Print a transaction's fields here
    endfunction

endclass
