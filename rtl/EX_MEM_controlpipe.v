module EX_MEM_controlpipe(
    input clk,
    input regwriteE, memtoregE, memwriteE, branchE,
    output reg regwriteM, memtoregM, memwriteM, branchM);

    always @(posedge clk) begin
        regwriteM <= regwriteE;
        memtoregM <= memtoregE;
        memwriteM <= memwriteE;
        branchM <= branchE;
    end
endmodule