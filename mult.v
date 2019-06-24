// Name: mult.v
// Module: MULT32 , MULT32_U
//
// Output: HI: 32 higher bits
//         LO: 32 lower bits
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//
// Notes: 32-bit multiplication
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module MULT32(HI, LO, A, B);
// output list
output [31:0] HI;
output [31:0] LO;
// input list
input [31:0] A;
input [31:0] B;

// TBD
wire [63:0] uMultResult, twosCompliment, result;
wire [31:0] mux1, mux2;
wire xorWire;
wire [31:0] twosComp1, twosComp2;

xor xorInit(xorWire, A[31], B[31]);

TWOSCOMP32 t(twosComp1, A);
TWOSCOMP32 t1(twosComp2, B);

MUX32_2x1 m(mux1, A,twosComp1, A[31]);
MUX32_2x1 m1(mux2, B,twosComp2, B[31]);

MULT32_U mul(uMultResult[63:32], uMultResult[31:0], mux1, mux2);

TWOSCOMP64 t2(twosCompliment, uMultResult);

MUX64_2x1 m2(result, uMultResult,twosCompliment, xorWire);

BUF32_2x1 b(LO, result[31:0]);
BUF32_2x1 b1(HI, result[63:32]);


endmodule

module MULT32_U(HI, LO, A, B);
// output list
output [31:0] HI;
output [31:0] LO;
// input list
input [31:0] A;
input [31:0] B;

// TBD

wire CO [31:0];
wire [31:0] resultWire [31:0];

AND32_2x1 aInit(resultWire[0], A, {32{B[0]}});
buf b1(CO[0], 1'b0);
buf b2(LO[0], resultWire[0][0]);


genvar i;
generate 
	for(i = 1; i<32; i = i+1) begin : loop
		wire [31:0] rWire;
		AND32_2x1 leftAnd(rWire, A, {32{B[i]}});
		RC_ADD_SUB_32 r(resultWire[i], CO[i], rWire, {CO[i-1], {resultWire[i-1][31:1]}}, 1'b0);
		buf b(LO[i], resultWire[i][0]);
	end
endgenerate

BUF32_2x1 b3(HI, {CO[31],{resultWire[31][31:1]}});
endmodule
