`timescale 1ns/1ps
module a_mult_tb;
	reg [31:0] OP1;
	reg [31:0] OP2;
	wire [31:0] HI;
	wire [31:0] LO;
	MULT32 m(HI, LO, OP1, OP2);
	initial begin
		#5;
		#5 OP1='b0; OP2='b0;
		#5 $write("%d * %d = %d\n", OP1, OP2, LO);
		#5;
		#5 OP1='b1; OP2='b0;
		#5 $write("%d * %d = %d\n", OP1, OP2, LO);
		#5;
		#5 OP1='b0; OP2='b1;
		#5 $write("%d * %d = %d\n", OP1, OP2, LO);
		#5;
		#5 OP1='b1; OP2='b1;
		#5 $write("%d * %d = %d\n", OP1, OP2, LO);
		#5;
		#5 OP1='b11; OP2='b1;
		#5 $write("%d * %d = %d\n", OP1, OP2, LO);
		#5;
		#5 OP1='b1111111111111111111111111111111; OP2='b1;
		#5 $write("%d * %d = %d\n", OP1, OP2, LO);
		#5;
		#5 OP1='hffffffff; OP2='b1;
		#5 $write("%d * %d = %d\n", OP1, OP2, LO);
		#5;
		#5 OP1='b10; OP2='b10;
		#5 $write("%d * %d = %d\n", OP1, OP2, LO);
		#5;
		#5 OP1='b11; OP2='b11;
		#5 $write("%d * %d = %d\n", OP1, OP2, LO);
		#5;
		#5 OP1=-1; OP2=1;
		#5 $write("%d * %d = %d\n", OP1, OP2, LO);
		#5;
		#5 OP1=-1; OP2=-1;
		#5 $write("%d * %d = %d\n", OP1, OP2, LO);
		#5;
		
	end

	
endmodule
