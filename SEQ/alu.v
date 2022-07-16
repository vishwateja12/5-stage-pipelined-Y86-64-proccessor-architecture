`timescale 1ns/1ps

`include "add_1.v"
//`include "add_64.v"
`include "sub_64.v"
`include "and_64.v"
`include "xor_64.v"

module alu(ans,overflow,control,a,b);

input [1:0] control;
input signed [63:0] a;
input signed [63:0] b;

output signed [63:0] ans;
output overflow;

wire signed [63:0] o0;
wire signed [63:0] o1;
wire signed [63:0] o2;
wire signed [63:0] o3;
wire w1;
wire w2;

add_64 m1 (o0,w1,a,b);
sub_64 m2 (o1,w2,a,b);
and_64 m3 (o2,a,b);
xor_64 m4 (o3,a,b);

reg signed overflowfinal;
reg signed [63:0]ansfinal;

always @(*)

begin
    case(control)

    2'b00: begin
        ansfinal = o0;
        overflowfinal = w1;
        end

    2'b01: begin
        ansfinal = o1;
        overflowfinal = w2;
    end

    2'b10: begin
        ansfinal = o2;
        overflowfinal = 1'b0;
    end

    2'b11: begin
        ansfinal = o3;
        overflowfinal = 1'b0;
    end


    endcase
end

assign ans = ansfinal;
assign overflow = overflowfinal;

endmodule