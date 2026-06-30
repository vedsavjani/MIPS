module main_controller(
    input clk, reset,
    input [5:0] op,
    output memtoreg,
    output regdst,
    output IorD,
    output [1:0] pcsrc,
    output [1:0] alusrcb,
    output alusrca,
    output IRWrite,
    output memwrite,
    output pcwrite,
    output branch,
    output regwrite,
    output [1:0] aluop);

    // Opcode encoding
    parameter lw=6'b100011, sw=6'b101011, Rtype=6'b000000, beq=6'b000100, addi=6'b001000, j=6'b000010;



    // S0  : Fetch
    // S1  : Decode
    // S2  : MemAdr
    // S3  : MemRead
    // S4  : MemWriteback
    // S5  : MemWrite
    // S6  : Execute
    // S7  : ALUWriteback
    // S8  : Branch
    // S9  : ADDIExecute
    // S10 : ADDIWriteback
    // S11 : Jump

    // State encoding
    parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8, S9=9, S10=10, S11=11;
    reg [4:0] state, next_state;

    always @(*) begin
        case(state) 
            S0 : next_state = S1;
            S1 : next_state = (op==lw || op==sw)? S2 : (op==Rtype)? S6 : (op==beq)? S8 : (op==addi)? S9 : (op==j)? S11 : S1;
            S2 : next_state = (op==lw)? S3 : (op==sw)? S5 : S2;
            S3 : next_state = S4;
            S4 : next_state = S0;
            S5 : next_state = S0;
            S6 : next_state = S7;
            S7 : next_state = S0;
            S8 : next_state = S0;
            S9 : next_state = S10;
            S10: next_state = S0;
            S11: next_state = S0;
            default: next_state = S0;
        endcase
    end

    always @(posedge clk) begin
        if(reset) state <= S0;
        else state <= next_state;
    end

    assign memtoreg = (state==S4);
    assign regdst = (state==S7);
    assign IorD = (state==S3) | (state==S5);
    assign pcsrc = (state==S0)? 2'b00 : (state==S8)? 2'b01 : (state==S11)? 2'b10 : 2'b00;
    assign alusrcb = (state==S6 || state==S8)? 2'b00 : (state==S0)? 2'b01 : (state==S2 || state==S9)? 2'b10 : (state==S1)? 2'b11 : 2'b00;
    assign alusrca = (state==S2) | (state==S6) | (state==S8) | (state==S9);
    assign IRWrite = (state==S0);
    assign memwrite = (state==S5);
    assign pcwrite = (state==S0) | (state==S11);
    assign branch = (state==S8);
    assign regwrite = (state==S4) | (state==S7) | (state==S10);
    assign aluop = (state==S0 || state==S1 || state==S2 || state==S9)? 2'b00 : (state==S8)? 2'b01 : (state==S6)? 2'b10 : 2'b00;
endmodule