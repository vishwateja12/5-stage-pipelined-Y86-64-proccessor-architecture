module SelectiveAndForwardA(clk,e_dstE,e_valE,M_dstE,M_valE,M_dstM,m_valM,W_dstE,W_dstM,W_valE,W_valM,
                           D_icode,D_valP,d_rvalA,d_srcA,d_valA);

input clk;
input [3:0] e_dstE;
input [63:0] e_valE;
input [3:0] M_dstE;
input [63:0] M_valE;
input [3:0] M_dstM;
input [63:0] m_valM;
input [3:0] W_dstM;
input [63:0] W_valM;
input [3:0] W_dstE;
input [63:0] W_valE;
input [3:0] D_icode;
input [63:0] D_valP;
input [63:0] d_rvalA;
input [3:0] d_srcA;

output reg [63:0] d_valA;

always@(*)
begin
  
     if ((4'b0111 == D_icode) || (4'b1000 ==D_icode))
     d_valA = D_valP;
else if (d_srcA == e_dstE)
     d_valA = e_valE;
else if (d_srcA == M_dstM)
     d_valA = m_valM;
else if (d_srcA == M_dstE)
     d_valA = M_valE;
else if (d_srcA == W_dstM)
     d_valA = W_valM;
else if (d_srcA == W_dstE)
     d_valA = W_valE;
else d_valA = d_rvalA;

end


endmodule