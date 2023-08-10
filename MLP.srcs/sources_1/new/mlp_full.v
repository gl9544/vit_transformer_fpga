
//////////////////////////////////////////////////////////////////////////////////
// MODULE : top mlp module. Instantiated with 350 mlp units
//////////////////////////////////////////////////////////////////////////////////

`include "defines.v"

module mlp_full #(parameter WIDTH = `WIDTH, N_OUT = `N_OUT)(
    input clk,
    input rst,
    input start,
    output valid,
    output reg valid_exp
    
    );
    
    wire [WIDTH-1:0] all_mlp [0:N_OUT-1]; // All N's MLP outputs 
    
    localparam D_MODEL = `D_MODEL;
    
    // MLP UNIT instantiation
    genvar i;
    
    generate
        for(i=0; i< N_OUT; i=i+1) begin
        mlp_unit #(.WIDTH(WIDTH), .D_MODEL(D_MODEL)) mlp (
            .clk(clk),
            .rst(rst),
            .sum(all_mlp[i])
        );    
        end
    endgenerate
 
    reg [4:0] cnt;
    
    // Valid logic
    always @(posedge clk or negedge rst) begin
        if(!rst)
            cnt <= 0;
        else
            if(!start || cnt == 4'b1001)
                cnt <= 0;
            else if(cnt < 4'b1001)
                cnt <= cnt  + 1;        
    end
     
    assign valid = (cnt == 4'b1001) ? 1:0;
    
   // EXPONET UNIT STATE MACHINE
   //////////////////////////////////
   
    localparam DEPTH = `DEPTH;
    localparam DATA_WIDTH = `DATA_WIDTH;
    
    reg [DATA_WIDTH-1:0] exp_mem_result[0:N_OUT-1];
    reg  [$clog2(DEPTH)-1:0] adr;
    wire [DATA_WIDTH-1:0] result;
    
    reg [$clog2(N_OUT)-1:0]cnt_out; // counts from 0 to N_OUT

    exponent_mem #(.DEPTH(DEPTH), .DATA_WIDTH(DATA_WIDTH)) exponent_mem_dut (
     // .clk(clk),
      .addr(adr),
      .exp_value(result)          
    );
    
    
    //state dellaration
    localparam IDLE    =    4'b0001;
    localparam SET_ADR =    4'b0010;
    localparam ASSIGN  =    4'b0100;
    localparam DONE    =    4'b1000;
    
    reg [3:0] state, next_state;

    always@ (posedge clk or negedge rst) begin
        if(!rst)
            state <= IDLE;
        else
            state <= next_state;
    end 
    
    always @(*) begin
        case(state)     
            IDLE: 
                if(valid)
                    next_state <= SET_ADR;
                  else
                    next_state <= IDLE;
                    
            SET_ADR:
                if(cnt_out < N_OUT)     
                    next_state = ASSIGN;
                else 
                    next_state = DONE;
                    
            ASSIGN: 
                    next_state = SET_ADR;
                    
            DONE:
                   next_state = DONE;
             default:
                    next_state = IDLE;          
        endcase
    end 
    
    
    always @(posedge clk) begin
        if(state == IDLE) begin
            cnt_out <= 0;
            valid_exp <= 0;
        end
        else if(state == SET_ADR)
            adr <= all_mlp[cnt_out][WIDTH-1-:4];
        else if(state == ASSIGN) begin
            cnt_out <= cnt_out+1;
            exp_mem_result[cnt_out] <= result;
        end
        else if (state == DONE)     
            valid_exp <= 1;
    end
       
endmodule
