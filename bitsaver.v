module bitsaver(iData, oData, bitAddr, oriData, loaddata, sb, lb);
input sb, lb;
input [1:0] bitAddr;
input [31:0] oriData, iData;
output [31:0] oData, loaddata;
reg [7:0] targetbit;

always@(bitAddr)
begin
	case(bitAddr)
	3: targetbit = oriData[31:24];
	2: targetbit = oriData[23:16];
	1: targetbit = oriData[15:8];
	0: targetbit = oriData[7:0];
	endcase
end

assign oData = (sb)?
	{
		((bitAddr == 3)? iData[7:0] : targetbit),
		((bitAddr == 2)? iData[7:0] : targetbit),
		((bitAddr == 1)? iData[7:0] : targetbit),
		((bitAddr == 0)? iData[7:0] : targetbit)
	}
	:iData;

assign loaddata = (lb)?
	{24'b0, targetbit}:
	oriData;
	
endmodule 