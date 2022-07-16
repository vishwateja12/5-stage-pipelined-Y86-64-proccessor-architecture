`timescale 1ns / 1ps

`include "D_RegisterBlock.v"
`include "decode.v"
`include "E_RegisterBlock.v"
`include "excute.v"
`include "F_RegisterBlock.v"
`include "fetch.v"
`include "M_RegisterBlock.v"
`include "memory.v"
`include "W_RegisterBlock.v"

module Y8664;

reg clk;
reg [63:0] PC;

wire [63:0] f_PC;
wire [63:0] predPC;


wire [3:0] M_icode;
wire M_cnd;
wire [3:0] W_icode;
wire [63:0] W_valM;
wire  [3:0] f_rA;
wire  [3:0] f_rB;
wire  [63:0] f_valC;

wire  [3:0] f_icode;
wire  [3:0] f_ifun;

wire  [2:0] f_stat;
wire  [63:0] f_valP;
wire  [63:0] f_predPC;


wire [2:0] D_stat;
wire [3:0] D_icode;
wire [3:0] D_ifun;
wire [3:0] D_rA;
wire [3:0] D_rB;
wire [63:0] D_valC;
wire [63:0] D_valP;
wire [63:0] M_valE;
wire [3:0] M_dstE;
wire [3:0] M_dstM;
wire [3:0] W_dstM;
wire [3:0] W_dstE;
wire [63:0] W_valE;


wire  signed [63:0] d_valA;
wire  signed [63:0] d_valB;
wire  [3:0] d_srcA;
wire  [3:0] d_srcB;
wire  [3:0] d_dstE;
wire  [3:0] d_dstM;

wire  signed [63:0] d_rvalA;
wire  signed [63:0] d_rvalB;

wire  signed [63:0] rax;
wire  signed [63:0] rcx;
wire  signed [63:0] rdx;
wire  signed [63:0] rbx;
wire  signed [63:0] rsp;
wire  signed [63:0] rbp;
wire  signed [63:0] rsi;
wire  signed [63:0] rdi;
wire  signed [63:0] r8;
wire  signed [63:0] r9;
wire  signed [63:0] r10;
wire  signed [63:0] r11;
wire  signed [63:0] r12;
wire  signed [63:0] r13;
wire  signed [63:0] r14;
wire  signed [63:0] r15;

wire [3:0] E_icode;
wire [3:0] E_ifun;
wire signed [63:0] E_valA;
wire signed [63:0] E_valB;
wire signed [63:0] E_valC;
wire [2:0] E_stat;
wire [2:0] W_stat; 
wire [3:0] E_dstE;
wire [3:0] E_dstM;

wire  [63:0] e_valE;
wire  [3:0] e_dstE;
wire  e_cnd;

wire  zeroflag;
wire  signflag;
wire  overflag;


wire [2:0] M_stat;
wire [63:0] M_valA;

wire  [2:0] m_stat;
wire  [63:0] m_valM; 


reg D_bubble;
reg D_stall;

reg E_bubble;

reg M_bubble;
reg [63:0] F_predPC;




//F_RegisterBlock m34 (clk,f_predPC,F_predPC);

fetch m3 (clk,F_predPC,f_stat,f_rA,f_rB,f_valC,f_icode,f_ifun,f_valP,f_PC,M_icode,M_cnd,M_valA,W_icode,W_valM,f_predPC);

E_RegisterBlock  m6 (clk,E_bubble,D_stat,D_icode,D_ifun,d_valA,d_valB,D_valC,d_dstE,d_dstM,E_stat,E_icode,E_ifun,E_valA,E_valB,E_valC,E_dstE,E_dstM);  

execute m7 (clk,E_icode,E_ifun,E_valA,E_valB,E_valC,e_valE,W_stat,m_stat,E_dstE,e_dstE,E_dstM,E_stat,e_cnd,zeroflag,signflag,overflag);

D_RegisterBlock m4 (clk,D_bubble,D_stall,D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP);

decode  m5 (clk,D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,W_valM,W_valE,d_valA,d_valB,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15, e_dstE,e_valE,M_dstE,M_valE,M_dstM,m_valM,W_dstE,W_dstM,W_valE,W_valM,d_srcA,d_srcB,d_dstE,d_dstM,e_cnd) ;

M_RegisterBlock m8 (clk,M_bubble,E_stat,E_icode,e_cnd,e_valE,E_valA,e_dstE,E_dstM,M_stat,M_icode,M_cnd,M_valE,M_valA,M_dstE,M_dstM);

memory m9 (clk,M_stat,M_icode,M_valA,M_valE,m_stat,m_valM); 

W_RegisterBlock m10 (clk,m_stat,M_icode,M_valE,m_valM,M_dstE,M_dstM,W_stat,W_icode,W_valE,W_valM,W_dstE,W_dstM);

initial begin

    $dumpfile("pipe.vcd");
    $dumpvars(0,Y8664);
    clk=0;
    F_predPC = 0;
end

    always @(posedge(clk))
    begin
    // predPC = f_predPC;
    F_predPC <= f_predPC;    
 	D_bubble 	= 	(E_icode == 4'h7 && !e_cnd)	|| 
						!((E_icode == 4'h5 || E_icode == 4'hB) && (E_dstM == d_srcA || E_dstM == d_srcB)) && 
						(D_icode == 4'h9 || E_icode == 4'h9 || M_icode == 4'h9);
	D_stall 	= 	(E_icode == 4'h5 || E_icode == 4'hB) && (E_dstM == d_srcA || E_dstM == d_srcB);
 	E_bubble 	= 	(E_icode == 4'h7 && !e_cnd) || (E_icode == 4'h5 || E_icode == 4'hB) && (E_dstM == d_srcA || E_dstM == d_srcB);
 	M_bubble 	=	(m_stat == 3'h2 || m_stat == 3'h3 || m_stat == 3'h1) ||  (W_stat == 3'h2 || W_stat == 3'h3 || W_stat == 3'h1);
    end

always #5 clk=~clk;



initial
    #200 $finish;

 initial begin

           $monitor("f_predPC=%d f_PC=%d  clk=%d f=%d d=%d e=%d m=%d wb=%d",f_predPC,f_PC,clk,f_icode,D_icode,E_icode,M_icode,W_icode);
 end

endmodule

