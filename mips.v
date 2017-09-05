module mips(rst, clk,BE, PrAddr, PrRD, PrWD, HWInt);
input clk;
input rst;
input [7:2] HWInt;
input [31:0] PrRD;
output [3:0] BE;
output [31:0] PrWD;
output [31:2] PrAddr;

wire [5:0] Op,Func;
wire [1:0] RegDst,ExtOp,ALUctr,jump;
wire [2:0] MemToReg;
wire NPCSel,ALUSrc,RegWr,MemWr,zero,sb,lb,PCWr,irq, EXLClr, EXLSet, cp0Wr;
wire [31:0] busa,busb,busw,slowbusw,dout,aluout,Extout,mux2_out,jal_reg, sb_data,cp0out;
wire [4:0] rs,rt,rd,shamt,rw;
wire [15:0] imm16;
wire [31:2] pc, epc;
wire [31:0] loaddata;
wire [2:0] stat;
assign BE = 'b1111;
assign PrAddr = aluout[31:2];
assign PrWD = sb_data;
	bitsaver U_BS(busb,sb_data,aluout[1:0],dout,loaddata,sb,lb);
	controller U_CTRL(clk, rst, Op, rs,aluout[31:2],Func,RegDst,ALUSrc,MemToReg,RegWr,MemWr,NPCSel,ExtOp,ALUctr,jump,sb,lb,PCWr,stat,irq, EXLClr, EXLSet,cp0Wr);
	cp0 U_CP0(pc, busb, HWInt, rd, cp0Wr, EXLSet, EXLClr, clk, rst, irq, epc, cp0out);
	ifu U_IFU(clk,rst,NPCSel,zero,jump,busa,Op,rs,rt,rd,shamt,Func,imm16,jal_reg,PCWr,pc,epc,irq);
	dm U_DM(clk,aluout[11:2],sb_data,MemWr,dout);
	gpr U_GPR(clk,rst,rs,rt,rw,busw,RegWr,busa,busb);
	alu U_ALU(alk,rst,busa,mux2_out,ALUctr,aluout,zero,overflow);
	ext U_EXT(imm16,ExtOp,Extout);
	mux_reg U_MUX_REG(RegDst,rd,rt,rw);
	mux_alu U_MUX_ALU(busb,Extout,ALUSrc,mux2_out);
	mux_MtoR U_MUX_M2R(aluout,dout,jal_reg,cp0out,PrRD,MemToReg,busw);

	//data_delayer U_MUX_delayer(busw, slowbusw, clk);
endmodule
