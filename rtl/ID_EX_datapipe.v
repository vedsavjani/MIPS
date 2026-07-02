module ID_EX_datapipe(
    input clk,
    input [31:0] rd1, rd2,
    output reg [31:0] srcAE, writedataE,
    input [4:0] rtD, rdD,
    output reg [4:0] rtE, rdE,
    input [31:0] signimmD, pcplus4D, 
    output reg [31:0] signimmE, pcplus4E);

    always @(posedge clk) begin
        srcAE <= rd1;
        writedataE <= rd2;
        rtE <= rtD;
        rdE <= rdD;
        signimmE <= signimmD;
        pcplus4E <= pcplus4D;
    end

endmodule