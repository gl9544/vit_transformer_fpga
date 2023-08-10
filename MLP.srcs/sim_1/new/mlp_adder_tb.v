`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2023 12:35:09 PM
// Design Name: 
// Module Name: mlp_adder_tb
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


module mlp_adder_tb(
);

    localparam WIDTH  = 32;
    
    reg clk;
    reg rst;
    reg signed [WIDTH-1:0] data_in1, data_in2;
    wire signed [WIDTH-1:0] data_out; 

    localparam DELAY = 5;
    
    // clock generator
    always #DELAY clk = ~clk;
    
    // Instantiation
    mlp_adder #(.WIDTH(WIDTH)) dut_mlp_adder (
        .clk(clk),
        .rst(rst),
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_out(data_out)
    );
    
    initial begin
        rst = 0;
        clk = 0;
        #(10*DELAY);
         
        //checking addition
        data_in1 = 32'h00000005;
        data_in2 = 32'hf0000777;
        rst = 1;
        #(10*DELAY);
        $display("the results of %h + %h is: %h\n", data_in1, data_in2, data_out);
        
        //checking clipping (high value)
        data_in1 = 32'h7ffffff0;
        data_in2 = 32'h00777777;
        #(10*DELAY);
        $display("the results of %h + %h is: %h\n", data_in1, data_in2, data_out);
        
        if(data_out == 32'h7fffffff)
            $display("positive cliping PASS\n");
        else begin
            $display("positive cliping FAIL\n");
            $finish;
        end
        
        //checking clipping (low value)
        data_in1 = 32'h80000005;
        data_in2 = 32'h80000777;
        #(10*DELAY);
        $display("the results of %h + %h is: %h\n", data_in1, data_in2, data_out);
    
        if(data_out == 32'h80000000)
            $display("negative cliping PASS\n");
        else begin
            $display("negative cliping FAIL\n");
            $finish;
        end
        
        $finish;
    end
        

endmodule
