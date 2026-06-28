module datapath(
    input clk, reset,
    input regwrite, alusrc,
    input regdst, memtoreg,
    input pcsrc, jump,
    input [2:0] alucontrol,
    input [31:0] instr,
    input [31:0] readdata,
    output zero,
    output [31:0] pc,
    output [31:0] writedata, aluout
    );

    wire  [4:0] writereg;
    wire [31:0] pcnext, pcplus4, pcnextbr, pcbranch;
    wire [31:0] signimm, signimmsh;
    wire [31:0] srca, srcb;
    wire [31:0] result;

    // Next PC logic
    flopr pcreg(.clk(clk), .reset(reset), .d(pcnext), .q(pc));

    adder pcadd1(.a(pc), .b(32'd4), .y(pcplus4));

    sl2 immsh(.a(signimm), .y(signimmsh));

    adder pcadd2(.a(pcplus4), .b(signimmsh), .y(pcbranch));

    mux2 #(32) pcbrmux(.d0(pcplus4), .d1(pcbranch), .s(pcsrc), .y(pcnextbr));

    mux2 #(32) pcmux(.d0(pcnextbr), .d1({pcplus4[31:28], instr[25:0], 2'b00}), .s(jump), .y(pcnext));

    // Register file logic
    regfile rf(.clk(clk), .we3(regwrite), .ra1(instr[25:21]),
                .ra2(instr[20:16]), .wa3(writereg), .wd3(result), .rd1(srca), .rd2(writedata));

    signext se(.a(instr[15:0]), .y(signimm));

    mux2 #(5) wrmux(.d0(instr[20:16]), .d1(instr[15:11]), .s(regdst), .y(writereg));

    mux2 #(32) resmux(.d0(aluout), .d1(readdata), .s(memtoreg), .y(result));

    // ALU logic
    mux2 #(32) srcbmux(.d0(writedata), .d1(signimm), .s(alusrc), .y(srcb));
    alu mainalu(.srca(srca), .srcb(srcb), .alucontrol(alucontrol), .aluresult(aluout), .zero(zero));

endmodule