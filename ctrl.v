module controller(clk, rst, Op, rs,Funct,RegDst,ALUSrc,MemToReg,RegWr,MemWr,NPCSel,ExtOp,ALUctr,jump, sb, lb,PCWr, status, irq, EXLClr, EXLSet, cp0Wr);
	input [5:0] Op,Funct;
	input [5:1] rs;
	input clk, rst;
	input irq;
	output sb, lb;
	output reg NPCSel,ALUSrc,RegWr,MemWr, PCWr, EXLClr, EXLSet, cp0Wr;
	output reg [1:0] RegDst,ALUctr,ExtOp,jump;
	output reg [2:0] MemToReg;
	output [2:0] status;

	wire Rtype=(Op==6'b000000);
	wire addu=(Rtype&&(Funct==6'b100001));
	wire subu=(Rtype&&(Funct==6'b100011));
	wire slt=(Rtype&&(Funct==6'b101010));
	wire jr=(Rtype&&(Funct==6'b001000));

	wire ori=(Op==6'b001101);
	wire lw=(Op==6'b100011);
	wire sw=(Op==6'b101011);
	wire beq=(Op==6'b000100);
	wire lui=(Op==6'b001111);
	wire addi=(Op==6'b001000);
	wire addiu=(Op==6'b001001);
	wire jal=(Op==6'b000011);
	wire jalr=(Op==6'b000000 && Funct==6'b001001);
	wire j=(Op==6'b000010);

	wire cp0=(Op==6'b010000);
	wire eret=(cp0&&(Funct==6'b011000));
	wire mfc0=(cp0&&(rs==6'b00000));
	wire mtc0=(cp0&&(rs==6'b00100));
	
	assign sb=(Op==6'b101000);
	assign lb=(Op==6'b100000);
	
parameter [3:0]
	sif=0,
	sid=1,
	sexe1=2,
	smem=3,
	swb1=4,
	sexe2=5,
	sexe3=6,
	swb2=7,
	sint=8;

reg [2:0] status, nexts;


always@(posedge clk or posedge rst)
begin
	if(rst) status=sif;
	else status<=nexts;
end

always@(status or Op)
begin
	case(status)
	sif: nexts = sid;
	sid: begin
		if(jal | j | jr | jalr | eret) nexts = sint;
		else if(lw | sw | lb | sb ) nexts = sexe1;
		else if(beq) nexts = sexe2;
		else nexts = sexe3;
	end
	sexe1: nexts = smem;
	smem: begin
		if(lw | lui | lb) nexts = swb1;
		else nexts = sint;
	end
	swb1: nexts = sint;
	sexe2: nexts = sint;
	sexe3: nexts = swb2;
	swb2: nexts = sint;
	sint: nexts = sif;
	endcase
end

always@(status or rst)
begin
	if(status == sif || (status == sint && irq == 1)) PCWr=1;
	else PCWr=0;
	if(status == smem || status == sid) RegDst={jal,addu|subu|slt|jalr};
	if(status == sexe3 || status == sexe1 || status == swb2 || status == swb1) ALUSrc=addi|addiu|lw|sw|lui|ori|sb|lb;
	if(status == sid || status == swb2) MemToReg=mfc0?(3'b011):{1'b0,jal|jalr,lw|lb};
	if(status == swb1 || status == swb2) RegWr=addu|subu|slt|addi|addiu|ori|lw|lui|lb|mfc0;
	else if(status == sid) RegWr=jal|jalr;
	else RegWr=0;
	if(status == smem) MemWr=sw|sb;
	else MemWr=0;
	if(status == smem) cp0Wr=mtc0;
	else cp0Wr=0;
	if(status == sif) assign NPCSel=beq;
	if(status == sid ) begin
		if (eret) begin
			assign jump=2'b11; //eret
			EXLClr = 1;
		end
		else begin
			assign jump={jr|jalr,j|jal};
			EXLClr = 0;
		end
	end
	else assign jump=0;
	if(status == sexe1 || status == sexe2 || status == sexe3 || status == smem) ExtOp={lui,addi|addiu|lw|sw|beq|sb|lb};
	if(status == sexe1 || status == sexe2 || status == sexe3) ALUctr={ori|slt,subu|slt|beq};
	if(status == sint && irq == 1) EXLSet = 1;
	else EXLSet = 0;
end

endmodule