`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 02:32:44
// Design Name: 
// Module Name: MUX_2to1
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


module MUX_2to1(
               data0_i,
               data1_i,
               select_i,
               data_o
    );
    
parameter size = 0;	    

			
//I/O ports               
input	[size-1:0]   data0_i;          
input	[size-1:0]   data1_i;
input   			 select_i;

output	[size-1:0]   data_o; 

//Internal Signals
//reg     [size-1:0] data_o;

//Main function
assign data_o = (select_i == 1'b0) ? data0_i : data1_i;

endmodule
