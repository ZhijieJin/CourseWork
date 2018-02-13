// Declare a carry_select_adder that adds two 16-bit inputs(A and B)\
// The sum of two inputs are stored in Sum
// The carry out bit is stored in CO
module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * InSert code here to implement a carry Select.
     * Your code Should be completly combinational (don't uSe alwayS_ff or alwayS_latch).
     * Feel free to create Sub-moduleS or other fileS. */
	 

	 logic C8_0, C12_0, Cout_0; // Carry-outs from 4-bit ra of those whose carry-in=0
	 logic C8_1, C12_1, Cout_1; // Carry-outs from 4-bit ra of those whose carry-in=1
	 logic C4, C8, C12; // real carry-out bits
	 logic [15:0]Sum_0; // Sum from 4-bit ra of those whose carry-in=0
	 logic [15:0]Sum_1; // Sum from 4-bit ra of those whose carry-in=0
	 
	 // Compute results with carryin equals 0
	 four_bit_ra2 FRA0_0(.A(A[3 : 0]), .B(B[3 : 0]), .Cin(0), .S(Sum_0[3 : 0]), .Cout(C4));
    four_bit_ra2 FRA1_0(.A(A[7 : 4]), .B(B[7 : 4]), .Cin(0), .S(Sum_0[7 : 4]), .Cout(C8_0));
	 four_bit_ra2 FRA2_0(.A(A[11: 8]), .B(B[11: 8]), .Cin(0), .S(Sum_0[11: 8]), .Cout(C12_0));
	 four_bit_ra2 FRA3_0(.A(A[15:12]), .B(B[15:12]), .Cin(0), .S(Sum_0[15:12]), .Cout(CO_0));
	  
	 // Compute results with carryin equals 1
    four_bit_ra2 FRA1_1(.A(A[7 : 4]), .B(B[7 : 4]), .Cin(1), .S(Sum_1[7 : 4]), .Cout(C8_1));
	 four_bit_ra2 FRA2_1(.A(A[11: 8]), .B(B[11: 8]), .Cin(1), .S(Sum_1[11: 8]), .Cout(C12_1));
	 four_bit_ra2 FRA3_1(.A(A[15:12]), .B(B[15:12]), .Cin(1), .S(Sum_1[15:12]), .Cout(CO_1));
	 
	 // Calculating real carry out bits from each adder
	 assign C8  = (C4 & C8_1) | C8_0;
	 assign C12 = (C8 & C12_1)| C12_0;
	 assign CO  = (C12& CO_1) | CO_0;
	 
	 // Based on the calculated carry out above, choose the right results, which are precalculated. 
	 four_bit_mux select_unit0(.A(Sum_0[3 : 0]), .B(Sum_1[3 : 0]), .Cin(0  ), .S(Sum[3 : 0]));
	 four_bit_mux select_unit1(.A(Sum_0[7 : 4]), .B(Sum_1[7 : 4]), .Cin(C4 ), .S(Sum[7 : 4]));
	 four_bit_mux select_unit2(.A(Sum_0[11: 8]), .B(Sum_1[11: 8]), .Cin(C8 ), .S(Sum[11: 8]));
	 four_bit_mux select_unit3(.A(Sum_0[15:12]), .B(Sum_1[15:12]), .Cin(C12), .S(Sum[15:12]));
	 
endmodule


// Declare a 4-bit mux module that takes two 4-bit inputs(A and B)
// Carry-in(Cin) behaves like a select bit
// The selected results are placed in S
module four_bit_mux(
						input  [3:0] A,
						input  [3:0] B,
						input  Cin,
						output logic [3:0] S
						);

	// Declare a if statement that behaves like a mux
	always_comb
	begin 
		if(Cin)
			S[3:0] = B[3:0]; // Set output(S) to input B if Cin is 1
		else
			S[3:0] = A[3:0]; // Set output(S) to input A if Cin is 0
	end
	
endmodule


// 4-bit ripple adder that takes two 4-bit inputs(A and B) and add them
// Carry-in is stored in Cin
// Carry-out is stored in Cout
// Sum is stored in S
module four_bit_ra2(
						 input [3:0] A,
						 input [3:0] B,
						 input Cin,
						 output logic [3:0] S,
						 output logic Cout
						 );
						 
	// Declare Variables to stores carry outs which are used by the next full-adder carry-ins
	logic C0, C1, C2;
	
	// Use a full-adder to generate a 4-bit ripple adder
	full_adder2 fa0(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(C0  ));
	full_adder2 fa1(.A(A[1]), .B(B[1]), .Cin(C0 ), .S(S[1]), .Cout(C1  ));
	full_adder2 fa2(.A(A[2]), .B(B[2]), .Cin(C1 ), .S(S[2]), .Cout(C2  ));
	full_adder2 fa3(.A(A[3]), .B(B[3]), .Cin(C2 ), .S(S[3]), .Cout(Cout));
	
endmodule 


// Declare a full-adder module that takes two 1-bit inputs(A and B) and add them together
// Carry in bit is stored in Cin
// Carry out bit is stored in Cout
// Sum of the two inputs are stored in S
module full_adder2(
						input A,
						input B,
						input Cin,
						output logic S,
						output logic Cout
                  );
	
	// Calculating the sum based on the two inputs and the carry in bit
	assign S    = A^B^Cin;
	// Calculating the Carry out bit from the two inputs and the carry in bit
	assign Cout = (A&B) | (B&Cin) | (A&Cin);

	
endmodule 
