`timescale 1ns/1ps
module TestBench;
  reg clock,reset_;
  initial begin
    reset_ = 1;
    clock = 0;
    #5 reset_ = 0;
    #20 reset_ = 1;
    #100000 $finish;
  end
  always #5 clock <= !clock;
  wire [3:0] Q;
  wire cout;
  wire q0 = COUNTER.q0, q1 = COUNTER.q1, q2 = COUNTER.q2, q3 = COUNTER.q3;
  reg T;
  initial begin
    T = 1;
  end
  //esperimento conteggio totale su 16 bit con risoluzione di 4 bit -> conteggio massimo 2^16 - 1 = 65535
  wire [15:0] COUNT;

  Serial_Counter COUNTER(T,clock,reset_, Q,cout);

  TOTAL Tot(Q,clock,reset_,cout, COUNT);
endmodule

module Serial_Counter(T, clock, reset_, Q, cout);
  input T,clock,reset_;
  output [3:0] Q;
  output cout;
  wire q0,q1,q2,q3;
  FF_T f0(T, clock, reset_, q0),f1(T&q0, clock, reset_, q1),f2((T&q0)&q1, clock, reset_, q2),f3(((T&q0)&q1)&q2, clock, reset_, q3);
  assign cout = (((T&q0)&q1)&q2)&q3;
  assign Q = {q3,q2,q1,q0};
endmodule

module FF_T(T, clock, reset_, Q);
  input T,clock,reset_;
  output Q;
  reg STAR;
  parameter S0 = 0, S1 = 1;
  always @(reset_ == 0) STAR <= S0;
  assign Q = (STAR==1) ? 1:0;
  always @(negedge clock) if (reset_ == 1) #3
    casex(STAR)
      S0: STAR <= T ? S1:S0;
      S1: STAR <= T ? S0:S1;
    endcase
endmodule

//esperimento conteggio totale su 16 bit
module TOTAL(Q,clock,reset_,cout, COUNT);
  input [3:0] Q;
  input clock,reset_,cout;
  reg [15:0] C;
  output [15:0] COUNT; assign COUNT = C;
  always @(reset_ == 0) C <= 0;
  always @(negedge clock) if (reset_ == 1) if(cout) C = C+Q;
endmodule
