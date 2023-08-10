////////////////////////////////////////////////
// MODULE : Multi-Layer_perceptron
// OPERATION : Implemented as matrix-multiplication            
//////////////////////////////////////////////////

module mlp_unit #(parameter WIDTH = 32, D_MODEL = 256) (
    input clk,
    input rst,
    output [WIDTH-1:0] sum
);
    
    reg signed [WIDTH-1:0] rep_mem[0:D_MODEL-1];                 // Input memory
    
    initial begin
        $readmemb("rep_mem_in0.txt", rep_mem, 0,D_MODEL-1);
    end
    
    //integer loop;
    
    //initial begin 
    //  for(loop=0; loop<D_MODEL; loop=loop+1) 
    //  rep_mem[loop] <= 32'h00000002;       
    // end
    
    //initial begin
    //    $readmemb("MLP_UNIT_REP_MEM.mem", rep_mem);
    //end
   
    wire signed [WIDTH-1:0] mul_result[0:D_MODEL-1];               // Mult result memory
    
    wire signed [WIDTH-1:0] layer1_result[0:D_MODEL/2-1];        // 1st layet memory result
    wire signed [WIDTH-1:0] layer2_result[0:D_MODEL/4-1];        //  2st layet memory result
    wire signed [WIDTH-1:0] layer3_result[0:D_MODEL/8-1];        //  3st layet memory result
    wire signed [WIDTH-1:0] layer4_result[0:D_MODEL/16-1];       //  4st layet memory result
    wire signed [WIDTH-1:0] layer5_result[0:D_MODEL/32-1];       //  5st layet memory result
    wire signed [WIDTH-1:0] layer6_result[0:D_MODEL/64-1];       //  6st layet memory result
    wire signed [WIDTH-1:0] layer7_result[0:D_MODEL/128-1];      //  7st layet memory result        
    
        
    // Generating multipliers
    genvar i;
    
    generate 
        for(i=0; i<D_MODEL; i=i+1) begin
            mlp_mult #(.WIDTH(WIDTH), .N(i)) mult(.clk(clk), .rst(rst), .data_in(rep_mem[i]), .data_out(mul_result[i])); 
        end
    endgenerate
    
  // Generating 1st layer of adders
    genvar j;
    
    generate 
        for(j=0; j<D_MODEL/2; j=j+1) begin
            mlp_adder #(.WIDTH(WIDTH)) adder_1st(.clk(clk), .rst(rst), .data_in1(mul_result[2*j]), .data_in2(mul_result[2*j+1]), .data_out(layer1_result[j]));
        end
    endgenerate
    
    // Generating 2nd layer of adders
    genvar k;
    
    generate 
        for(k=0; k<D_MODEL/4; k=k+1) begin
            mlp_adder #(.WIDTH(WIDTH)) adder_2nd(.clk(clk), .rst(rst), .data_in1(layer1_result[2*k]), .data_in2(layer1_result[2*k+1]), .data_out(layer2_result[k]));
        end
    endgenerate
    
    // Generating 3rd layer of adders
    genvar l;
    
    generate 
        for(l=0; l<D_MODEL/8; l=l+1) begin
            mlp_adder #(.WIDTH(WIDTH)) adder_3rd(.clk(clk), .rst(rst), .data_in1(layer2_result[2*l]), .data_in2(layer2_result[2*l+1]), .data_out(layer3_result[l]));
        end
    endgenerate
    
     // Generating 4th layer of adders
    genvar m;
    
    generate 
        for(m=0; m<D_MODEL/16; m=m+1) begin
            mlp_adder #(.WIDTH(WIDTH)) adder_4th(.clk(clk), .rst(rst), .data_in1(layer3_result[2*m]), .data_in2(layer3_result[2*m+1]), .data_out(layer4_result[m]));
        end
    endgenerate
    
    // Generating 5th layer of adders
    genvar n;
    
    generate 
        for(n=0; n<D_MODEL/32; n=n+1) begin
            mlp_adder #(.WIDTH(WIDTH)) adder_5th(.clk(clk), .rst(rst), .data_in1(layer4_result[2*n]), .data_in2(layer4_result[2*n+1]), .data_out(layer5_result[n]));
        end
    endgenerate
    
    // Generating 6th layer of adders
    genvar o;
    
    generate 
        for(o=0; o<D_MODEL/64; o=o+1) begin
            mlp_adder #(.WIDTH(WIDTH)) adder_6th(.clk(clk), .rst(rst), .data_in1(layer5_result[2*o]), .data_in2(layer5_result[2*o+1]), .data_out(layer6_result[o]));
        end
    endgenerate
    
    // Generating 7th layer of adders
    genvar p;
    
    generate 
        for(p=0; p<D_MODEL/128; p=p+1) begin
            mlp_adder #(.WIDTH(WIDTH)) adder_7th(.clk(clk), .rst(rst), .data_in1(layer6_result[2*p]), .data_in2(layer6_result[2*p+1]), .data_out(layer7_result[p]));
        end
    endgenerate
    
   genvar s;
   
   // Last adder instantiation
      mlp_adder #(.WIDTH(WIDTH)) last_adder (.clk(clk), .rst(rst), .data_in1(layer7_result[0]), .data_in2(layer7_result[1]), .data_out(sum));
   
       
endmodule

  