// Name: logic_32_bit.v
// Module: 
// Input: 
// Output: 
//
// Notes: Common definitions
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 02, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//

// 32-bit NOR
module NOR32_2x1(Y,A,B);
//output 
output [31:0] Y;
//input
input [31:0] A;
input [31:0] B;

// TBD
genvar i;
generate
	for(i = 0; i<32; i=i+1) begin : nor_loop
		nor init(Y[i], A[i],B[i]);
	end
endgenerate
endmodule

// 32-bit AND
module AND32_2x1(Y,A,B);
//output 
output [31:0] Y;
//input
input [31:0] A;
input [31:0] B;

// TBD
genvar i;
generate
	for(i = 0; i <32; i=i+1) begin: AND32_2x1_loop
		and init(Y[i], A[i], B[i]);
		end
endgenerate

endmodule

// 32-bit inverter
module INV32_1x1(Y,A);
//output 
output [31:0] Y;
//input
input [31:0] A;

// TBD
genvar i;
generate
	for(i = 0; i<32; i= i +1) begin : inv_loop
		not init(Y[i], A[i]);
	end
endgenerate
endmodule

// 32-bit OR
module OR32_2x1(Y,A,B);
//output 
output [31:0] Y;
//input
input [31:0] A;
input [31:0] B;

// TBD
genvar i;
generate
	for(i =0; i<32; i=i+1) begin : or_loop
		or init(Y[i], A[i],B[i]);
	end
endgenerate
endmodule

//32 bit buffer
module BUF32_2x1(out, in);

input [31:0] in;

output [31:0] out;

genvar i;
generate
	for(i = 0; i<32; i =i + 1) begin : loop
		buf b(out[i], in[i]);
	end
endgenerate
endmodule

