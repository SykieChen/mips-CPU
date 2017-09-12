module cp0(PC, DIn, HWInt, Sel, Wen, EXLSet, EXLClr, clk, rst, IntReq, EPC, DOut);
input [31:2] PC;
input [31:0] DIn;
input [5:0] HWInt;
input [4:0] Sel;
input Wen, EXLSet, EXLClr,clk, rst;
output reg IntReq;
output reg [31:2] EPC;
output [31:0] DOut;

reg [15:10] im;
wire [15:10] hwint_pend;
wire IntSig;
reg exl; //flag marking already in interrupt (SR)
reg ie; //global interrupt enable (SR)
reg [31:0] PrID = 'h15071025; // Processor ID
// SR = {16'b0, im, 8'b0, exl, ie}
// CAUSE = {16'b0, hwint_pend, 10'b0}
assign hwint_pend[15:10] = HWInt[5:0];
assign IntSig = (|(hwint_pend[15:10] & im[15:10])) & ie & !exl;
assign DOut = 	(Sel == 12)?{16'b0, im, 8'b0, exl, ie}:
				(Sel == 13)?{16'b0, hwint_pend, 10'b0}:
				(Sel == 14)?EPC:
				(Sel == 15)?PrID:
				32'b0;

always @(posedge IntSig) begin
	EPC = PC;
	IntReq = 1;
end
always @(posedge clk or posedge rst) begin
	
	if (EXLSet) begin
		exl = 1;
		IntReq = 0;
	end
	else if (EXLClr)
		exl = 0;

	if (rst) begin
		// reset
		im = 0;
		exl = 0;
		ie = 1;
	end
	// 12 => SR
	// 13 => CAUSE
	// 14 => EPC
	// 15 => PrID
	else if (Wen && Sel == 12)
		{im, exl, ie} = {DIn[15:10], DIn[1:0]};
	
end
endmodule