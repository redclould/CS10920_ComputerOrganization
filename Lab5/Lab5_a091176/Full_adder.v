`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 02:41:04
// Design Name: 
// Module Name: Full_adder
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


module Full_adder(
        sum, 
        carryOut, 
        carryIn, 
        input1, 
        input2
        );
        
    
input carryIn, input1, input2;

output sum, carryOut;

wire w1, w2, w3;

xor x1(w1, input1, input2);
xor x2(sum, w1, carryIn);
and a1(w2, input1, input2);
and a2(w3, w1, carryIn);
or o1(carryOut, w2, w3);            
endmodule
