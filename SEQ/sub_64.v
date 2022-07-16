`timescale 1ns/1ps
`include "add_64.v"


module sub_64(sub,v,a,b);

output v;
output signed [63:0] sub;
input signed [63:0] a;
input signed [63:0] b;
wire [63:0] bc;
wire [63:0] b_64;
wire [63:0] l;
wire w1;
wire v;

assign l = 64'b1;

genvar i;

generate for(i=0;i<=63;i=i+1)
begin
    not g1 (bc[i],b[i]);
end
endgenerate

add_64 g2 (b_64,w1,bc,l);
add_64 g3 (sub,v,a,b_64);

endmodule