`timescale 1ns/1ns
module TopLevel;
reg reset_;initial begin reset_=0; #22 reset_=1; #360; $stop; end
reg clock ;initial clock =0; always #5 clock <=(!clock);
reg x; initial begin x=0; #40 x=1; #200 x=0; #60 $finish; end
//Nota ho aggiunto del tempo in più con x = 0 per testare che il ciclo si potesse arrestare deterministicamente
wire[1:0] STAR = Cntrl.STAR;
wire[2:0] z=Cntrl.z;
LedController Cntrl(x,z,clock,reset_);
endmodule


module LedController (x, z, clock, reset_);
  input x, clock, reset_;
  output [2:0] z;
  reg [1:0] STAR;

  //Represents the number of On LEDS in base 2
  reg [2:0] OUTR;

  parameter S0 = 'B00, S2 = 'B01, S4 = 'B11 , S5 = 'B10;

  always @(reset_ == 0) #1 begin STAR <= S0; OUTR <= 'B000; end

  assign z = OUTR;

  always @(posedge clock) if (reset_ == 1) #3
    casex(STAR)
      S0: begin OUTR <= x ? 'B010 : 'B000; STAR <= x ? S2 : S0; end
      S2: begin OUTR <= x ? 'B011 : 'B000; STAR <= x ? S4 : S0; end
      S4: begin OUTR <= x ? 'B101 : 'B000; STAR <= x ? S5 : S0; end
      S5: begin OUTR <= 'B000         ; STAR <= S0         ; end
    endcase
endmodule
