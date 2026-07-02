module regfile (
    input clk,
    input we3,
    input [4:0] ra1, ra2, wa3,
    input [31:0] wd3,
    output [31:0] rd1, rd2);

    reg [31:0] rf[31:0];

    always @(negedge clk) begin     // negedge becoz we want to write in the first half.
        if(we3) rf[wa3] <= wd3;     // nededge comes bw two posedges (i.e. at half pt of a clk cycle),
    end                             // so write the register then, and the other registers are combinationally updated after that

    assign rd1 = (ra1 != 0)? rf[ra1] : 0;
    assign rd2 = (ra2 != 0)? rf[ra2] : 0;
endmodule