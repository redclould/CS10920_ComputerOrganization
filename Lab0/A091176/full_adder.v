`timescale 1ns / 1ps

module Full_Adder(
    In_A, In_B, Carry_in, Sum, Carry_out
    );
    input In_A, In_B, Carry_in;
    output Sum, Carry_out;

    
	// implement full adder circuit, your code starts from here.
	// use half adder in this module, fulfill I/O ports connection.
	wire had1_sum;
    wire had1_carry;
    wire had2_carry;

    Half_Adder HAD1 (
        .In_A(In_A),
        .In_B(In_B),
        .Sum(had1_sum),
        .Carry_out(had1_carry)
    );
    Half_Adder HAD2 (
        .In_A(had1_sum),
        .In_B(Carry_in),
        .Sum(Sum),
        .Carry_out(had2_carry)
    );  
    
   or(Carry_out, had1_carry, had2_carry); 
    
endmodule
