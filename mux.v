module mux_reg(regdst,rd,rt,rw);
input [1:0] regdst;
input [4:0] rd,rt;
output [4:0] rw;
reg [4:0] rw;
always @(regdst)
begin
	case (regdst)
		2'b00: assign rw=rt;
		2'b01: assign rw=rd; //jalr
		2'b10: assign rw=5'b11111; //jal
	endcase
end
endmodule

module mux_alu(busb,imm32,alusrc,out);
input [31:0] busb,imm32;
input alusrc;
output [31:0] out;
reg [31:0] out;
always @(alusrc)
	begin
		case (alusrc)
		1'b0: assign out=busb;
		1'b1: assign out=imm32;
		endcase
	end
endmodule

module mux_MtoR(aluout,dout,jal_reg,cp0out,PrRD,memtoreg,out);
input [31:0] aluout,dout,jal_reg,cp0out,PrRD;
input [2:0] memtoreg;
output [31:0] out;
reg [31:0] out;
always @(memtoreg)
	case (memtoreg)
		'b000: assign out=aluout;
		'b001: assign out=dout;//lw
		'b010: assign out=jal_reg;//jal
		'b011: assign out=cp0out;//mfc0
		'b100: assign out=PrRD;//bridge
	endcase
endmodule

