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

module MEM_WB_controlpipe(
    input clk,
    input regwriteM, memtoregM,
    output reg regwriteW, memtoregW);

    always @(posedge clk) begin
        regwriteW <= regwriteM;
        memtoregW <= memtoregW;
    end
endmodule