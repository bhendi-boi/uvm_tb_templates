class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)

    rand bit rst;
    rand bit [31:0] divisor, dividend;
    bit [31:0] quotient, remainder;



    function new(string name = "transaction");
        super.new(name);
    endfunction

    // write do_copy function
    // write do_compare function
    // write convert2string function

    function string convert2string();
        string msg = $sformatf("Reset = %0d\n", this.rst);
        msg = {
            msg,
            $sformatf(
                "Divisor = %0d, Dividend = %0d\n",
                int'(this.divisor),
                int'(this.dividend)
            )
        };

        msg = {
            msg,
            $sformatf(
                "Quotient = %0d, Remainder = %0d\n",
                int'(this.quotient),
                int'(this.remainder)
            )
        };
        return msg;
    endfunction

endclass
