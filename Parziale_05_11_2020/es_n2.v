`timescale 1ns/1ns

module Testbench;
 reg reset_; initial begin reset_=0; #22 reset_=1; end
 reg clock ;initial begin clock=0; forever #5 clock <=(!clock); end
 reg X;
 wire[2:0] Z=ud3g.z;
 wire[2:0] STAR=ud3g.STAR;
 initial begin X=0; wait(reset_==1);
 #50 X=0; #20 X=1; #50 X=0; #20 X=1; #50 $finish;
 end
 UPDOWN3BITGRAY ud3g(X,clock,reset_, Z);
endmodule



module UPDOWN3BITGRAY(x,clock,reset_,z);
  input clock, reset_;
  input x;
  output [2:0] z;

  reg [2:0] STAR;

  parameter S0='B000, S1='B001, S2='B011, S3='B010, S4='B110, S5='B111, S6='B101, S7='B100;

  always @(reset_ == 0) #1 STAR <= S0;

  assign z = (STAR==S0) ? 'B000 : (STAR==S1) ? 'B001 : (STAR==S2) ? 'B010 : (STAR==S3) ? 'B011 : (STAR==S4) ? 'B100 :
              (STAR==S5) ? 'B101 : (STAR==S6) ? 'B110 : 'B111;

  always @(x) if (reset_ == 1) //#3
    casex(STAR)
      S0: STAR <= x ? S7 : S1;
      S1: STAR <= x ? S0 : S2;
      S2: STAR <= x ? S1 : S3;
      S3: STAR <= x ? S2 : S4;
      S4: STAR <= x ? S3 : S5;
      S5: STAR <= x ? S4 : S6;
      S6: STAR <= x ? S5 : S7;
      S7: STAR <= x ? S6 : S0;
    endcase
endmodule


