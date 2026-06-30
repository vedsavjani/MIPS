module datapath(
    input clk, reset,
    input [31:0] instr, data,
    input memtoreg, regdst,
    input IorD,
    input [1:0] pcsrc,
    input [1:0] alusrcb,
    input alusrca,
    input IRwrite,
    input regwrite,
    input PCEn,
    output zero,
    output [2:0] alucontrol,
    output [31:0] adr, writedata);

    wire  [4:0] writereg;
    wire [31:0] pc, pcnext;
    wire [31:0] signimm, signimmsh;
    wire [31:0] srca, srcb;
    wire [31:0] aluresult, aluout, result;
    wire [31:0] rd1,rd2, A;

    // Next PC logic
    mux4 #(32) pcsrcmux(.d0(aluresult), .d1(aluout), .d2({pc[31:28], instr[25:0], 2'b00}), .d3(32'b0), .s(pcsrc), .y(pcnext));

    flopenr pcreg(.clk(clk), .reset(reset), .ena(PCEn), .d(pcnext), .q(pc));

    mux2 #(32) adrmux(.d0(pc), .d1(aluout), .s(IorD), .y(adr));

    // Register file logic
    regfile rf(.clk(clk), .we3(regwrite), .ra1(instr[25:21]), .ra2(instr[20:16]), 
               .wa3(writereg), .wd3(result), .rd1(rd1), .rd2(rd2));


    mux2 #(5) wrmux(.d0(instr[20:16]), .d1(instr[15:11]), .s(regdst), .y(writereg));

    mux2 #(32) resmux(.d0(aluout), .d1(data), .s(memtoreg), .y(result));

    signext se(.a(instr[15:0]), .y(signimm));

    sl2 immish(.a(signimm), .y(signimmsh));

    flopr Areg(.clk(clk), .reset(reset), .d(rd1), .q(A));

    flopr Breg(.clk(clk), .reset(reset), .d(rd2), .q(writedata));


    // ALU logic
    mux2 #(32) srcamux(.d0(pc), .d1(A), .s(alusrca), .y(srca));

    mux4 #(32) srcbmux(.d0(writedata), .d1(32'd4), .d2(signimm), .d3(signimmsh), .s(alusrcb), .y(srcb));

    alu mainalu(.srca(srca), .srcb(srcb), .alucontrol(alucontrol), .aluresult(aluresult), .zero(zero));

    flopr alureg(.clk(clk), .reset(reset), .d(aluresult), .q(aluout));
endmodule