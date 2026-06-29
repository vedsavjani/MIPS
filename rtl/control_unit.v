module control_unit(
    input clk, reset,
    input zero,
    input [5:0] op, funct,
    output memtoreg,
    output regdst,
    output IorD,
    output [1:0] pcsrc,
    output [1:0] alusrcb,
    output alusrca,
    output IRwrite,
    output memwrite,
    output regwrite,
    output PCEn,
    output [2:0] alucontrol);

    wire [1:0] aluop;
    wire pcwrite, branch;

    main_controller mc(.clk(clk), .reset(reset), .op(op), .memtoreg(memtoreg), 
                       .regdst(regdst), .IorD(IorD), .pcsrc(pcsrc), .alusrcb(alusrcb),
                       .alusrca(alusrca), .IRwrite(IRwrite), .memwrite(memwrite),
                       .pcwrite(pcwrite), .branch(branch), .regwrite(regwrite), .aluop(aluop));

    aludec ad(.funct(funct), .aluop(aluop), .alucontrol(alucontrol));

    assign PCEn = pcwrite | (zero & branch);

endmodule