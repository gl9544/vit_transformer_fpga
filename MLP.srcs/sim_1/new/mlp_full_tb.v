`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2023 09:22:55 AM
// Design Name: 
// Module Name: mlp_full_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mlp_full_tb(
);

    localparam DELAY = 5;
    localparam WIDTH = 32;
    localparam N_OUT = 350;
    
    reg clk, rst, start;
    wire valid;
    wire valid_exp;
    
    always #DELAY clk = ~clk;
    
    mlp_full #(.WIDTH(WIDTH), .N_OUT(N_OUT)) mlp_full_dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .valid(valid),
        .valid_exp(valid_exp)  
    ); 

    initial begin
        rst = 0;
        start = 0;
        clk = 0;
        #(5*DELAY);
        
        rst = 1;
        start = 1;
        #(1500*DELAY);
        
        $finish; 
     
    end
    
endmodule
