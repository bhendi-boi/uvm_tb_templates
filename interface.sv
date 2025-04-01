interface intf (
    input logic clk
);
    logic rst;
    logic [31:0] dividend;
    logic [31:0] divisor;
    logic start;
    logic ready;
    logic [31:0] quotient;
    logic [31:0] remainder;
endinterface : intf
