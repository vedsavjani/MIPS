module MEM_WB_pipe(
    input clk,
    input [31:0] aluoutM, readdataM,
    output reg [31:0] aluoutW, readdataW,
    input [4:0] writeregM,
    output reg [4:0] writeregW);

    always @(posedge clk) begin
        aluoutW <= aluoutM;
        readdataW <= readdataM;
        writeregW <= writeregM;
    end

endmodule