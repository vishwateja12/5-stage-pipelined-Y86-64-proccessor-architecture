module D_srcB(clk,D_icode,D_rB,d_srcB);

input clk;
input [3:0] D_icode;
input [3:0] D_rB;

output reg [3:0] d_srcB;

always @(*)
begin

case(D_icode)

     //   4'b0010 :  d_srcB = 15;       //cmovxx
     //   4'b0011 :  d_srcB = 15;       //irmovq
        4'b0100 :  d_srcB <= D_rB;       //rmmovq
        4'b0101 :  d_srcB <= D_rB;       //mrmovq
        4'b0110 :  d_srcB <= D_rB;       //OPq
        4'b1000 :  d_srcB <= 4;          //call
        4'b1001 :  d_srcB <= 4;          //ret
        4'b1010 :  d_srcB <= 4;          //pushq
        4'b1011 :  d_srcB <= 4;          //popq

    endcase


end


endmodule