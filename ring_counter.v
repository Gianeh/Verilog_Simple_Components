module TestBench;
  reg clock, reset_;
  always #5 clock <= !clock;
  initial begin
    clock = 0;
    reset_ = 1;
  
    #5 reset_ <= 0;
    #20 reset_ <= 1;
    #600 $finish;
  end
  wire [3:0] Q;
  RingCounter RING(clock,reset_, Q);
  wire q0 = RING.q0, q1 = RING.q1, q2 = RING.q2, q3 = RING.q3;

endmodule


module RingCounter(clock,reset_, Q);
  input clock,reset_;
  output [3:0] Q;
  wire q0,q1,q2,q3;

  StartFF_D   f0(q3,clock,reset_, q0);
  FF_D        f1(q0,clock,reset_, q1), f2(q1,clock,reset_, q2), f1(q2,clock,reset_, q3);
  assign Q = {q3,q2,q1,q0};
endmodule


module FF_D(D,clock,reset_, Q);
  input D,clock,reset_;
  reg STAR;
  parameter S0 = 0, S1 = 1;
  output Q; assign Q = STAR ? 1:0;

  always @(reset_ == 0) STAR <= S0;
  always @(posedge clock) if (reset_ == 1) #3
    casex(STAR)
      S0: STAR = D ? S1:S0;
      S1: STAR = D ? S1:S0;
    endcase
endmodule

//a flip-flop d that starts from S1 -> 1 to trigger a ring cascade
module StartFF_D(D,clock,reset_, Q);
  input D,clock,reset_;
  reg STAR;
  parameter S0 = 0, S1 = 1;
  output Q; assign Q = STAR ? 1:0;
  
  //begins with STAR <= S1
  always @(reset_ == 0) STAR <= S1;
  always @(posedge clock) if (reset_ == 1) #3
    casex(STAR)
      S0: STAR = D ? S1:S0;
      S1: STAR = D ? S1:S0;
    endcase
endmodule

