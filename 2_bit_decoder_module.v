//esempio: Decoder
`timescale 1ns / 1ps
//test the Decoder
module decoder_testbench; //module with no ports
reg A, B;
wire z1,z2,z3,z4;
//instantiate your circuit
Decoder D1(z1,z2,z3,z4, A,B);
//Behavioral code block generates stimulus to test circuit
initial
begin
A = 1'b0; B = 1'b0;
#50; $display("A = %b, B = %b, Decoder output = %b%b%b%b \n", A, B, z1,z2,z3,z4);
A = 1'b0; B = 1'b1;
#50 $display("A = %b, B = %b, Decoder output = %b%b%b%b \n", A, B, z1,z2,z3,z4);
A = 1'b1; B = 1'b0;
#50 $display("A = %b, B = %b, Decoder output = %b%b%b%b \n", A, B, z1,z2,z3,z4);
A = 1'b1; B = 1'b1;
#50 $display("A = %b, B = %b, Decoder output = %b%b%b%b \n", A, B, z1,z2,z3,z4);
end
endmodule

//create a Decoder out of some ANDs and some NOTs
module Decoder (z1,z2,z3,z4, a,b);
// declare port signals
output z1,z2,z3,z4;
input a, b;
//instantiate structural logic gates
and(z1, a,b);
and(z2,a,!b);
and(z3,!a,b);
and(z4,!a,!b);
endmodule

