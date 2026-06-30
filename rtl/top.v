module top(
    input clk, reset, 
    output [31:0] writedata, adr,
    output memwrite);

    wire [31:0] instr, data;

    mips mips_proc(
    .clk(clk), .reset(reset),
    .instr(instr), .data(data),
    .memwrite(memwrite),
    .adr(adr), .writedata(writedata));



    mem unified_mem(
    input clk, we,
    input [31:0] adr, wd,
    output [31:0] rd);

endmodule