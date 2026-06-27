module datapath(
    input clk, reset,
    input regwrite, alusrc,
    input [2:0] alucontrol,
    input [31:0] instr,
    output zero,
    output [31:0] pc,
    output [31:0] writedata, aluout
    );

    wire [31:0] pcnext;
    wire [31:0] signimm;
    wire [31:0] srca, srcb;
    // Next PC logic
    flopr pcreg(.clk(clk), .reset(reset), .d(pcnext), .q(pc));



    // Register file logic
    regfile rf(.clk(clk), .we3(regwrite), .ra1(instr[25:21]),
                .ra2(), .wa3(), .wd3(), .rd1(), .rd2());
    signext se(.a(instr[15:0]), y(signimm));



    // ALU logic
    mux2 #(32) srcbmux(.d0(writedata), .d1(signimm), .s(alusrc), .y(srcb));
    alu alu(.srca(srca), .srcb(srcb), .alucontrol(alucontrol), .aluresult(aluout), .zero(zero));

endmodule