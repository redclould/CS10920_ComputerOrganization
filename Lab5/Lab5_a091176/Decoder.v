//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:      
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
        instr_op_i,
        Branch,
        MemToReg,
        MemRead,
        MemWrite,
        ALUOp,
        ALUSrc,
        RegWrite,
        RegDest,
        BranchType
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
output	[1:0]	BranchType;

wire            rtype, addi, slti, lw, sw, beq, bne, bgt, jump, jal;
reg     [3-1:0] ALUOp;
reg     [2-1:0] BranchType;

//Main function
always@(instr_op_i)begin
    case(instr_op_i[5:0])
        6'b000000: ALUOp  <= 3'b000; //R-type
        6'b001000: ALUOp  <= 3'b011; //addi
        6'b001010: ALUOp  <= 3'b100; //slti
        6'b100011: ALUOp  <= 3'b001; //lw
        6'b101011: ALUOp  <= 3'b001; //sw
        6'b000100: ALUOp  <= 3'b010; //beq
        6'b000101: ALUOp  <= 3'b010; //bne
        6'b000001: ALUOp  <= 3'b010; //bge
        6'b000111: ALUOp  <= 3'b010; //bgt
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
assign bne = (instr_op_i == 6'b000101);
assign bge = (instr_op_i == 6'b000001);
assign bgt = (instr_op_i == 6'b000111);
assign jump = (instr_op_i == 6'b000010);
assign jal = (instr_op_i == 6'b000011);

assign ALUSrc = (lw | sw | addi | slti);
assign MemToReg = (rtype | addi);   
assign MemRead = lw;
assign MemWrite = sw;
assign RegWrite = ~(sw | jump | beq | bne | bge | bgt);
assign RegDest = rtype;
assign Branch = (beq | bne | bge | bgt);
     
always@(instr_op_i)begin
    case(instr_op_i[5:0])
        6'b000100: BranchType  <= 2'b00; //beq
        6'b000101: BranchType  <= 2'b11; //bne
        6'b000001: BranchType  <= 2'b10; //bge
        6'b000111: BranchType  <= 2'b01; //bgt
    endcase
end     
                
//assign BranchType[1] = ((~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (instr_op_i[2]) & (~instr_op_i[1]) & (instr_op_i[0]))   //bne
//                     | ((~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (~instr_op_i[2]) & (~instr_op_i[1]) & (instr_op_i[0])); //bge
//assign BranchType[0] = ((~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (instr_op_i[2]) & (~instr_op_i[1]) & (instr_op_i[0]))   //bne
//                     | ((~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (instr_op_i[2]) & (instr_op_i[1]) & (instr_op_i[0]));   //bgt

endmodule
