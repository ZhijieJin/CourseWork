// Declare a carry_lookahead_adder that adds two 16-bit inputs(A and B)\
// The sum of two inputs are stored in Sum
// The carry out bit is stored in CO
module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	 
	
	logic C0, C4, C8, C12;	// intermedian carry out bits from the look-ahead unit
	logic P0, P4, P8, P12;	// propogating bits from the 4-bit carry-lookahead-adder
	logic G0, G4, G8, G12;	// generated bits from the 4-bit carry-lookahead-adder
	
	// Generating the 16-bit carry-lookahead-adder from four 4-bit cla
	assign C0 = 0; // First carry in is 0
	four_bit_cla CLA0(.A(A[3 : 0]), .B(B[3 : 0]), .Cin(C0 ), .S(Sum[3 : 0]), .P(P0 ), .G(G0 ));
	
	// Get carry in for the second cla from carry lookahead unit and previous carry in bit.
	assign C4  = G0 | (C0 & P0); 
	four_bit_cla CLA1(.A(A[7 : 4]), .B(B[7 : 4]), .Cin(C4 ), .S(Sum[7 : 4]), .P(P4 ), .G(G4 ));
	
	// Get carry in for the third cla from carry lookahead unit and previous carry in bit.
	assign C8  = G4 | (G0 & P4) | (C0 & P0 & P4);
	four_bit_cla CLA2(.A(A[11: 8]), .B(B[11: 8]), .Cin(C8 ), .S(Sum[11: 8]), .P(P8 ), .G(G8 ));
	
	// Get carry in for the fourth cla from carry lookahead unit and previous carry in bit.
	assign C12 = G8 | (G4 & P8) | (G0 & P8 & P4) | (C0 & P8 & P4 & P0);
	four_bit_cla CLA3(.A(A[15:12]), .B(B[15:12]), .Cin(C12), .S(Sum[15:12]), .P(P12), .G(G12));
	
	// Calculating the Carry-out bit
	assign CO  = P12 & C12;
	  
     
endmodule


// 4-bit carry lookahead adder that takes two 4-bit inputs(A and B) and add them
// Carry-in is stored in Cin
// Sum is stored in S
// propagating bit and generated bits are stored in P and G respectively
module four_bit_cla(
						  input  [3:0]A,
						  input  [3:0]B,
						  input  Cin,
						  output [3:0]S,
						  output P,
						  output G
						  );
			
	logic C0, C1, C2, C3;	// intermedian carry out bits from the look-ahead unit
	logic P0, P1, P2, P3;	// propogating bits from the 4-bit carry-lookahead-adder
	logic G0, G1, G2, G3;	// generated bits from the 4-bit carry-lookahead-adder
	
	// Generating the 4-bit carry-lookahead-adder from four 1-bit cla
	assign C0 = Cin;	// First carry in is 0
	one_bit_cla cla0(.A(A[0]), .B(B[0]), .Cin(C0), .S(S[0]), .P(P0), .G(G0));
	
	// Get carry in for the second cla from carry lookahead unit and previous carry in bit.
	assign C1 = (Cin & P0) | G0;
	one_bit_cla cla1(.A(A[1]), .B(B[1]), .Cin(C1), .S(S[1]), .P(P1), .G(G1));
	
	// Get carry in for the third cla from carry lookahead unit and previous carry in bit.
	assign C2 = (Cin & P0 & P1) | (G0 & P1) | G1;
	one_bit_cla cla2(.A(A[2]), .B(B[2]), .Cin(C2), .S(S[2]), .P(P2), .G(G2));
	
	// Get carry in for the fourth cla from carry lookahead unit and previous carry in bit.
	assign C3 = (Cin & P0 & P1 & P2) | (G0 & P1 & P2) | (G1 & P2) | G2;
	one_bit_cla cla3(.A(A[3]), .B(B[3]), .Cin(C3), .S(S[3]), .P(P3), .G(G3));
	
	// Calculating the propagating bit and generated bit
	assign P = P0 & P1 & P2 & P3;
	assign G = G3 | (G2 & P3) | (G1 & P3 & P2) + (G0 & P3 & P2 & P1);
			
endmodule 


// 1-bit carry lookahead adder that takes two 1-bit inputs(A and B) and add them
// Carry-in is stored in Cin
// Sum is stored in S
// propagating bit and generated bits are stored in P and G respectively
module one_bit_cla(
						 input  A, B,
						 input  Cin,
						 output S,
						 output P, G
						 );

	assign S = A^B^Cin; 	// Calculating sum of the inputs
	assign P = A^B;		// Calculating propagating bit
	assign G = A&B;		// Calculating generated bit
			
endmodule 