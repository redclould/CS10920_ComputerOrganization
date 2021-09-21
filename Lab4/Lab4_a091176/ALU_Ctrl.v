`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 02:35:37
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control(
        funct_i,
        ALUOp_i,
        ALUCtrl_o
        );
        
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl;

//Parameter

//Select exact operation
always@(*)begin
    case(ALUOp_i)
        3'b000: 
            begin
            case(funct_i)
                6'd24: ALUCtrl = 4'b0011;  //mult
                6'd32: ALUCtrl = 4'b0010;  //add
                6'd34: ALUCtrl = 4'b0110;  //sub
                6'd36: ALUCtrl = 4'b0000;  //and
                6'd37: ALUCtrl = 4'b0001;  //or
                6'd42: ALUCtrl = 4'b0111;  //slt
                default: ALUCtrl = 4'b0000;
            endcase
            end
	    3'b001: ALUCtrl = 4'b0010; //lw.sw
	    3'b010: ALUCtrl = 4'b0110; //beq
	    3'b011: ALUCtrl = 4'b0010; //addi
	    3'b100: ALUCtrl = 4'b0111; //slti
	    3'b101: ALUCtrl = 4'b0000; //jump
	endcase
end

assign ALUCtrl_o = ALUCtrl;
        
endmodule
