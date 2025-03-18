def make_d_ff_design():
    raw_d_ff_text = """module d_ff (
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
"""
    file = open("design.sv", "w")
    file.write(raw_d_ff_text)
    file.close()


if __name__ == "__main__":

    # Step 1: update design
    make_d_ff_design()

    # Step 2: update interface

    # Step 3: update seq_item

    # Step 4: update driver

    # Step 5: update monitor

    # Step 6: update scoreboard

    # Step 7: update rand_test

    # Step 8: update testbench
