// Name: rc_add_sub_32.v
// Module: RC_ADD_SUB_32
//
// Output: Y : Output 32-bit
//         CO : Carry Out
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//        SnA : if SnA=0 it is add, subtraction otherwise
//
// Notes: 32-bit adder / subtractor implementaiton.
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module RC_ADD_SUB_64(Y, CO, A, B, SnA);
// output list
output [63:0] Y;
output CO;
// input list
input [63:0] A;
input [63:0] B;
input SnA;

wire [63:0] xorResult, CI;


//TBD

genvar i;
generate
	for(i =0; i<64; i =i +1) begin : rc_add_sub_64_loop
	xor xorInst(xorResult[i], SnA, B[i]);
	if(i != 0 && i !=63) 
		begin
			FULL_ADDER f(Y[i], CI[i], A[i], xorResult[i], CI[i-1]);
		end
	else if(i==0)
		begin
			FULL_ADDER f(Y[i], CI[i], A[i], xorResult[i], SnA);
		end
	else if(i==63)
		begin
			FULL_ADDER f(Y[i], CO, A[i], xorResult[i], CI[i-1]);
		end
end
endgenerate


endmodule


//FULL_ADDER(S,CO,A,B, CI);
module RC_ADD_SUB_32(Y, CO, A, B, SnA);
// output list
output [`DATA_INDEX_LIMIT:0] Y;
output CO;
// input list
input [`DATA_INDEX_LIMIT:0] A;
input [`DATA_INDEX_LIMIT:0] B;
input SnA;

wire [31:0] xorResult,CI;
// TBD
genvar i;
generate
	for(i = 0; i<32; i=i+1) begin: rc_add_sub_32_loop
	xor xorInst(xorResult[i], SnA, B[i]);
	if(i != 0 && i !=31) 
		begin
			FULL_ADDER f(Y[i], CI[i], A[i], xorResult[i], CI[i-1]);
		end
	else if(i==0)
		begin
			FULL_ADDER f(Y[i], CI[i], A[i], xorResult[i], SnA);
		end
	else if(i==31)
		begin
			FULL_ADDER f(Y[i], CO, A[i], xorResult[i], CI[i-1]);
		end
end
endgenerate

endmodule

