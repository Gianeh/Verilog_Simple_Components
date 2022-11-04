`timescale 1ns/1ps
module TopLevel;
reg reset_;initial begin reset_=0; #22 reset_=1; #300; $stop; end
reg clock ;initial clock=0; always #5 clock <=(!clock);
reg X;
wire Z;
wire [1:0] STAR=Xxx.STAR;
initial begin X=0;
wait(reset_==1); #5
@(posedge clock); X<=0; @(posedge clock); X<=0; @(posedge clock); X<=1; @(posedge clock); X<=1;
@(posedge clock); X<=0; @(posedge clock); X<=1; @(posedge clock); X<=0; @(posedge clock); X<=1;
@(posedge clock); X<=0; @(posedge clock); X<=0; @(posedge clock); X<=1; @(posedge clock); X<=0;
@(posedge clock); X<=1; @(posedge clock); X<=1; @(posedge clock); X<=1; @(posedge clock); X<=0;
@(posedge clock); X<=0; @(posedge clock); X<=0; @(posedge clock); X<=0; @(posedge clock); X<=0;
$finish;
end
XXX Xxx(X,Z,clock,reset_);
endmodule


module XXX(x,z,clock,reset_);
  input x,clock,reset_;
  output z;
  reg [1:0] STAR;
  reg OUTR;
  parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
  assign z = OUTR;

  always @(reset_ == 0) begin STAR = S0; OUTR = 0; end
  always @(posedge clock) if(reset_ == 1) #1
    casex(STAR)
      S0: begin STAR <= x ? S1:S0; OUTR <= 0; end
      S1: begin STAR <= x ? S2:S3; OUTR <= 0; end
      S2: begin STAR <= x ? S2:S0; OUTR <= x ? 0:1; end
      S3: begin STAR <= S0;        OUTR <= x ? 1:0; end
    endcase
endmodule
