
module d_ff (
    input  logic clk,
    input  logic reset_n,
    input  logic d_in,
    output logic q_out
);
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q_out <= 1'b0;
        end else begin
            q_out <= d_in;
        end
    end

endmodule
