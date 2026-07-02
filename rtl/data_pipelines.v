module IF_ID_datapipe(
    input clk,
    input [31:0] instrF, pcplus4F,
    output reg [31:0] instrD, pcplus4D);

    always @(posedge clk) begin
        instrD <= instrF;
        pcplus4D <= pcplus4F;
    end

endmodule

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

module MEM_WB_datapipe(
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