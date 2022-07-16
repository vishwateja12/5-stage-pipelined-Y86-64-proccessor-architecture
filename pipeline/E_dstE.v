module E_dstE(clk,E_icode,e_cnd,E_dstE,e_dstE);

input clk;
input [3:0] E_icode;
input [3:0] E_dstE;
input e_cnd;
output reg [3:0] e_dstE;


always@(*)
begin
    
    if((E_icode == 0010) && !e_cnd)
    e_dstE <= 0;
    else e_dstE <= E_dstE;

end


endmodule