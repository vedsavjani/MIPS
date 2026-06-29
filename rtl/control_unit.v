module control_unit(
    input clk, reset,
    input [5:0] op, funct,
    output memtoreg,
    output regdst,
    output IorD,
    output [1:0] pcsrc,
    output [1:0] alusrcb,
    output alusrca,
    output IRwrite,
    output memwrite,
    output pcwrite,
    output branch,
    output regwrite,
    output [2:0] alucontrol);

    wire [1:0] aluop;

    main_controller mc();

    aludec ad(.funct(funct), .aluop(aluop), .alucontrol(alucontrol));

endmodule