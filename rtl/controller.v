module controller(
    input [5:0] op, funct,
    input zeroM,
    output regwriteW,
    output memtoregW,
    output memwriteM,
    output [2:0] alucontrolE,
    output alusrcE,
    output pcsrcM,
    output regdstE);

    wire regwriteD, regwriteE, regwriteM;
    wire memtoregD, memtoregE, memtoregM;
    wire memwriteD, memwriteE;
    wire branchD, branchE, branchM;
    wire [2:0] alucontrolD, alucontrolE;
    wire alusrcD, alusrcE;
    wire regdstD, regdstE;

    maindec md();

    aludec ad();

    

endmodule