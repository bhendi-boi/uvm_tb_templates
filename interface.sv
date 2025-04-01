interface intf (
    input logic i_clk
);
    logic i_rst;
    logic [31:0] i_dividend;
    logic [31:0] i_divisor;
    logic i_start;
    logic o_ready;
    logic o_quotient;
    logic o_remainder;
endinterface : intf
