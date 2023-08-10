//////////////////////////////////////////////////////////////////////////////////
// MODULE: MLP adder
// Created by roman gilgor
// updated : 8.6.23 
//////////////////////////////////////////////////////////////////////////////////


module mlp_adder #(parameter WIDTH = 32)(
    input  clk,
    input  rst,
    input  signed [WIDTH-1:0] data_in1, data_in2,  
    output signed [WIDTH-1:0] data_out              // if input overflows we use clipping 
);
    
    reg signed [WIDTH:0] add;   
    
    always @(posedge clk or negedge rst) begin
        if(!rst) 
            add <= 0;
        else
            add <= data_in1 + data_in2;   
    end
    
    // performing clipping
    assign data_out = (add >= 2**(WIDTH-1)) ? 32'h7fffffff : (add < -2**(WIDTH-1)) ? 32'h80000000 : add[WIDTH-1:0];  
        
endmodule
