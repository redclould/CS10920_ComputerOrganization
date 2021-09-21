`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 04:19:46
// Design Name: 
// Module Name: Adder
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


module Adder(
        src1_i,
        src2_i,
        sum_o
         );
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
output [32-1:0]	 sum_o;

//Internal Signals
wire    [32-1:0]	 sum_o;
wire [31:0] carry_in ;
wire carry_out;

//Parameter
    
//Main function
	Full_adder h0(sum_o[0], carry_in[1], 1'b0, src1_i[0], src2_i[0]);
	Full_adder h1(sum_o[1], carry_in[2], carry_in[1], src1_i[1], src2_i[1]);
	Full_adder h2(sum_o[2], carry_in[3], carry_in[2], src1_i[2], src2_i[2]);
	Full_adder h3(sum_o[3], carry_in[4], carry_in[3], src1_i[3], src2_i[3]);
	Full_adder h4(sum_o[4], carry_in[5], carry_in[4], src1_i[4], src2_i[4]);
	Full_adder h5(sum_o[5], carry_in[6], carry_in[5], src1_i[5], src2_i[5]);
	Full_adder h6(sum_o[6], carry_in[7], carry_in[6], src1_i[6], src2_i[6]);
	Full_adder h7(sum_o[7], carry_in[8], carry_in[7], src1_i[7], src2_i[7]);
	Full_adder h8(sum_o[8], carry_in[9], carry_in[8], src1_i[8], src2_i[8]);
	Full_adder h9(sum_o[9], carry_in[10], carry_in[9], src1_i[9], src2_i[9]);
	Full_adder h10(sum_o[10], carry_in[11], carry_in[10], src1_i[10], src2_i[10]);
	Full_adder h11(sum_o[11], carry_in[12], carry_in[11], src1_i[11], src2_i[11]);
	Full_adder h12(sum_o[12], carry_in[13], carry_in[12], src1_i[12], src2_i[12]);
	Full_adder h13(sum_o[13], carry_in[14], carry_in[13], src1_i[13], src2_i[13]);
	Full_adder h14(sum_o[14], carry_in[15], carry_in[14], src1_i[14], src2_i[14]);
	Full_adder h15(sum_o[15], carry_in[16], carry_in[15], src1_i[15], src2_i[15]);
	Full_adder h16(sum_o[16], carry_in[17], carry_in[16], src1_i[16], src2_i[16]);
	Full_adder h17(sum_o[17], carry_in[18], carry_in[17], src1_i[17], src2_i[17]);
	Full_adder h18(sum_o[18], carry_in[19], carry_in[18], src1_i[18], src2_i[18]);
	Full_adder h19(sum_o[19], carry_in[20], carry_in[19], src1_i[19], src2_i[19]);
	Full_adder h20(sum_o[20], carry_in[21], carry_in[20], src1_i[20], src2_i[20]);
	Full_adder h21(sum_o[21], carry_in[22], carry_in[21], src1_i[21], src2_i[21]);
	Full_adder h22(sum_o[22], carry_in[23], carry_in[22], src1_i[22], src2_i[22]);
	Full_adder h23(sum_o[23], carry_in[24], carry_in[23], src1_i[23], src2_i[23]);
	Full_adder h24(sum_o[24], carry_in[25], carry_in[24], src1_i[24], src2_i[24]);
	Full_adder h25(sum_o[25], carry_in[26], carry_in[25], src1_i[25], src2_i[25]);
	Full_adder h26(sum_o[26], carry_in[27], carry_in[26], src1_i[26], src2_i[26]);
	Full_adder h27(sum_o[27], carry_in[28], carry_in[27], src1_i[27], src2_i[27]);
	Full_adder h28(sum_o[28], carry_in[29], carry_in[28], src1_i[28], src2_i[28]);
	Full_adder h29(sum_o[29], carry_in[30], carry_in[29], src1_i[29], src2_i[29]);
	Full_adder h30(sum_o[30], carry_in[31], carry_in[30], src1_i[30], src2_i[30]);
	Full_adder h31(sum_o[31], carry_out, carry_in[31], src1_i[31], src2_i[31]);
    
endmodule
