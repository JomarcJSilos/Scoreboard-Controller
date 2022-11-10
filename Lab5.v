module Lab5 (clk, rst, inc1, inc10, seg7disp1, seg7disp0);

input clk;
input rst; 
input inc1; 
input inc10; 
output[6:0] seg7disp1; 
output[6:0] seg7disp0; 

reg[0:0] State;
reg[3:0] BCD1; 
reg[3:0] BCD0; 
reg[2:0] rstcnt; 
reg[6:0] seg7Rom[0:9]; 

initial 
begin
BCD1 = 4'b0000; 
BCD0 = 4'b0000; 
rstcnt = 0; 
State = 0; 
seg7Rom[0] = 7'b1000000; 
seg7Rom[1] = 7'b1111001; 
seg7Rom[2] = 7'b0100100; 
seg7Rom[3] = 7'b0110000; 
seg7Rom[4] = 7'b0011001; 
seg7Rom[5] = 7'b0010010; 
seg7Rom[6] = 7'b0000010; 
seg7Rom[7] = 7'b1111000; 
seg7Rom[8] = 7'b0000000; 
seg7Rom[9] = 7'b0011000; 
end

reg q1, q2, q3;
reg q4, q5, q6;

wire inc1_sp;
always@(posedge clk)
begin
q1<= inc1;
q2 <= q1;
q3 <= q2;
end
assign inc1_sp = ~q2 & q3;

wire inc10_sp;
always@(posedge clk)
begin
q4<= inc10;
q5 <= q4;
q6 <= q5;
end
assign inc10_sp = ~q5 & q6;
reg q0, q00;
wire reset_sp;
always@(posedge clk)
begin 
q0 <= rst;
q00 <= q0;
end
assign reset_sp = q00;

always @(posedge clk) 
begin 
case (State) 
	0 : 
		begin 
			BCD1 <=4'b0000 ; 
			BCD0 <= 4'b0000 ; 
			rstcnt <= 0 ; 
			State <= 1 ; 
		end 
	1 :
		begin 
		if (~rst == 1'b1) // Reset is pressed
			begin 
		if (rstcnt == 4) 
			
			State = 0 ;
			
		else
			
				rstcnt <= rstcnt + 1 ; 
			
		end 
		else if (inc1_sp == 1'b1 && inc10_sp == 1'b0) // If INC1 is pressed
			begin 
			rstcnt <= 0; 
			if (BCD0 < 4'b1001) 
				 
				BCD0 <= BCD0 + 1; 
 
			else if (BCD1 == 4'b1001 && BCD0 == 4'b1001) 
				begin 
				BCD1 <= BCD1; 
				BCD0 <= BCD0; 
				end
			else
				begin
				BCD0 <= 4'b0000;
				BCD1 <= BCD1 + 1;
				end
			end 
		else if (inc10_sp == 1'b1 && inc1_sp == 1'b0) // If INC10 is pressed
		begin
			begin 
				rstcnt <= 0 ; 
			end 
				if (BCD1 < 4'b1001) 
				begin 
					BCD1 <= BCD1 + 1 ; 
				end 
				else if (BCD1 == 4'b1001)
				begin 
					BCD1 <= BCD1;
					BCD0 <= BCD0;
				end 
		end 
		else if (inc1_sp == 1'b1 && inc10_sp == 1'b1)
			begin
			if(BCD1 != 4'b1001 && BCD0 != 4'b1001)
				begin
				rstcnt <= 0;
				BCD1 <= BCD1 +1;
				BCD0 <= BCD0 +1;
				end
					begin 
					rstcnt <= 0 ; 
					end 
				end


		end
		endcase
		end

assign seg7disp0 = seg7Rom[BCD0] ; 
assign seg7disp1 = seg7Rom[BCD1] ; 
endmodule
