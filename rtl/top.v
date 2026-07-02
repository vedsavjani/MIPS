module top(
    input clk, reset,
    output [31:0] writedataM, aluoutM,
    output memwriteM);

    wire [31:0] pcF, instrF, readdataM;

    mips m(.clk(clk), .reset(reset), .instrF(instrF), 
            .readdataM(readdataM), .aluoutM(aluoutM), 
            .writedataM(writedataM),
            .pcF(pcF), .memwriteM(memwriteM));

    imem im(.a(pcF[7:2]), .rd(instrF));
    dmem dm(.clk(clk), .we(memwriteM), .a(aluoutM), .wd(writedataM), .rd(readdataM));
endmodule