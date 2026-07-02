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

    

endmodule