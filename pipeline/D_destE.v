module D_destE(clk,D_icode,D_rB,d_dstE);

input clk;
input [3:0] D_icode;
input [3:0] D_rB;

output reg [3:0] d_dstE;

always@(*)
begin
    case(D_icode)

    4'b0010 :  d_dstE <= D_rB;       //cmovxx
    4'b0011 :  d_dstE <= D_rB;       //irmovq
  //  4'b0100 :  d_scrA = 15;       //rmmovq
  //  4'b0101 :  d_dstE = 15;       //mrmovq
    4'b0110 :  d_dstE <= D_rB;       //OPq
    4'b1000 :  d_dstE <= 4   ;       //call
    4'b1001 :  d_dstE <= 4   ;       //ret
    4'b1010 :  d_dstE <= 4   ;       //pushq
    4'b1011 :  d_dstE <= 4   ;       //popq

endcase
end


endmodule