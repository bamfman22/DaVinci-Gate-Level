
`timescale 1ns/1ps
module a_full_adder_tb;
	reg A, B, CI;
	wire Y, CO;
	FULL_ADDER f(Y,CO, A,B,CI);
	initial begin
		A=0; B=0; CI=0;
		#5 A=1; B=0; CI=0;
		#5 A=0; B=1; CI=0;
		#5 A=1; B=1; CI=0;
		#5 A=0; B=0; CI=1;
		#5 A=1; B=0; CI=1;
		#5 A=0; B=1; CI=1;
		#5 A=1; B=1; CI=1;
		#5;
	end
endmodule 