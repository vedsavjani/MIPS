module IF_ID_datapipe(
    input clk,
    input [31:0] instrF, pcplus4F,
    output reg [31:0] instrD, pcplus4D);

    always @(posedge clk) begin
        instrD <= instrF;
        pcplus4D <= pcplus4F;
    end

endmodule
