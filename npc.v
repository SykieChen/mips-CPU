module npc(npc_sel,zero,pcout,ins,imm16,busa,jump,jal_reg,npcout,PCWr,epc, irq);
input npc_sel,PCWr, irq;
input zero;
input [29:0] pcout, epc;
input [31:0] ins;
input [15:0] imm16;
input [31:0] busa;
input [1:0] jump;
output [29:0] npcout;
output [31:0] jal_reg;
reg [29:0] npcout;
reg [29:0] pc_4;

assign jal_reg={pcout+1,2'b0};
// always@(PCWr or pcout)
// 	pc_4=pcout+1;
always@(pcout or jump or irq)
begin
	pc_4=pcout+1;
	if (irq) assign npcout= 'h1060; //[31:2] of 0x00004180
	else begin
		case(jump)
			2'b01: assign npcout={pc_4[29:26],ins[25:0]};//j jal;
			2'b10: assign npcout=busa[31:2];//jr jalr
			2'b11: assign npcout=epc;	//eret
			default: assign npcout=(npc_sel && zero)?
						(pc_4 + {{16{imm16[15]}},imm16})://beq
						pc_4;	//pc+1
		endcase
	end
end
endmodule
