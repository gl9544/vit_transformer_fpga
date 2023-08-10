//////////////////////////////////////////////////////////////////////////////////
// MODULE: MLP multiplier
// Created by roman gilgor
// updated : 8.6.23 
//////////////////////////////////////////////////////////////////////////////////


module mlp_mult #(parameter WIDTH = 32, N = 1)(
    input clk,
    input rst,
    input  signed [WIDTH-1:0] data_in,   
    output signed [WIDTH-1:0] data_out  // if input overflows we use clipping
);

    wire signed [WIDTH-1:0] weight;
    
    reg signed [WIDTH:0] mul;
    
    assign weight = 32'h00000000+$signed(N);
    
    always@(posedge clk or negedge rst) begin
        if(!rst) 
            mul <= 32'h00000000;
        else 
            mul <= data_in*weight;
    end
    
    // performing clipping
    assign data_out = (mul >= 2**(WIDTH-1)) ? 32'h7fffffff : (mul < -2**(WIDTH-1)) ? 32'h80000000 : mul[WIDTH-1:0];
   
endmodule
