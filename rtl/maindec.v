module maindec (input [5:0] op,
                output memtoreg, 
                output memwrite,
                output branch,
                output alusrc,
                output regdst,
                output regwrite,
                output [1:0] aluop);

    reg [7:0] controls;

    always @(*) begin
        case (op)
            6'b000000: controls = 8'b11000010; //Rtype
            6'b100011: controls = 8'b10100100; //LW
            6'b101011: controls = 8'b00101000; //SW
            6'b000100: controls = 8'b00010001; //BEQ
            6'b001000: controls = 8'b10100000; //ADDI
            6'b000010: controls = 8'b00000000; //J
            default:   controls = 8'bxxxxxxxx; //??? 
        endcase
    end

    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop} = controls;

endmodule