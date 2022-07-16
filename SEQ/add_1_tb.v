`timescale 1ns/1ps

module add_1_tb;

reg a;
reg b;
reg cin;
wire cout;
wire sum;

integer i;

add_1 m1 (cout,sum,a,b,cin);

initial
     begin
         $dumpfile("add_1.vcd");
         $dumpvars(0,add_1_tb);
         for(i=0;i<=7;i=i+1)begin
             {a,b,cin}=i;
             #5;
            $monitor("T = %2d a=%b, b=%b, c=%b, sum=%b cout=%b",$time,a,b,cin,sum,cout);
            #5;
         end
    #5 $finish;
     end
endmodule