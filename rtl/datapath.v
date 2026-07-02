module datapath(
    input clk, reset,
    input regwriteW, alusrcE,
    input regdstE, memtoregW,
    input pcsrcM,
    input [2:0] alucontrolE,
    input [31:0] instrF,
    input [31:0] readdataM,
    output zeroM,
    output [31:0] pcF,
    output [31:0] writedataM, aluoutM);

    // Internal wiring
    wire [31:0] pcnext, pcplus4F, pcplus4D, pcplus4E, pcbranchE, pcbranchM;
    wire [31:0] instrD, signimmD, signimmE, signimmshE;
    wire [4:0] rtE, rdE, writeregE, writeregM, writeregW;
    wire [31:0] resultW, rd1, rd2, srcAE, writedataE, srcBE, aluoutE;
    wire zeroE;
    wire [31:0] aluoutW, readdataW;



    // Next PC logic 
    mux2 #(32) pcnextmux(.d0(pcplus4F), .d1(pcbranchM), .s(pcsrcM), .y(pcnext));

    flopr pcreg(.clk(clk), .reset(reset), .d(pcnext), .q(pcF));

    adder pcadd1(.a(pcF), .b(32'd4), .y(pcplus4F));

    // IF_ID datapipe 
    IF_ID_datapipe if_id(.clk(clk), .reset(reset),
                    .instrF(instrF), .pcplus4F(pcplus4F),
                    .instrD(instrD), .pcplus4D(pcplus4D));

    regfile rf(.clk(clk),
                .we3(regwriteW),
                .ra1(instrD[25:21]), .ra2(instrD[20:16]), .wa3(writeregW),
                .wd3(resultW),
                .rd1(rd1), .rd2(rd2));

    signext se(.a(instrD[15:0]), .y(signimmD));

    // ID_EX datapipe 
    ID_EX_datapipe id_ex(.clk(clk), .reset(reset),
                    .rd1(rd1), .rd2(rd2),
                    .srcAE(srcAE), .writedataE(writedataE),
                    .rtD(instrD[20:16]), .rdD(instrD[15:11]),
                    .rtE(rtE), .rdE(rdE),
                    .signimmD(signimmD), .pcplus4D(pcplus4D), 
                    .signimmE(signimmE), .pcplus4E(pcplus4E));

    mux2 #(5) wrmux(.d0(rtE), .d1(rdE), .s(regdstE), .y(writeregE));

    mux2 #(32) alumux(.d0(writedataE), .d1(signimmE), .s(alusrcE), .y(srcBE));

    sl2 immsh(.a(signimmE), .y(signimmshE));

    alu mainalu(.srca(srcAE), .srcb(srcBE),
                    .alucontrol(alucontrolE),
                    .aluresult(aluoutE),
                    .zero(zeroE));

    adder pcadd2(.a(signimmshE), .b(pcplus4E), .y(pcbranchE));

    // EX_MEM datapipe
    EX_MEM_datapipe ex_mem(.clk(clk), .reset(reset),
                        .zeroE(zeroE),
                        .zeroM(zeroM),
                        .aluoutE(aluoutE), .writedataE(writedataE),
                        .aluoutM(aluoutM), .writedataM(writedataM),
                        .writeregE(writeregE),
                        .writeregM(writeregM),
                        .pcbranchE(pcbranchE),
                        .pcbranchM(pcbranchM));




    // MEM_WB datapipe 
    MEM_WB_datapipe mem_wb(.clk(clk), .reset(reset),
                        .aluoutM(aluoutM), .readdataM(readdataM),
                        .aluoutW(aluoutW), .readdataW(readdataW),
                        .writeregM(writeregM),
                        .writeregW(writeregW));

    mux2 #(32) resmux(.d0(aluoutW), .d1(readdataW), .s(memtoregW), .y(resultW));

endmodule