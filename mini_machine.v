module mini_machine(clk,rst, led, ds, switch);
input clk, rst;
input [31:0] switch;
output [6:0] led;
output [7:0] ds;

wire [3:0] BE;
wire [31:2] PrAddr;
wire [31:0] PrWD, PrRD, LEDData, TMRRD, TMRWD, SWTRD;
wire [7:2] HWInt;
wire [3:2] TMRAdd;
wire LEDRst, LEDWe, TMRRst, TMRWe, TMRInt;
mips U_CPU(rst, clk,BE, PrAddr, PrRD, PrWD, HWInt);
bridge U_BRIDGE(rst, clk,BE, PrAddr, PrRD, PrWD, HWInt,LEDRst, LEDData, LEDWe,TMRRst, TMRAdd, TMRWe, TMRInt, TMRRD, TMRWD, SWTRD, SWTInt);
timer U_TMR(clk, TMRRst, TMRAdd, TMRWe, TMRWD, TMRRD, TMRInt);
ledcmp U_LED(clk, LEDRst, LEDData, led, ds, LEDWe);
switch U_SWITCH(clk, switch, SWTRD, SWTInt);

endmodule;