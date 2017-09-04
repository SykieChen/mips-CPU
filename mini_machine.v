module mini_machine(rst, led, ds, switch);

wire [3:0] BE;

bridge U_BRIDGE(rst, clk,BE, PrAddr, PrRD, PrWD, HWInt, LEDData, TMRAdd, TMRRD, TMRWD, SWTRD);
timer U_TMR(clk, rst, TMRAdd, BE[0], TMRWD, TMRRD, HWInt[2]);
ledcmp U_LED(clk, rst, LEDData, led, ds, en);


endmodule;