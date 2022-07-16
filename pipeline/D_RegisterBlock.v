 `timescale 1ns / 1ps

module D_RegisterBlock(clk,D_bubble,D_stall,D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,
                           f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP);  
  
input clk;
input D_bubble;
input D_stall;
input [2:0] f_stat;
input [3:0] f_icode;
input [3:0] f_ifun;
input [3:0] f_rA;
input [3:0] f_rB;
input [63:0] f_valC;
input [63:0] f_valP;
  

output reg [2:0] D_stat;
output reg [3:0] D_icode;
output reg [3:0] D_ifun;
output reg [3:0] D_rA;
output reg [3:0] D_rB;
output reg [63:0] D_valC;
output reg [63:0] D_valP;


always@(posedge (clk))
begin
    if(D_bubble)
    begin
        assign D_stat  = 3'h1;
        assign D_icode = 4'h1;
        assign D_ifun  = 4'h0;
        assign D_rA    = 4'h0;
        assign D_rB    = 4'h0;
        assign D_valC  = 0;
        assign D_valP  = 0;
    end
    else if(D_stall)
    begin
         D_stat  <= D_stat;
         D_icode <= D_icode;
         D_ifun  <= D_ifun;
         D_rA    <= D_rA;
         D_rB    <= D_rB;
         D_valC  <= D_valC;
         D_valP  <= D_valP;
    end
    else 
    begin
        D_stat  <= f_stat;
        D_icode <= f_icode;
        D_ifun  <= f_ifun;
        D_rA    <= f_rA;
        D_rB    <= f_rB;
        D_valC  <= f_valC;
        D_valP  <= f_valP;
    end

end
endmodule