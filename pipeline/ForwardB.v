module ForwardB(clk,e_dstE,e_valE,M_dstE,M_valE,M_dstM,m_valM,W_dstE,W_dstM,W_valE,W_valM,
                           d_rvalB,d_srcB,d_valB1);

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
input [63:0] d_rvalB;
input [3:0] d_srcB;

output reg [63:0] d_valB1;

always@(*)
begin
  
     if (d_srcB == e_dstE)
     d_valB1 = e_valE;
else if (d_srcB == M_dstM)
     d_valB1 = m_valM;
else if (d_srcB == M_dstE)
     d_valB1 = M_valE;
else if (d_srcB == W_dstM)
     d_valB1 = W_valM;
else if (d_srcB == W_dstE)
     d_valB1 = W_valE;
else d_valB1 = d_rvalB;

end


endmodule