`timescale 1ns/1ps
`include "D_srcA.v"
`include "D_srcB.v"
`include "D_destE.v"
`include "D_destM.v"
`include "E_dstE.v"
`include "SelectiveAndForwardA.v"
`include "ForwardB.v"


module decode(clk,D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,W_valM,W_valE,d_valA,d_valB,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15,
              e_dstE,e_valE,M_dstE,M_valE,M_dstM,m_valM,W_dstE,W_dstM,W_valE,W_valM,d_srcA,d_srcB,d_dstE,d_dstM,e_cnd) ;


input clk;
input e_cnd;
input  [2:0] D_stat;
input  [3:0] D_icode;
input  [3:0] D_ifun;
input  [3:0] D_rA;
input  [3:0] D_rB;
input  [63:0] D_valC;
input  [63:0] D_valP;
input  [3:0] e_dstE;
input  [63:0] e_valE;
input  [63:0] M_valE;
input  [3:0] M_dstE;
input  [3:0] M_dstM;
input  [63:0] m_valM;
input  [3:0] W_dstM;
input  [63:0] W_valM;
input  [3:0] W_dstE;
input  [63:0] W_valE;

wire [3:0] d_srcA1;
wire [3:0] d_srcB1;
wire [3:0] d_dstE1;
wire [3:0] d_dstM1;
wire [63:0] d_valA1;
wire [63:0] d_valB1;

output reg signed [63:0] d_valA;
output reg signed [63:0] d_valB;
output reg [3:0] d_srcA;
output reg [3:0] d_srcB;
output reg [3:0] d_dstE;
output reg [3:0] d_dstM;

output reg signed [63:0] d_rvalA;
output reg signed [63:0] d_rvalB;

output reg signed [63:0] rax;
output reg signed [63:0] rcx;
output reg signed [63:0] rdx;
output reg signed [63:0] rbx;
output reg signed [63:0] rsp;
output reg signed [63:0] rbp;
output reg signed [63:0] rsi;
output reg signed [63:0] rdi;
output reg signed [63:0] r8;
output reg signed [63:0] r9;
output reg signed [63:0] r10;
output reg signed [63:0] r11;
output reg signed [63:0] r12;
output reg signed [63:0] r13;
output reg signed [63:0] r14;
output reg signed [63:0] r15;

reg [63:0] reg_mem[0:15];


D_srcA Model(clk,D_icode,D_rA,d_srcA1);
D_srcB Model2(clk,D_icode,D_rB,d_srcB1);    
D_destE Model3(clk,D_icode,D_rB,d_dstE1);
D_destM Model4(clk,D_icode,D_rA,d_dstM1); 
SelectiveAndForwardA Ablock(clk,e_dstE,e_valE,M_dstE,M_valE,M_dstM,m_valM,W_dstE,W_dstM,W_valE,W_valM,
                           D_icode,D_valP,d_rvalA,d_srcA,d_valA1);
ForwardB Block(clk,e_dstE,e_valE,M_dstE,M_valE,M_dstM,m_valM,W_dstE,W_dstM,W_valE,W_valM,
                           d_rvalB,d_srcB,d_valB1);


initial begin
reg_mem[0] = 64'd0;
reg_mem[1] = 64'd2;
reg_mem[2] = 64'd4;
reg_mem[3] = 64'd6;
reg_mem[4] = 64'd8;
reg_mem[5] = 64'd16;
reg_mem[6] = 64'd32;
reg_mem[7] = 64'd64;
reg_mem[8] = 64'd128;
reg_mem[9] = 64'd256;
reg_mem[10] = 64'd512;
reg_mem[11] = 64'd1024;
reg_mem[12] = 64'd2048;
reg_mem[13] = 64'd4096;
reg_mem[14] = 64'd8192;
reg_mem[15] = 64'hffffffffffffffff;
end

initial begin


    rax = reg_mem[0];
    rcx = reg_mem[1];
    rdx = reg_mem[2];
    rbx = reg_mem[3];
    rsp = reg_mem[4];
    rbp = reg_mem[5];
    rsi = reg_mem[6];
    rdi = reg_mem[7];
    r8 = reg_mem[8];
    r9 = reg_mem[9];
    r10 = reg_mem[10];
    r11 = reg_mem[11];
    r12 = reg_mem[12];
    r13 = reg_mem[13];
    r14 = reg_mem[14];
    r15 = reg_mem[15];


end



always@(*)
begin
 
   d_srcA <= d_srcA1;
   d_srcB <= d_srcB1;
   d_dstE <= d_dstE1;
   d_dstM <= d_dstM1;
   d_valA <= d_valA1;
   d_valB <= d_valB1;


 d_rvalA = reg_mem[d_srcA];
     d_rvalB = reg_mem[d_srcB];

   if(W_dstE != 15)
   reg_mem [W_dstE] = W_valE;
   if(W_dstM != 15)
   reg_mem [W_dstM] = W_valM; 

  

//    case(D_icode)

//         4'b0010 :                //cmovxx
//         if(e_cnd==1'b1)
//         reg_mem[D_rB] = W_valE;

//         4'b0011 :                //irmovq
//         reg_mem[D_rB] = W_valE;

//         4'b0101 :                //mrmovq
//         reg_mem[D_rA] = W_valM;

//         4'b0110 :                //OPq
//         reg_mem[D_rB] = W_valE;

//         4'b1000 :                  //call
//         reg_mem[4] = W_valE;
            
//         4'b1001 :                  //ret
//         reg_mem[4] = W_valE;

//         4'b1010 :                 //pushq
//         reg_mem[4] = W_valE;

//         4'b1011 : 
//         begin                   //popq
//         reg_mem[4] = W_valE;
//         reg_mem[D_rA] = W_valM;
//         end

//     endcase   

    rax = reg_mem[0];
    rcx = reg_mem[1];
    rdx = reg_mem[2];
    rbx = reg_mem[3];
    rsp = reg_mem[4];
    rbp = reg_mem[5];
    rsi = reg_mem[6];
    rdi = reg_mem[7];
    r8 = reg_mem[8];
    r9 = reg_mem[9];
    r10 = reg_mem[10];
    r11 = reg_mem[11];
    r12 = reg_mem[12];
    r13 = reg_mem[13];
    r14 = reg_mem[14];
    r15 = reg_mem[15];

end




endmodule