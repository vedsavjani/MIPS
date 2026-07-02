module ID_EX_controlpipe(
    input clk,
    input regwriteD, memtoregD, memwriteD,
    input branchD, alusrcD, regdstD,
    input [2:0] alucontrolD,
    output reg regwriteE, memtoregE, memwriteE,
    output reg branchE, alusrcE, regdstE,
    output reg [2:0] alucontrolE);

    always @(posedge clk) begin
        regwriteE <= regwriteD;
        memtoregE <= memtoregD;
        memwriteE <= memwriteD;
        branchE <= branchD;
        alusrcE <= alusrcD;
        regdstE <= regdstD;
        alucontrolE <= alucontrolD;
    end
endmodule