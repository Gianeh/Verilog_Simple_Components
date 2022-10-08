//esempio: Half_Adder
`timescale 1ns / 1ps
//test the NAND gate
module encoder_testbench; //module with no ports
reg A, B, carry_in;
wire sum, carry_out;
//instantiate your circuit
full_adder H1(sum,carry_out, A,B,carry_in);
//Behavioral code block generates stimulus to test circuit
initial
begin
A = 1'b0; B = 1'b0; carry_in = 1'b0;
#50; $display("A = %b, B = %b, Full_Adder carry_in = %b, Full_Adder sum = %b, Full_Adder carry_out = %b \n", A, B, carry_in, sum, carry_out);
A = 1'b0; B = 1'b0; carry_in = 1'b1;
#50 $display("A = %b, B = %b, Full_Adder carry_in = %b, Full_Adder sum = %b, Full_Adder carry_out = %b \n", A, B, carry_in, sum, carry_out);
A = 1'b0; B = 1'b1; carry_in = 1'b0;
#50 $display("A = %b, B = %b, Full_Adder carry_in = %b, Full_Adder sum = %b, Full_Adder carry_out = %b \n", A, B, carry_in, sum, carry_out);
A = 1'b0; B = 1'b1; carry_in = 1'b1;
#50 $display("A = %b, B = %b, Full_Adder carry_in = %b, Full_Adder sum = %b, Full_Adder carry_out = %b \n", A, B, carry_in, sum, carry_out);
A = 1'b1; B = 1'b0; carry_in = 1'b0;
#50 $display("A = %b, B = %b, Full_Adder carry_in = %b, Full_Adder sum = %b, Full_Adder carry_out = %b \n", A, B, carry_in, sum, carry_out);
A = 1'b1; B = 1'b0; carry_in = 1'b1;
#50 $display("A = %b, B = %b, Full_Adder carry_in = %b, Full_Adder sum = %b, Full_Adder carry_out = %b \n", A, B, carry_in, sum, carry_out);
A = 1'b1; B = 1'b1; carry_in = 1'b0;
#50 $display("A = %b, B = %b, Full_Adder carry_in = %b, Full_Adder sum = %b, Full_Adder carry_out = %b \n", A, B, carry_in, sum, carry_out);
A = 1'b1; B = 1'b1; carry_in = 1'b1;
#50 $display("A = %b, B = %b, Full_Adder carry_in = %b, Full_Adder sum = %b, Full_Adder carry_out = %b \n", A, B, carry_in, sum, carry_out);



end
endmodule

//create a Full Adder module using 3 XOR and 3 AND
module full_adder (s,c_out, a,b,c_in);
// declare port signals
output s, c_out;
input a, b, c_in;
// declare internal wire
wire xorxor;
wire andor1, andor2, andor3;
//instantiate structural logic gates
xor x1(xorxor, b,c_in); // xorxor is output, b and c_in are inputs
xor x2(s, a, xorxor); //sum is output, a and xorxor are inputs
and a1(andor1, a,b); // andor1 is output, a and b are inputs
and a2(andor2, a,c_in); // andor1 is output, a and c_in are inputs
and a3(andor3, b,c_in); // andor1 is output, b and c_in are inputs
xor x3(c_out, andor1,andor2,andor3);
endmodule

