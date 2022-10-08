`timescale 1ns / 1ps
//test the NAND gate
module encoder_testbench; //module with no ports
reg A, B;
wire C;
//instantiate your circuit
some_logic_component S1(C, A, B);
//Behavioral code block generates stimulus to test circuit
initial
begin
A = 1'b0; B = 1'b0;
#50; $display("A = %b, B = %b, NAND output C = %b \n", A, B, C);
A = 1'b0; B = 1'b1;
#50 $display("A = %b, B = %b, NAND output C = %b \n", A, B, C);
A = 1'b1; B = 1'b0;
#50 $display("A = %b, B = %b, NAND output C = %b \n", A, B, C);
A = 1'b1; B = 1'b1;
#50 $display("A = %b, B = %b, NAND output C = %b \n", A, B, C);
end
endmodule

//create a NAND gate out of an AND and an Inverter
module some_logic_component (c, a, b);
// declare port signals
output c;
input a, b;
// declare internal wire
wire d;
//instantiate structural logic gates
and a1(d, a, b); //d is output, a and b are inputs
//feed the AND into the NOT gate
not n1(c, d); //c is output, d is input
endmodule
