module mips(
    input clk ,reset,
    input [31:0] instr, data,
    output memwrite, IRWrite,
    output [31:0] adr, writedata);

    wire zero;
    wire memtoreg, regdst, IorD, alusrca, regwrite, PCEn;
    wire [1:0] pcsrc, alusrcb; 
    wire [2:0] alucontrol;

    control_unit c(.clk(clk), .reset(reset),
        .zero(zero),
        .op(instr[31:26]), .funct(instr[5:0]),
        .memtoreg(memtoreg),
        .regdst(regdst),
        .IorD(IorD),
        .pcsrc(pcsrc),
        .alusrcb(alusrcb),
        .alusrca(alusrca),
        .IRWrite(IRWrite),
        .memwrite(memwrite),
        .regwrite(regwrite),
        .PCEn(PCEn),
        .alucontrol(alucontrol));

    datapath dp(.clk(clk), .reset(reset),
        .instr(instr), .data(data),
        .memtoreg(memtoreg), .regdst(regdst),
        .IorD(IorD),
        .pcsrc(pcsrc),
        .alusrcb(alusrcb),
        .alusrca(alusrca),
        .regwrite(regwrite),
        .PCEn(PCEn),
        .zero(zero),
        .alucontrol(alucontrol),
        .adr(adr), .writedata(writedata));

endmodule