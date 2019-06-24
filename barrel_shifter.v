// Name: barrel_shifter.v
// Module: SHIFT32_L , SHIFT32_R, SHIFT32
//
// Notes: 32-bit barrel shifter
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

// 32-bit shift amount shifter
module SHIFT32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [31:0] S;
input LnR;

// TBD
wire [31:0] barrelShift, orWire, test;
wire control;

OR32_2x1 r(orWire, 32'b0, {5'b0, S[31:5]});
BARREL_SHIFTER32 b(barrelShift, D, S[4:0], LnR);

genvar i;
generate
	for(i = 0; i <32; i = i+1)
	begin : or_loop
		if(i == 31) begin
			or r(control, test[i -1], 1'b0);
		end else if (i == 0) begin
			or r2(test[i], 1'b0, orWire[i]);
		end else begin
			or r1(test[i], test[i-1], orWire[i]);
		end
	end
endgenerate

MUX32_2x1 m(Y, barrelShift, 1'b0, control);

endmodule

// Shift with control L or R shift
module BARREL_SHIFTER32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;
input LnR;

//TBD
wire [31:0] rWire, lWire;

SHIFT32_R r(rWire, D, S);
SHIFT32_L l(lWire, D, S);

MUX32_2x1 m(Y, rWire, lWire, LnR);



endmodule

// Right shifter
module SHIFT32_R(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;

// TBD
wire muxResult [3:0][31:0];

genvar i, j, k , l;
generate
	for(i = 0; i <32; i=i+1)
	begin : input_loop
		if(i<31) begin
			MUX1_2x1 m(muxResult[0][i],D[i],D[i+1], S[0]);
		end else begin
			MUX1_2x1 m1(muxResult[0][i], D[i], 1'b0, S[0]);
		end
	end
	for(l=0; l <3; l=l+1) 
	begin : inner_3mux_loop
		for(k=0; k<32; k=k+1)	begin : inner_loop
			if(k<32 -2**(l+1)) begin
				MUX1_2x1 m2(muxResult[l+1][k], muxResult[l][k],muxResult[l][k+2**(l+1)], S[l+1]);
			end else begin
				MUX1_2x1 m3(muxResult[l+1][k], muxResult[l][k], 1'b0, S[l+1]);
			end
		end
	end
	for(j=0; j<32; j=j+1) begin : last_column_loop
		if(j<16) begin
			MUX1_2x1 m4(Y[j], muxResult[3][j], muxResult[3][j+16], S[4]);
		end else begin
			MUX1_2x1 m5(Y[j], muxResult[3][j], 1'b0, S[4]);
		end
	end

endgenerate
endmodule
			


// Left shifter
module SHIFT32_L(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;

// TBD
wire muxResult [3:0][31:0];

genvar i,j,k,l;
generate
	for(i=0; i<32; i=i+1)
	begin : input_loop
		if(i>0) begin
			MUX1_2x1 m(muxResult[0][i], D[i], D[i-1], S[0]);
		end else begin
			MUX1_2x1 m1(muxResult[0][i], D[i], 1'b0, S[0]);
		end
	end
	for(l=0; l <3; l=l+1)
	begin : inner_loop
		for(k=0; k<32; k=k+1)
		begin : inner_loop1
			if(k>= 2**(l+1)) begin
				MUX1_2x1 m2(muxResult[l+1][k], muxResult[l][k], muxResult[l][k-2**(l+1)], S[l+1]);
			end else begin
				MUX1_2x1 m3(muxResult[l+1][k], muxResult[l][k], 1'b0, S[l+1]);
			end
		end
	end
	for(j=0; j<32; j=j+1)
	begin : last_column_loop
		if(j>16) begin
			MUX1_2x1 m4(Y[j], muxResult[3][j], muxResult[3][j-16], S[4]);
		end else begin
			MUX1_2x1 m5(Y[j], muxResult[3][j], 1'b0, S[4]);
		end
	end
endgenerate
endmodule

