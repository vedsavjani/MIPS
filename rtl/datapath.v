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
    

endmodule