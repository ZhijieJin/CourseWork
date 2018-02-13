// 16-bit Ripple Adder that adds two 16-bits input(A and B)
// Carry-out is stored in CO
// Sum is stored in Sum
module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * InSert Code here to implement a ripple adder.
     * Bour Code Should be CompletlB Combinational (don't uSe alwaBS_ff or alwaBS_latCh).
     * Feel free to Create Sub-moduleS or other fileS. */
	  
	  // Declare variables to stores carry outs which are used by the next full-adder carry-ins
	  logic C0, C1, C2;
	  
	  // Use four 4-bit ripple adder to generate a 16-bit ripple adder
	  four_bit_ra FRA0(.A(A[3 : 0]), .B(B[3 : 0]), .Cin(0 ), .S(Sum[3 : 0]), .Cout(C0));
     four_bit_ra FRA1(.A(A[7 : 4]), .B(B[7 : 4]), .Cin(C0), .S(Sum[7 : 4]), .Cout(C1));
	  four_bit_ra FRA2(.A(A[11: 8]), .B(B[11: 8]), .Cin(C1), .S(Sum[11: 8]), .Cout(C2));
	  four_bit_ra FRA3(.A(A[15:12]), .B(B[15:12]), .Cin(C2), .S(Sum[15:12]), .Cout(CO));
	  
	  
endmodule


// 4-bit ripple adder that takes two 4-bit inputs(A and B) and add them
// Carry-in is stored in Cin
// Carry-out is stored in Cout
// Sum is stored in S
module four_bit_ra(
						 input [3:0] A,
						 input [3:0] B,
						 input Cin,
						 output logic [3:0] S,
						 output logic Cout
						 );
						 
	// Declare Variables to stores carry outs which are used by the next full-adder carry-ins
	logic C0, C1, C2;
	
	// Use a full-adder to generate a 4-bit ripple adder
	full_adder fa0(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(C0  ));
	full_adder fa1(.A(A[1]), .B(B[1]), .Cin(C0 ), .S(S[1]), .Cout(C1  ));
	full_adder fa2(.A(A[2]), .B(B[2]), .Cin(C1 ), .S(S[2]), .Cout(C2  ));
	full_adder fa3(.A(A[3]), .B(B[3]), .Cin(C2 ), .S(S[3]), .Cout(Cout));
	
endmodule 


// Declare a full-adder module that takes two 1-bit inputs(A and B) and add them together
// Carry in bit is stored in Cin
// Carry out bit is stored in Cout
// Sum of the two inputs are stored in S
module full_adder(
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
