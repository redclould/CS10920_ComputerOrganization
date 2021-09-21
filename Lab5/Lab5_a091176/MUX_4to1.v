`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 01:01:30
// Design Name: 
// Module Name: MUX_4to1
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


module MUX_4to1(
           data0_i,
           data1_i,
           data2_i,
           data3_i,
           select_i,
           data_o
           );	   
			
parameter size = 0;	
			
//I/O ports               
input	[size-1:0]   data0_i;          
input	[size-1:0]   data1_i;
input	[size-1:0]   data2_i;
input	[size-1:0]   data3_i;
input   [1:0]		 select_i;

output	[size-1:0]   data_o; 

reg		[size-1:0]	 result;

always@(*)begin
    case(select_i) 
        2'd0: result = data0_i; //beq
        2'd1: result = data1_i; //bge
        2'd2: result = data2_i; //bgt
        2'd3: result = data3_i; //bne
    endcase 
end

assign data_o = result;
endmodule
