`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/26 23:03:47
// Design Name: 
// Module Name: alu_31
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


module alu_31(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
			   set,
			   cout
    );
    
    
input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output		  set; //to alu_top0
output		  cout;

reg			  set; 
reg           result;
reg			  cout;
reg   		  a, b;

always@(*)
begin
	a = ((src1) & (~A_invert)) | ((~src1) & (A_invert));
	b = ((src2) & (~B_invert)) | ((~src2) & (B_invert));
	
	case(operation[2-1:0])
	   2'b00: //AND
	   begin
	       result = a & b;
		   cout = 1'b0;
	   end
	   2'b01: //OR
	   begin
	       result = a | b;
		   cout = 1'b0;
	   end
	   2'b10: //ADD
	   begin
	       result =  a ^ b ^ cin;
		   cout = (a & b) | (cin & a) | (cin & b);
	   end
	   2'b11: //SLT
	   begin
	       result = less;
	       set = (a & b) | (cin & a) | (cin & b);
		   cout = (a & b) | (cin & a) | (cin & b);
	   end
    endcase
end
    
endmodule
