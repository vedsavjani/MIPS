module flopenr(
    input clk, reset,
    input ena,
    input [31:0] d,
    output reg [31:0] q);

    always @(posedge clk) begin
        if(reset) q <= 0;
        else if(ena) q <= d;
        else q <= q;
    end

endmodule