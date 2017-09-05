module bridge(rst, clk,BE, PrAddr, PrRD, PrWD, HWInt,LEDRst, LEDData, LEDWe,TMRRst, TMRAdd, TMRWe, TMRInt, TMRRD, TMRWD, SWTRD, SWTInt);
input [31:2] PrAddr;
input [3:0] BE;
input [31:0] PrWD, TMRRD, SWTRD;
input rst, clk,TMRInt,SWTInt,TMRRst,LEDRst;
output [3:2] TMRAdd;
output LEDWe, TMRWe;
output [31:0] LEDData, TMRWD, PrRD;
output [7:2] HWInt;
wire HitDEV0;
wire HitDEV1;
wire HitDEV2;

assign HitDEV0 = (PrAddr[31:4] == 'h7f0); // Timer
assign HitDEV1 = (PrAddr[31:4] == 'h7f1); // LED
assign HitDEV2 = (PrAddr[31:4] == 'h7f2); // Switch
assign LEDRst = rst;
assign TMRRst = rst;
assign TMRAdd = PrAddr[3:2];
assign LEDData = PrWD;
assign TMRWD = PrWD;
assign LEDWe = HitDEV1 & BE[1];
assign TMRWe = HitDEV0 & BE[0];
assign PrRD = 	(HitDEV0)?TMRRD:
				(HitDEV2)?SWTRD:
				'hffffffff;
assign HWInt[2] = TMRInt;
assign HWInt[3] = SWTInt;

//'h1fc0 is the high 30 of 0x0000_7F00
endmodule