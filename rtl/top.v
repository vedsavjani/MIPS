module top(
    input clk, reset, 
    output [31:0] writedata, adr,
    output memwrite);

    wire [31:0] instr, data, readdata;
    wire IRWrite;

    mips mips_proc(.clk(clk), .reset(reset),
        .instr(instr), .data(data),
        .memwrite(memwrite), IRWrite(IRWrite),
        .adr(adr), .writedata(writedata));

    mem unified_mem(.clk(clk), .we(memwrite),
        .adr(adr), .wd(writedata),
        .rd(readdata));

    flopenr instrReg(.clk(clk), .reset(reset), .ena(IRWrite), .d(readdata), .q(instr));

    flopr datareg(.clk(clk), .reset(reset), .d(readdata), .q(data));
endmodule