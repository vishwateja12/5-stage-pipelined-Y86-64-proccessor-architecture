module Predict_PC(clk,f_icode,f_valC,f_valP,f_predPC);

input clk;
input [3:0] f_icode;
input [63:0] f_valC;
input [63:0] f_valP;

output reg [63:0] f_predPC;


always@(*)
begin
  
  if ((f_icode == 0111) || (f_icode == 1000))
  f_predPC = f_valC;
  else f_predPC = f_valP;

end

endmodule