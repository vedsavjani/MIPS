module mem(
    input clk, we,
    input [31:0] adr, wd,
    output [31:0] rd);

    reg [31:0] RAM[127:0];

    initial begin
        $readmemh("mem/memfile.dat", RAM);
    end

    assign rd = RAM[adr[31:2]];

    always @(posedge clk) begin
        if(we) RAM[adr[31:2]] <= wd;
    end
endmodule