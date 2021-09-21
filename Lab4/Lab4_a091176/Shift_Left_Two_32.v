`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 02:35:01
// Design Name: 
// Module Name: Shift_Left_Two_32
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


module Shift_Left_Two_32(
        data_i,
        data_o
        );
parameter size = 0;	
//I/O ports                    
input  [size-1:0] data_i;
output [size-1:0] data_o;

reg    [32-1:0] data_o;

//shift left 2
always @(*) begin
	data_o <= data_i << 2;
end     
        
endmodule
