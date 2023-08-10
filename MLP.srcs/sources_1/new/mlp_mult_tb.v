`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2023 01:38:15 PM
// Design Name: 
// Module Name: mlp_mult_tb
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


module mlp_mult_tb(
);

    localparam WIDTH  = 32;
    localparam N = 10;
    
    reg clk;
    reg rst;
    reg signed  [WIDTH-1:0] data_in;
    wire signed [WIDTH-1:0] data_out; 

    localparam DELAY = 5;
    
    // clock generator
    always #DELAY clk = ~clk;
    
    // Instantiation
    mlp_mult #(.WIDTH(WIDTH), .N(N)) dut_mlp_mult (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out)
    );
    
    initial begin
        rst = 0;
        clk = 0;
        #(10*DELAY);
         
        //checking multiplication
        data_in = 32'h00000005;
        rst = 1;
        #(10*DELAY);        
        
        //checking clipping (high value)
        data_in = 32'h7ffffffa;
        #(10*DELAY);
        
        if(data_out == 32'h7fffffff)
            $display("positive cliping PASS\n");
        else begin
            $display("positive cliping FAIL\n");
            $finish;
        end
        
        //checking clipping (low value)
        data_in = 32'h80000005;
        #(10*DELAY);
    
        if(data_out == 32'h80000000)
            $display("negative cliping PASS\n");
        else begin
            $display("negative cliping FAIL\n");
            $finish;
        end
        
        $finish;
    end
        

endmodule
