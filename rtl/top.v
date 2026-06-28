module top(
    input clk, reset, 
    output [31:0] writedata, dataadr,
    output memwrite);

    wire [31:0] instr, pc, readdata;

    mips mips_proc(.clk(clk), .reset(reset), .instr(instr),
                   .readdata(readdata), .aluout(dataadr),
                   .writedata(writedata), .pc(pc), .memwrite(memwrite));

    imem instr_mem(.a(pc[7:2]), .rd(instr));

    dmem data_mem(.clk(clk), .we(memwrite), .a(dataadr), .wd(writedata), .rd(readdata));

endmodule