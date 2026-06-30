module datapath(
    input clk, reset,
    input [31:0] readdata,
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
    output [31:0] adr
    );

    wire  [4:0] writereg;
    wire [31:0] pc, pcnext;
    wire [31:0] signimm, signimmsh;
    wire [31:0] srca, srcb;
    wire [31:0] result;

    // Next PC logic
    flopenr pcreg(.clk(clk), .reset(reset), .ena(PCEn), .d(pcnext), .q(pc));



    // Register file logic




    // ALU logic
    mux2 #

endmodule