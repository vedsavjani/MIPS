module mips(
    input clk ,reset,
    input [31:0] instrF,
    input [31:0] readdataM,
    output [31:0] aluoutM, writedataM,
    output [31:0] pcF,
    output memwriteM);

    wire [31:0] alu
    wire [2:0] alucontrol;
    wire zero;
    wire pcsrc, memtoreg, alusrc, regdst, regwrite, jump;

    controller c(.op(instr[31:26]), .funct(instr[5:0]), .zero(zero), 
                 .memtoreg(memtoreg), .memwrite(memwrite), .pcsrc(pcsrc),
                 .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite), .jump(jump), .alucontrol(alucontrol));

    datapath dp(.clk(clk), .reset(reset), .pcsrc(pcsrc),
                 .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite),
                 .jump(jump), .alucontrol(alucontrol), .zero(zero), .memtoreg(memtoreg),
                 .instr(instr), .readdata(readdata), .pc(pc), .writedata(writedata), .aluout(aluout));

endmodule