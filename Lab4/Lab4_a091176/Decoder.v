`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 02:34:06
// Design Name: 
// Module Name: Decoder
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


module Decoder(
        instr_op_i,
        Branch,
        MemToReg,
        MemRead,
        MemWrite,
        ALUOp,
        ALUSrc,
        RegWrite,
        RegDest
        );

//I/O ports
input  [5:0] 	instr_op_i;

output         	Branch;
output			MemToReg;
output			MemRead;
output			MemWrite;
output 	[2:0]	ALUOp;
output         	ALUSrc;
output         	RegWrite;
output	     	RegDest; 

wire            rtype, addi, slti, lw, sw, beq, bne, bgt, jump;
reg     [3-1:0] ALUOp;

//Main function
always@(instr_op_i)begin
    case(instr_op_i[5:0])
        6'b000000: ALUOp  <= 3'b000; //Rtype
        6'b001000: ALUOp  <= 3'b011; //addi
        6'b001010: ALUOp  <= 3'b100; //slti
        6'b100011: ALUOp  <= 3'b001; //lw
        6'b101011: ALUOp  <= 3'b001; //sw
        6'b000100: ALUOp  <= 3'b010; //beq
        6'b000010: ALUOp  <= 3'b101; //jump
    endcase
end

assign rtype = (instr_op_i == 6'b000000);
assign addi = (instr_op_i == 6'b001000);
assign slti = (instr_op_i == 6'b001010);
assign lw = (instr_op_i == 6'b100011);
assign sw = (instr_op_i == 6'b101011);
assign beq = (instr_op_i == 6'b000100);
assign jump = (instr_op_i == 6'b000010);

assign ALUSrc = (lw | sw | addi | slti);
assign MemToReg = (rtype | addi);   
assign MemRead = lw;
assign MemWrite = sw;
assign RegWrite = ~(sw | jump | beq);
assign RegDest = rtype;
assign Branch = beq;

endmodule
