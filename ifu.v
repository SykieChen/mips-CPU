module ifu(clk,reset,npc_sel,zero,jump,busa,op,rs,rt,rd,shamt,func,imm16,jal_reg,PCWr,pcout,epc,irq);
input clk,reset,npc_sel,zero,PCWr,irq;
input [1:0] jump;
input [31:0] busa;
input [31:2] epc;
output [5:0] op,func;
output [4:0] rs,rt,rd,shamt;
output [15:0] imm16;
output [31:0] jal_reg;
output [31:2] pcout;
wire [31:2] npcout;
wire [11:2] addr;
wire [31:0] ins;

assign addr=pcout[11:2];
assign op=ins[31:26];
assign rs=ins[25:21];
assign rt=ins[20:16];
assign rd=ins[15:11];
assign shamt=ins[10:6];
assign func=ins[5:0];
assign imm16=ins[15:0];

pc U_PC(clk,reset,npcout,pcout,PCWr);
npc U_NPC(npc_sel,zero,pcout,ins,imm16,busa,jump,jal_reg,npcout,PCWr,epc, irq);
im U_IM(addr,ins);
endmodule
