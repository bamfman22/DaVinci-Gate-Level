// Name: register_file.v
// Module: REGISTER_FILE_32x32
// Input:  DATA_W : Data to be written at address ADDR_W
//         ADDR_W : Address of the memory location to be written
//         ADDR_R1 : Address of the memory location to be read for DATA_R1
//         ADDR_R2 : Address of the memory location to be read for DATA_R2
//         READ    : Read signal
//         WRITE   : Write signal
//         CLK     : Clock signal
//         RST     : Reset signal
// Output: DATA_R1 : Data at ADDR_R1 address
//         DATA_R2 : Data at ADDR_R1 address
//
// Notes: - 32 bit word accessible dual read register file having 32 regsisters.
//        - Reset is done at -ve edge of the RST signal
//        - Rest of the operation is done at the +ve edge of the CLK signal
//        - Read operation is done if READ=1 and WRITE=0
//        - Write operation is done if WRITE=1 and READ=0
//        - X is the value at DATA_R* if both READ and WRITE are 0 or 1
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"

// This is going to be +ve edge clock triggered register file.
// Reset on RST=0
module REGISTER_FILE_32x32(DATA_R1, DATA_R2, ADDR_R1, ADDR_R2, 
                            DATA_W, ADDR_W, READ, WRITE, CLK, RST);
// input list
input READ, WRITE, CLK, RST;
input [`DATA_INDEX_LIMIT:0] DATA_W;
input [`REG_ADDR_INDEX_LIMIT:0] ADDR_R1, ADDR_R2, ADDR_W;
// output list
output [`DATA_INDEX_LIMIT:0] DATA_R1;
output [`DATA_INDEX_LIMIT:0] DATA_R2;
// TBD
wire [31:0] decoderResult, andResult, mux1, mux2;
wire [31:0] registerResult [31:0];
DECODER_5x32 d(decoderResult, ADDR_W);

//REG32(Q, D, LOAD, CLK, RESET);
genvar i;
generate
	for(i=0; i<32; i=i+1) 
	begin : loop
		and a(andResult[i], decoderResult[i], WRITE);
		REG32 r(registerResult[i], DATA_W, andResult[i], CLK, RST);
	end
endgenerate

MUX32_32x1 m(mux1, registerResult[0],registerResult[1],registerResult[2],registerResult[3],
registerResult[4],registerResult[5],registerResult[6],registerResult[7],registerResult[8],
registerResult[9],registerResult[10],registerResult[11],registerResult[12],registerResult[13],
registerResult[14],registerResult[15],registerResult[16],registerResult[17],registerResult[18],
registerResult[19],registerResult[20],registerResult[21],registerResult[22],registerResult[23],
registerResult[24],registerResult[25],registerResult[26],registerResult[27],registerResult[28],
registerResult[29],registerResult[30], registerResult[31], ADDR_R1);

MUX32_32x1 m1(mux2, registerResult[0],registerResult[1],registerResult[2],registerResult[3],
registerResult[4],registerResult[5],registerResult[6],registerResult[7],registerResult[8],
registerResult[9],registerResult[10],registerResult[11],registerResult[12],registerResult[13],
registerResult[14],registerResult[15],registerResult[16],registerResult[17],registerResult[18],
registerResult[19],registerResult[20],registerResult[21],registerResult[22],registerResult[23],
registerResult[24],registerResult[25],registerResult[26],registerResult[27],registerResult[28],
registerResult[29],registerResult[30], registerResult[31], ADDR_R2);

MUX32_2x1 m2(DATA_R1, 32'bZ, mux1, READ);
MUX32_2x1 m3(DATA_R2, 32'bZ, mux2, READ); 

endmodule
