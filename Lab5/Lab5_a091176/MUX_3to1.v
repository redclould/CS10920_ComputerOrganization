`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/08 00:26:42
// Design Name: 
// Module Name: MUX_3to1
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
     
module MUX_3to1(
               data0_i,
               data1_i,
			   data2_i,
               select_i,
               data_o
               );	   
			
parameter size = 0;	
			
//I/O ports               
input	[size-1:0]   data0_i;          
input	[size-1:0]   data1_i;
input	[size-1:0]   data2_i;
input   [1:0]		 select_i;

output	[size-1:0]   data_o; 

reg		[size-1:0]	 result;

always@(*)begin
    case(select_i)
        2'b00: result = data0_i;
        2'b01: result = data1_i;
        2'b10: result = data2_i;
    endcase 
end

assign data_o = result;

endmodule