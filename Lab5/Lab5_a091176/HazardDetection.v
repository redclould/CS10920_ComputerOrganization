`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/14 14:39:58
// Design Name: 
// Module Name: HazardDetection
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
module HazardDetection(
        EX_MemRead,
        EX_Rt,
        ID_Rs,
        ID_Rt,
        PCSrc,
        PC_Write,
        IF_ID_Write,
        IF_Flush,
        ID_Flush,
        EX_Flush
        );
input			EX_MemRead;
input	[4:0]	EX_Rt;
input	[4:0]	ID_Rs;
input	[4:0]	ID_Rt;
input			PCSrc;
output			PC_Write;
output			IF_ID_Write;
output			IF_Flush;
output			ID_Flush;
output			EX_Flush;

reg				result_PC_Write = 1'b1;
reg				result_IF_ID_Write = 1'b1;
reg				result_IF_Flush = 1'b0;
reg				result_ID_Flush = 1'b0;
reg				result_EX_Flush = 1'b0;

always@(*)begin
	result_PC_Write = 1'b1;
	result_IF_ID_Write = 1'b1;
	result_IF_Flush = 1'b0;
	result_ID_Flush = 1'b0;
	result_EX_Flush = 1'b0;
	//load-use hazard
	if((EX_MemRead) && ((EX_Rt == ID_Rs) || (EX_Rt == ID_Rt))) begin //load-use hazard
		result_PC_Write = 1'b0;
		result_IF_ID_Write = 1'b0;
		result_ID_Flush = 1'b1;
	end else begin
		result_PC_Write = 1'b1;
		result_IF_ID_Write = 1'b1;
		result_ID_Flush = 1'b0;
	end
	//branch
	if(PCSrc)begin
		result_IF_Flush = 1'b1;
		result_ID_Flush = 1'b1;
		result_EX_Flush = 1'b1;
	end
end

assign PC_Write = result_PC_Write;
assign IF_ID_Write = result_IF_ID_Write;
assign IF_Flush = result_IF_Flush;
assign ID_Flush = result_ID_Flush;
assign EX_Flush = result_EX_Flush;

endmodule	
