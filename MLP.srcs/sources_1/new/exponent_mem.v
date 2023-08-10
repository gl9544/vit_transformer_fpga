//////////////////////////////////////////////////////////////////////////////////
// MODULE: EXPONENT MEMORY 
// Representation: only integer part
//////////////////////////////////////////////////////////////////////////////////

/*
module exponent_mem #(parameter DEPTH = 16, DATA_WIDTH = 32)(
    input clk,
    input rst,
    input [$clog2(DEPTH)-1:0] addr,
    output reg [DATA_WIDTH-1:0] exp_value
    );
    
    
    reg [DATA_WIDTH-1:0] exp_mem[0:DEPTH-1];
    
    initial begin
        $readmemh("exponent_values.mem", exp_mem, 0, 16);
    end
       
    
    always @(posedge clk)       
          exp_value <= exp_mem[addr];
   
  
endmodule
*/

module exponent_mem #(parameter DEPTH = 16, DATA_WIDTH = 32)(
    input  [$clog2(DEPTH)-1:0] addr,
    output [DATA_WIDTH-1:0] exp_value
    );
    
    
    wire [DATA_WIDTH-1:0] exp_mem[0:DEPTH-1];
    
    assign exp_mem[0] = 32'h00000001;
    assign exp_mem[1] = 32'h00000002;
    assign exp_mem[2] = 32'h00000007;
    assign exp_mem[3] = 32'h00000014;
    assign exp_mem[4] = 32'h00000036;
    assign exp_mem[5] = 32'h00000094;
    assign exp_mem[6] = 32'h00000193;
    assign exp_mem[7] = 32'h00000448;
    assign exp_mem[8] = 32'h00001fa7;
    assign exp_mem[9] = 32'h0000560a;
    assign exp_mem[10] = 32'h0000e9e2;
    assign exp_mem[11] = 32'h00027bc2;
    assign exp_mem[12] = 32'h0006c02d;
    assign exp_mem[13] = 32'h001259ac;
    assign exp_mem[14] = 32'h0031e199;
    assign exp_mem[15] = 32'h0087975e;
    
    assign exp_value = exp_mem[addr];
    
endmodule




