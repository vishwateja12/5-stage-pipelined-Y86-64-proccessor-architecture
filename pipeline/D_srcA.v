module D_srcA(clk,D_icode,D_rA,d_srcA);

input clk;
input [3:0] D_icode;
input [3:0] D_rA;

output reg [3:0] d_srcA;

always @(*)
begin

case(D_icode)
        
        4'b0010 :  d_srcA <= D_rA;       //cmovxx
    //    4'b0011 :  d_srcA = 15  ;       //irmovq
        4'b0100 :  d_srcA <= D_rA;       //rmmovq
    //    4'b0101 :  d_srcA = 15;       //mrmovq
        4'b0110 :  d_srcA <= D_rA;       //OPq
    //    4'b1000 :  d_srcA = 15   ;       //call
        4'b1001 :  d_srcA <= 4   ;       //ret
        4'b1010 :  d_srcA <= D_rA;       //pushq
        4'b1011 :  d_srcA <= 4   ;       //popq

    endcase


end


endmodule