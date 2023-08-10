`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2023 02:05:09 PM
// Design Name: 
// Module Name: mlp_unit_tb
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


module mlp_unit_tb(
);


    localparam WIDTH = 32;
    localparam D_MODEL = 256;
    
    localparam DELAY = 5;
    
    reg clk;
    reg rst;
    wire [WIDTH-1:0] sum;
    
    always #DELAY clk = ~clk;
    
    mlp_unit #(.WIDTH(WIDTH), .D_MODEL(D_MODEL)) mlp_unit_dut (
        .clk(clk),
        .rst(rst),
        .sum(sum)
);
            
        initial begin
            rst = 0;
            clk = 0;
            #(5*DELAY);
            
            rst = 1;
            #(50*DELAY);
        
            $finish;
            
        end
               
endmodule
