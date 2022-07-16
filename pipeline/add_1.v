`timescale 1ns/1ps

module add_1(cout,sum,a,b,cin);

output cout;
output sum;

input a;
input b;
input cin;

wire w1;
wire w2;
wire w3;

xor g1 (sum,a,b,cin);
xor g2 (w1,a,b);
and g3 (w2,a,b);
and g4 (w3,w1,cin);
or g5 (cout,w2,w3);

endmodule