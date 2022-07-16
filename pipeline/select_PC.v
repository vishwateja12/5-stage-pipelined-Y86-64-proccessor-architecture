module select_PC(clk,M_icode,M_cnd,W_icode,M_valA,W_valM,F_predPC,f_PC);

input clk;
input [3:0] M_icode;
input M_cnd;
input [3:0] W_icode;
input [63:0] M_valA;
input [63:0] W_valM;
input [63:0] F_predPC;

output reg [63:0] f_PC;

always @(*)
begin

if((M_icode == 0111) && !M_cnd)
f_PC = M_valA;
else if (W_icode == 1001)
f_PC = W_valM;
else f_PC = F_predPC;

end

endmodule