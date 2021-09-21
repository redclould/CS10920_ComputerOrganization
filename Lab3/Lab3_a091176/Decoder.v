//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
        instr_op_i,
        instr2_op_i,
        Branch,
        MemToReg,
        BranchType,
        Jump,
        MemRead,
        MemWrite,
        ALUOp,
        ALUSrc,
        RegWrite,
        RegDest,
        JumpRegister
        );
     
//I/O ports
input  [5:0] 	instr_op_i;
input  [5:0] 	instr2_op_i;

output         	Branch;
output	[1:0]	MemToReg;
output	[1:0]	BranchType;
output			Jump;
output			MemRead;
output			MemWrite;
output 	[2:0]	ALUOp;
output         	ALUSrc;
output         	RegWrite;
output	[1:0]  	RegDest; 
output			JumpRegister;

wire            rtype, addi, slti, lw, sw, beq, jump, jal;
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
        6'b000011: ALUOp  <= 3'b101; //jal
    endcase
end

assign rtype = (instr_op_i == 6'b000000);
assign addi = (instr_op_i == 6'b001000);
assign slti = (instr_op_i == 6'b001010);
assign lw = (instr_op_i == 6'b100011);
assign sw = (instr_op_i == 6'b101011);
assign beq = (instr_op_i == 6'b000100);
assign jump = (instr_op_i == 6'b000010);
assign jal = (instr_op_i == 6'b000011);

assign ALUSrc = (lw | sw | addi | slti);
assign RegWrite = ~(sw | jump | beq);
assign RegDest[1] = jal;
assign RegDest[0] = rtype;
assign MemRead = lw;
assign MemWrite = sw;
assign MemToReg[1] = jal;
assign MemToReg[0] = (lw | slti);
assign Branch = beq;
assign BranchType[1] = instr_op_i[4]; //beq
assign BranchType[0] = instr_op_i[4];
assign Jump = ~(jump | jal);

//assign JumpRegister = (rtype & addi);
assign JumpRegister = ((~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (~instr_op_i[2]) & (~instr_op_i[1]) & (~instr_op_i[0])) //Rtype
                    & ((~instr2_op_i[5]) & (~instr2_op_i[4]) & (instr2_op_i[3]) & (~instr2_op_i[2]) & (~instr2_op_i[1]) & (~instr2_op_i[0]));

endmodule