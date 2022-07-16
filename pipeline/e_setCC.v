module destE(E_icode,m_stat,W_stat,setCC);

input [3:0] E_icode;
input [3:0] m_stat;
input [3:0] W_stat;
input [3:0] E_stat;
output reg setCC;


always@(*)
begin
   
   if ((E_icode==0110) && (!(W_stat)==E_stat) && (!(m_stat)==E_stat))
   setCC = 1;
   else setCC = 0;

end


endmodule