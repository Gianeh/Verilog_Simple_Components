//esempio: Encoder
`timescale 1ns / 1ps
//test the Encoder
module decoder_testbench; //module with no ports
reg z1,z2,z3,z4;
wire A, B;
//instantiate your circuit
Decoder D1(A,B, z1,z2,z3,z4);
//Behavioral code block generates stimulus to test circuit
initial
begin
z1 = 1'b1; z2 = 1'b0; z3 = 1'b0; z4 = 1'b0;
#50; $display("z1 = %b, z2 = %b, z3 = %b, z4 = %b, Encoder output = %b%b \n", z1,z2,z3,z4, A,B);
z1 = 1'b0; z2 = 1'b1; z3 = 1'b0; z4 = 1'b0;
#50 $display("z1 = %b, z2 = %b, z3 = %b, z4 = %b, Encoder output = %b%b \n", z1,z2,z3,z4, A,B);
z1 = 1'b0; z2 = 1'b0; z3 = 1'b1; z4 = 1'b0;
#50 $display("z1 = %b, z2 = %b, z3 = %b, z4 = %b, Encoder output = %b%b \n", z1,z2,z3,z4, A,B);
z1 = 1'b0; z2 = 1'b0; z3 = 1'b0; z4 = 1'b1;
#50 $display("z1 = %b, z2 = %b, z3 = %b, z4 = %b, Encoder output = %b%b \n", z1,z2,z3,z4, A,B);
end
endmodule

//create a Decoder out of some ANDs and some NOTs
module Decoder (a,b, z1,z2,z3,z4);
// declare port signals
input z1,z2,z3,z4;
output a, b;
//instantiate structural logic gates
or(a, z3,z4);
or(b, z2,z4);
endmodule


