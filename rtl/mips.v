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

    controller c(
    .clk(clk),
    input [5:0] op, funct,
    input zeroM,
    output regwriteW,
    output memtoregW,
    output memwriteM,
    output [2:0] alucontrolE,
    output alusrcE,
    output pcsrcM,
    output regdstE);

    datapath dp(
    input clk, reset,
    input regwriteW, alusrcE,
    input regdstE, memtoregW,
    input pcsrcM,
    input [2:0] alucontrolE,
    input [31:0] instrF,
    input [31:0] readdataM,
    output zeroM,
    output [31:0] pcF,
    output [31:0] writedataM, aluoutM
    output [31:0] instrD);

endmodule