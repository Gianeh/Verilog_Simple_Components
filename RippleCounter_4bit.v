
`timescale 1ns/1ps
module TopLevel;
  reg clock; reg reset_;
  wire [3:0] Q;
  always #10 clock <= !clock;
  initial begin
    $display ("time, \t\t clock, \t reset, \t QQQQ");
    $monitor ("%f, \t %b, \t %b, \t %b", $time, clock, reset_, Q);
    reset_ = 1; clock = 0;
    #5 reset_ = 1'b0;
    #20 reset_ = 1'b1;
    #600 $finish;
    end

    reg T;
    initial begin
      T = 1;
    end
  Counter ripc(T,clock,reset_, Q);

  wire q0 = ripc.q0, q1 = ripc.q1, q2 = ripc.q2, q3 = ripc.q3;
  wire [3:0] q = {ripc.q0,ripc.q1,ripc.q2,ripc.q3};
endmodule

module Counter(T,clock,reset_, Q);
  input T,clock,reset_;
  output [3:0] Q;
  wire q0,q1,q2,q3;
  reg [3:0] Q1;
  assign Q = Q1;
  T_flip_flop f0(T,clock,reset_,q0),f1(T,q0,reset_,q1),f2(T,q1,reset_,q2),f3(T,q2,reset_,q3);
  always @(negedge clock) if(reset_ == 1) begin
    Q1[0] = q0;
    Q1[1] = q1;
    Q1[2] = q2;
    Q1[3] = q3;
  end
endmodule

module T_flip_flop(T,clock,reset_, Q);
  input T,clock,reset_;
  reg STAR;
  parameter S0 = 0, S1 = 1;
  output Q;
  
  assign Q = (STAR == 0) ? 0 : 1;
  
  always @(reset_ == 0) STAR <= S0;
  always @(negedge clock) if (reset_ == 1) #0.2
  casex(STAR)
  S0: STAR <= T ? S1:S0;
  S1: STAR <= T ? S0:S1;
  endcase
  
endmodule
