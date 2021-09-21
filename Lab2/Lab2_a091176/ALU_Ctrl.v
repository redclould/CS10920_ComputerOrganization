//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns/1ps
module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
//reg        [4-1:0] ALUCtrl_o;

//Parameter
reg        [4-1:0] result;
       
//Select exact operation
always@(*)begin
	if(ALUOp_i == 3'b010)begin
        case(funct_i)
        6'd32: result <= 4'b0010;  //add
        6'd34: result <= 4'b0110;  //sub
        6'd36: result <= 4'b0000;  //and
        6'd37: result <= 4'b0001;  //or
        6'd42: result <= 4'b0111;  //slt
       endcase
	end 
	if(ALUOp_i == 3'b001) result <= 4'b0110;  //sub
    if(ALUOp_i == 3'b101) result <= 4'b0010;  //add
	if(ALUOp_i == 3'b110) result <= 4'b0111;  //slt
end

assign ALUCtrl_o = result;

endmodule     





                    
                    