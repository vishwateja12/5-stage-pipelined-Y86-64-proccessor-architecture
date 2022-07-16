`timescale 1ns/1ps

module alu_tb;

reg [1:0] control;
reg signed [63:0] a;
reg signed [63:0] b;

wire signed [63:0] ans;
wire overflow;

alu m1 (ans,overflow,control,a,b);

initial 
   begin

        $dumpfile("alu.vcd");
        $dumpvars(0,alu_tb);
        a = 64'b0;
        b = 64'b0;
        control = 2'b00;

        #20;

		#5 control=2'b00;a=64'b1011;b=64'b0100;
        #5 control=2'b01;a=64'b1011;b=64'b0100;
        #5 control=2'b10;a=64'b1011;b=64'b0100;
        #5 control=2'b11;a=64'b1011;b=64'b0100;
        #5 control=2'b00;a=-64'b1011;b=64'b0100;
        #5 control=2'b01;a=-64'b1011;b=64'b0100;
        #5 control=2'b10;a=-64'b1011;b=64'b0100;
        #5 control=2'b11;a=-64'b1011;b=64'b0100;
        #5 control=2'b00;a=64'b1011;b=-64'b0100;
        #5 control=2'b01;a=64'b1011;b=-64'b0100;
        #5 control=2'b10;a=64'b1011;b=-64'b0100;
        #5 control=2'b11;a=64'b1011;b=-64'b0100;
        #5 control=2'b00;a=-64'b1011;b=-64'b0100;
        #5 control=2'b01;a=-64'b1011;b=-64'b0100;
        #5 control=2'b10;a=-64'b1011;b=-64'b0100;
        #5 control=2'b11;a=-64'b1011;b=-64'b0100;
        #5 control=2'b00;a=64'd56716276;b=64'd1;
        #5 control=2'b01;a=64'd8762547857;b=-64'd1;
        #5 control=2'b00;a=64'b0;b=64'b0;
    end

    initial

          $monitor("T = %2d ans=%b, overflow=%b, control=%b, a=%b, b=%b",$time,ans,overflow,control,a,b); 
  
endmodule

