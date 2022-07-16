`timescale 1ns / 1ps

module E_RegisterBlock(clk,E_bubble,D_stat,D_icode,D_ifun,d_valA,d_valB,D_valC,d_dstE,d_dstM,
                           E_stat,E_icode,E_ifun,E_valA,E_valB,E_valC,E_dstE,E_dstM);  
  
input clk;
input E_bubble;
input [2:0] D_stat;
input [3:0] D_icode;
input [3:0] D_ifun;
input [63:0] d_valA;
input [63:0] d_valB;
input [63:0] D_valC;
input [3:0] d_dstE;
input [3:0] d_dstM;

output reg [2:0] E_stat;
output reg [3:0] E_icode;
output reg [3:0] E_ifun;
output reg [63:0] E_valA;
output reg [63:0] E_valB;
output reg [63:0] E_valC;
output reg [3:0] E_dstE;
output reg [3:0] E_dstM;


always@(posedge clk)
begin
    if(E_bubble)
        begin

             E_stat  <= 3'h0;
             E_icode <= 4'h1;
             E_ifun  <= 4'h0;
             E_valA  <= 0;
             E_valB  <= 0;
             E_valC  <= 0;
             E_dstE  <= 4'h0;
             E_dstM  <= 4'h0;

        end
        else
        begin

             E_stat  <= D_stat;
             E_icode <= D_icode;
             E_ifun  <= D_ifun;
             E_valA  <= d_valA;
             E_valB  <= d_valB;
             E_valC  <= D_valC;
             E_dstE  <= d_dstE;
             E_dstM  <= d_dstM;
        end

end
endmodule