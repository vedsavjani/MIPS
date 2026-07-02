module mips(
    input clk ,reset,
    input [31:0] instrF,
    input [31:0] readdataM,
    output [31:0] aluoutM, writedataM,
    output [31:0] pcF,
    output memwriteM);

    wire [31:0] instrD;
    wire [2:0] alucontrolE;
    wire zeroM;
    wire pcsrcM, memtoregW, alusrcE, regdstE, regwriteW;

    controller c(.clk(clk), .reset(reset),
                .op(instrD[31:26]), .funct(instrD[5:0]),
                .zeroM(zeroM),
                .regwriteW(regwriteW),
                .memtoregW(memtoregW),
                .memwriteM(memwriteM),
                .alucontrolE(alucontrolE),
                .alusrcE(alusrcE),
                .pcsrcM(pcsrcM),
                .regdstE(regdstE));

    datapath dp(.clk(clk), .reset(reset),
    .regwriteW(regwriteW), .alusrcE(alusrcE),
    .regdstE(regdstE), .memtoregW(memtoregW),
    .pcsrcM(pcsrcM),
    .alucontrolE(alucontrolE),
    .instrF(instrF),
    .readdataM(readdataM),
    .zeroM(zeroM),
    .pcF(pcF),
    .writedataM(writedataM), .aluoutM(aluoutM),
    .instrD(instrD));
endmodule