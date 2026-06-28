    module tb();

        reg clk, reset;
        wire [31:0] writedata, dataadr;
        wire memwrite;

        top dut(.clk(clk), .reset(reset), .writedata(writedata), .dataadr(dataadr), .memwrite(memwrite));

        initial begin
            $dumpfile("dump.vcd");
            $dumpvars(0,tb); // 0 means all heirarchy levels below tb
        end

        initial begin
            clk = 0;
            forever #5 clk = ~clk;
        end

        initial begin
            reset = 1; #22 reset = 0;
        end

        always @(negedge clk) begin         // negedge becoz the write happens on the rising edge, so you check after it - at the falling edge, when the result has settled and is stable
            if(memwrite) begin
                if(writedata===7 && dataadr===84) begin  // use === and !== (case equality, they can compare 0,1,x,z all four) instead of == and != (logical equality, they compare only 0 and 1)
                    $display("Simulation succeeded.");
                    $stop;
                end
                else if(dataadr !== 80) begin
                    $display("Simulation failed.");
                    $stop;
                end
            end
        end

    endmodule