`timescale 1ns/1ps

module add_64_tb;

reg signed [63:0] a;
reg signed [63:0] b;

wire signed [63:0] sum;
wire v;

integer i;

add_64 m1 (sum,v,a,b);

initial 
    begin
        $dumpfile("add_64.vcd");
        $dumpvars(0,add_64_tb);
        a = 64'b0;
        b = 64'b0;
        #20;
        #5 a = 64'd100000000000000000; b = 64'd110101010101010101;
        #5 a = -64'd100000000000000000; b = 64'd110101010101010101;
        #5 a = 64'd100000000000000000; b = -64'd110101010101010101;
        #5 a = -64'd100000000000000000; b = -64'd110101010101010101;
        #5 a = 64'd20; b = 64'd50;
        #5 a = -64'd20; b = 64'd50;
        #5 a = 64'd20; b = -64'd50;
        #5 a = -64'd20; b = -64'd50;
    end

    initial

          $monitor("T = %2d sum=%b, overflow=%b, a=%b, b=%b",$time,sum,v,a,b); 
  
endmodule


