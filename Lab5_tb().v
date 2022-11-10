module Lab5_tb();

reg clk, rst, inc1, inc10;
wire [6:0] disp1, disp0;
Lab5 a (clk, rst, inc1, inc10, disp1, disp0);

initial $monitor(clk, rst, inc1, inc10, disp1, disp0);
always
begin 

#10 clk = 1; inc1 = 1'b1; inc10 = 1'b1;
#5 clk = 0;
#10 clk = 1; inc1 = 1'b1; inc10 = 1'b0;
#5 clk = 0;
#10 clk = 1; inc1 = 1'b0; inc10 = 1'b1;
#5 clk = 0;
#10 clk = 1; inc1 = 1'b0; inc10 = 1'b0;
#5 clk = 0; 
#5 clk = 1; rst = 1'b0;
#5 clk = 0; 
#10 clk = 1; rst = 1'b0;  inc1 = 1'b1; inc10 = 1'b1;
#5 clk = 0;
#5 clk = 1; rst = 1'b0;
#5 clk = 0; 
#5 clk = 1; 
#5 rst = 1'b0;
#5 clk = 0; 
#5 clk = 1; rst = 1'b0;
#5 clk = 0; 
