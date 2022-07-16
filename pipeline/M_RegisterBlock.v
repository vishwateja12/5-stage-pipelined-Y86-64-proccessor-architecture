`timescale 1ns / 1ps

module M_RegisterBlock(clk,M_bubble,E_stat,E_icode,e_cnd,e_valE,E_valA,e_dstE,E_dstM,
                           M_stat,M_icode,M_cnd,M_valE,M_valA,M_dstE,M_dstM);  
  
input clk;
input M_bubble;
input [2:0] E_stat;
input [3:0] E_icode;
input [3:0] e_dstE;
input [3:0] E_dstM;
input [63:0] e_valE;
input [63:0] E_valA;
input e_cnd;
  

output reg [2:0] M_stat;
output reg [3:0] M_icode;
output reg [3:0] M_dstE;
output reg [3:0] M_dstM;
output reg [63:0] M_valE;
output reg [63:0] M_valA;
output reg M_cnd;


always@(posedge clk)
begin

    if(M_bubble)
    begin
         M_stat  <= 3'h1;
         M_icode <= 4'h1;
         M_cnd   <= 1;
         M_valE  <= 0;
         M_valA  <= 0;
         M_dstE  <= 4'h0;
         M_dstM  <= 4'h0;
    end
    else 
    begin

         M_stat  <= E_stat;
         M_icode <= E_icode;
         M_cnd   <= e_cnd;
         M_valE  <= e_valE;
         M_valA  <= E_valA;
         M_dstE  <= e_dstE;
         M_dstM  <= E_dstM;
    end

end
endmodule