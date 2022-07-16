`timescale 1ns / 1ps

module W_RegisterBlock(clk,m_stat,M_icode,M_valE,m_valM,M_dstE,M_dstM,
                           W_stat,W_icode,W_valE,W_valM,W_dstE,W_dstM);  
  
input clk;
input [2:0] m_stat;
input [3:0] M_icode;
input [63:0] M_valE;
input [63:0] m_valM;
input [3:0] M_dstE;
input [3:0] M_dstM;
  

output reg [2:0] W_stat;
output reg [3:0] W_icode;
output reg [63:0] W_valE;
output reg [63:0] W_valM;
output reg [3:0] W_dstE;
output reg [3:0] W_dstM;


always@(posedge clk)
begin


 W_stat  <= m_stat;
 W_icode <= M_icode;
 W_dstE  <= M_dstE;
 W_dstM  <= M_dstM;
 W_valE  <= M_valE;
 W_valM  <= m_valM;

end
endmodule