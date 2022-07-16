module D_destM(clk,D_icode,D_rA,d_dstM);

input clk;
input [3:0] D_icode;
input [3:0] D_rA;

output reg [3:0] d_dstM;

always@(*)
begin
     case(D_icode)
  //  4'b0010 :  d_dstM = 15;       //cmovxx
  //  4'b0011 :  d_dstM = 15;       //irmovq
  //  4'b0100 :  d_scrA = 15;       //rmmovq
    4'b0101 :  d_dstM <= D_rA;       //mrmovq
  //  4'b0110 :  d_dstM = 15;       //OPq
  //  4'b1000 :  d_dstM = 15;       //call
  //  4'b1001 :  d_dstM = 15;       //ret
  //   4'b1010 :  d_dstM = 15;      //pushq
    4'b1011 :  d_dstM <= D_rA;       //popq
endcase
end


endmodule