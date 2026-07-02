module IF_ID_datapipe(
    input clk, reset,
    input [31:0] instrF, pcplus4F,
    output reg [31:0] instrD, pcplus4D);

    always @(posedge clk) begin
        if (reset) begin
            instrD <= 32'b0;
            pcplus4D <= 32'b0;
        end
        else begin
            instrD <= instrF;
            pcplus4D <= pcplus4F;
        end
    end

endmodule

module ID_EX_datapipe(
    input clk, reset,
    input [31:0] rd1, rd2,
    output reg [31:0] srcAE, writedataE,
    input [4:0] rtD, rdD,
    output reg [4:0] rtE, rdE,
    input [31:0] signimmD, pcplus4D, 
    output reg [31:0] signimmE, pcplus4E);

    always @(posedge clk) begin
        if (reset) begin
            srcAE <= 32'b0;
            writedataE <= 32'b0;
            rtE <= 5'b0;
            rdE <= 5'b0;
            signimmE <= 32'b0;
            pcplus4E <= 32'b0;
        end
        else begin
            srcAE <= rd1;
            writedataE <= rd2;
            rtE <= rtD;
            rdE <= rdD;
            signimmE <= signimmD;
            pcplus4E <= pcplus4D;
        end
    end

endmodule

module EX_MEM_datapipe(
    input clk, reset,
    input zeroE,
    output reg zeroM,
    input [31:0] aluoutE, writedataE,
    output reg [31:0] aluoutM, writedataM,
    input [4:0] writeregE,
    output reg [4:0] writeregM,
    input [31:0] pcbranchE,
    output reg [31:0] pcbranchM);

    always @(posedge clk) begin
        if (reset) begin
            zeroM <= 1'b0;
            aluoutM <= 32'b0;
            writedataM <= 32'b0;
            writeregM <= 5'b0;
            pcbranchM <= 32'b0;
        end
        else begin
            zeroM <= zeroE;
            aluoutM <= aluoutE;
            writedataM <= writedataE;
            writeregM <= writeregE;
            pcbranchM <= pcbranchE;
        end
    end

endmodule

module MEM_WB_datapipe(
    input clk, reset,
    input [31:0] aluoutM, readdataM,
    output reg [31:0] aluoutW, readdataW,
    input [4:0] writeregM,
    output reg [4:0] writeregW);

    always @(posedge clk) begin
        if (reset) begin
            aluoutW <= 32'b0;
            readdataW <= 32'b0;
            writeregW <= 5'b0;
        end
        else begin
            aluoutW <= aluoutM;
            readdataW <= readdataM;
            writeregW <= writeregM;
        end
    end

endmodule