//Subject:     CO project 2 - Simple Single CPU
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
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire	    [31:0]	pc_in;
wire 	[31:0]	pc_out;
wire 	[31:0]	instr;
wire 	[31:0]	pc_add4;
wire	    [31:0]	pc_add4_SESL;
wire         	Branch;
wire    	[1:0]	BranchType; 
wire 	[31:0]	readData1;
wire 	[31:0]	readData2;
wire    	[1:0]	MemToReg;
wire			    MemRead; 
wire			    MemWrite; 
wire 	[2:0]	ALUOp; 
wire         	ALUSrc; 
wire 	[3:0]	ALUCtrl;
wire 	[31:0]	ALUSrc_Data;
wire    	[31:0]	ALUResult;
wire         	RegWrite; 
wire	    [1:0]  	RegDst;  
wire 	[31:0]	SignExtend;
wire	    [27:0]	instrShiftLeft;
wire    	[31:0]	SignExtendShiftLeft;

wire 	[4:0]	WriteReg;
wire 	[31:0]	WriteRegData;
wire    	[31:0]	ReadData;

wire	            zero;
wire			    Jump; 
wire    	[31:0]	Jump1_in;
wire	    [31:0]	Jump0_in;
wire	    [31:0]	Jump_out;
wire			    JumpRegister; 

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in),   
	    .pc_out_o(pc_out) 
	    );
	
Adder Adder1(
        .src1_i(pc_out),     
	    .src2_i(32'd4),     
	    .sum_o(pc_add4)    
	    );
		
PC_instr PC_instr(
	.instr(instrShiftLeft),
	.pc(pc_add4),
	.PC_instr_o(Jump0_in)
    );
	
Shift_Left_Two_32 #(.size(28)) Shifter(
        .data_i(instr[25:0]),
        .data_o(instrShiftLeft)
        ); 		
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instr)    
	    );

MUX_3to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
		.data2_i(5'b11111), //31
        .select_i(RegDst),
        .data_o(WriteReg)
        );	
		
Reg_File Registers(
        .clk_i(clk_i),      
	    .rst_i(rst_i),     
        .RSaddr_i(instr[25:21]),  
        .RTaddr_i(instr[20:16]),  
        .RDaddr_i(WriteReg),  
        .RDdata_i(WriteRegData), 
        .RegWrite_i(RegWrite),
        .RSdata_o(readData1),  
        .RTdata_o(readData2)   
        );
	
Decoder Decoder(
	.instr_op_i(instr[31:26]), 
	.instr2_op_i(instr[5:0]), 
    .Branch(Branch), 
	.MemToReg(MemToReg), 
	.BranchType(BranchType), 
	.Jump(Jump), 
	.MemRead(MemRead), 
	.MemWrite(MemWrite), 
	.ALUOp(ALUOp), 
	.ALUSrc(ALUSrc), 
	.RegWrite(RegWrite), 
	.RegDest(RegDst), 
	.JumpRegister(JumpRegister)
	);

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALUCtrl) 
        );
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(SignExtend[31:0])
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(readData2[31:0]),
        .data1_i(SignExtend[31:0]),
        .select_i(ALUSrc),
        .data_o(ALUSrc_Data[31:0])
        );	
		
ALU ALU(
        .src1_i(readData1),
	    .src2_i(ALUSrc_Data),
	    .ctrl_i(ALUCtrl),
	    .result_o(ALUResult),
		.zero_o(zero)
	    );
	
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(ALUResult),
	.data_i(readData2),
	.MemRead_i(MemRead),
	.MemWrite_i(MemWrite),
	.data_o(ReadData)
	);
	
Adder Adder2(
        .src1_i(pc_add4),     
	    .src2_i(SignExtendShiftLeft),     
	    .sum_o(pc_add4_SESL)      
	    );
		
Shift_Left_Two_32 #(.size(32)) Shifter1(
        .data_i(SignExtend),
        .data_o(SignExtendShiftLeft)
        ); 		
		
MUX_3to1 #(.size(32)) Mux_Mem_To_Reg(
        .data0_i(ALUResult),
        .data1_i(ReadData),
		.data2_i(pc_add4),
        .select_i(MemToReg),
        .data_o(WriteRegData)
        );	

MUX_2to1 #(.size(32)) Mux_A(
        .data0_i(pc_add4),
        .data1_i(pc_add4_SESL),
        .select_i(Branch&zero), //PCSrc
        .data_o(Jump1_in)
        );	

MUX_2to1 #(.size(32)) Mux_Jump(
        .data0_i(Jump0_in),
        .data1_i(Jump1_in),
        .select_i(Jump),
        .data_o(Jump_out)
        );	
		
MUX_2to1 #(.size(32)) Mux_Jump_Register( //jal
        .data0_i(Jump_out),
        .data1_i(readData1),
        .select_i(JumpRegister),
        .data_o(pc_in)
        );			
		
endmodule