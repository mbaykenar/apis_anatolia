`timescale 1ns / 1ps

module counter
#(
    parameter N = 4
)
(
input   clk,
input   arst_n,
input   en_i,
input   load_i,
input   [N-1:0] load_val_i ,
output reg [N-1:0] counter_o
//output  [N-1:0] counter_o
);

////////////////////////////////////////////////////////////////////////////////
// METHOD #1
////////////////////////////////////////////////////////////////////////////////

/*
reg [N-1:0] counter; 

always @(posedge clk or negedge arst_n) begin
    
    if (~arst_n) begin
        counter <= 0;
    end 
    else begin
        if (load_i) begin
            counter <= load_val_i;
        end
        else if (en_i) begin
            counter <= counter + 1;
        end
    end

end

assign counter_o = counter;
*/

////////////////////////////////////////////////////////////////////////////////
// METHOD #2
////////////////////////////////////////////////////////////////////////////////



always @(posedge clk or negedge arst_n) begin
    
    if (~arst_n) begin
        counter_o <= 0;
    end 
    else begin
        if (load_i) begin
            counter_o <= load_val_i;
        end
        else if (en_i) begin
            counter_o <= counter_o + 1;
        end
    end

end




endmodule