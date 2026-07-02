module MEM_WB_controlpipe(
    input clk,
    input regwriteM, memtoregM,
    output reg regwriteW, memtoregW);

    always @(posedge clk) begin
        regwriteW <= regwriteM;
        memtoregW <= memtoregW;
    end
endmodule