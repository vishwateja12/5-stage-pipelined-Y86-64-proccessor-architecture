`timescale 1ns/1ps
//`include "add_1.v"

module add_64(sum,v,a,b);
output v;
output signed [63:0] sum;
input signed [63:0] a;
input signed [63:0] b;

wire [64:0]w;

assign w[0]=1'b0;

genvar i;

generate for(i=0;i<=63;i=i+1)
begin
    add_1 g1 (w[i+1],sum[i],a[i],b[i],w[i]);
end
endgenerate

xor g2 (v,w[64],w[63]);

endmodule