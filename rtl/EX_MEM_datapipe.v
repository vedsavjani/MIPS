module EX_MEM_datapipe(
    input clk,
    input zeroE,
    output reg zeroM,
    input [31:0] aluoutE, writedataE,
    output reg [31:0] aluoutM, writedataM,
    input [4:0] writeregE,
    output reg [4:0] writeregM,
    input [31:0] pcbranchE,
    output reg [31:0] pcbranchM);

    always @(posedge clk) begin
        zeroM <= zeroE;
        aluoutM <= aluoutE;
        writedataM <= writedataE;
        writeregM <= writeregE;
        pcbranchM <= pcbranchE;
    end

endmodule