//esempio: Half_Adder
`timescale 1ns / 1ps
//test the NAND gate
module encoder_testbench; //module with no ports
reg A, B;
wire sum, carry;
//instantiate your circuit
half_adder H1(sum,carry, A,B);
//Behavioral code block generates stimulus to test circuit
initial
begin
A = 1'b0; B = 1'b0;
#50; $display("A = %b, B = %b, Half_Adder sum = %b, Half_Adder carry_out = %b \n", A, B, sum, carry);
A = 1'b0; B = 1'b1;
#50 $display("A = %b, B = %b, Half_Adder sum = %b, Half_Adder carry_out = %b \n", A, B, sum, carry);
A = 1'b1; B = 1'b0;
#50 $display("A = %b, B = %b, Half_Adder sum = %b, Half_Adder carry_out = %b \n", A, B, sum, carry);
A = 1'b1; B = 1'b1;
#50 $display("A = %b, B = %b, Half_Adder sum = %b, Half_Adder carry_out = %b \n", A, B, sum, carry);
end
endmodule

//create an Half Adder out of a XOR (sum) and an AND (carry_out)
module half_adder (s,c, a,b);
// declare port signals
output s, c;
input a, b;
// declare internal wire
wire d;
//instantiate structural logic gates
xor x(s, a, b); //sum is output, a and b are inputs
and a(c, a, b); //carry is output, a and b are inputs
endmodule
