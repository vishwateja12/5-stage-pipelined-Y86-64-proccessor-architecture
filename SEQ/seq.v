`timescale 1ns/1ps

`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
`include "pcupdate.v"

module seq;

reg clk;

reg [63:0] PC;

reg stat[0:2];

wire [3:0] icode;
wire [3:0] ifun;
wire [3:0] rA;
wire [3:0] rB;

wire [63:0] valC;
wire [63:0] valP;
wire signed [63:0] valA;
wire signed [63:0] valB;
wire [63:0] valE;
wire [63:0] valM;
wire [63:0] PC_update;
wire signed [63:0] rax;
wire signed [63:0] rcx;
wire signed [63:0] rdx;
wire signed [63:0] rbx;
wire signed [63:0] rsp;
wire signed [63:0] rbp;
wire signed [63:0] rsi;
wire signed [63:0] rdi;
wire signed [63:0] r8;
wire signed [63:0] r9;
wire signed [63:0] r10;
wire signed [63:0] r11;
wire signed [63:0] r12;
wire signed [63:0] r13;
wire signed [63:0] r14;
wire signed [63:0] data;

wire cnd;
wire haltins;
wire Instr_Valid;
wire imem_error;
wire zeroflag;
wire signflag;
wire overflag;

fetch module1 (
    .clk(clk),
    .PC(PC),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .icode(icode),
    .ifun(ifun),
    .halt(haltins),
    .valP(valP),
    .instr_valid(instr_valid),
    .imem_error(imem_error)
    );

    execute module2(
        .clk(clk),
        .icode(icode),
        .ifun(ifun),
        .valA(valA),
        .valB(valB),
        .valC(valC),
        .valE(valE),
        .cnd(cnd),
        .zeroflag(zeroflag),
        .signflag(signflag),
        .overflag(overflag)
    );

   //clk,icode,rA,rB,cnd,valA,valB,valM,valE,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14
    decode module3(
        .clk(clk),
        .icode(icode),
        .rA(rA),
        .rB(rB),
        .cnd(cnd),
        .valA(valA),
        .valB(valB),
        .valM(valM),
        .valE(valE),
        .rax(rax),
        .rcx(rcx),
        .rdx(rdx),
        .rbx(rbx),
        .rsp(rsp),
        .rbp(rbp),
        .rsi(rsi),
        .rdi(rdi),
        .r8(r8),
        .r9(r9),
        .r10(r10),
        .r11(r11),
        .r12(r12),
        .r13(r13),
        .r14(r14)
    );
    
     //clk,icode,valA,valB,valE,valP,valM,data
    memory module4(
        .clk(clk),
        .icode(icode),
        .valA(valA),
        .valB(valB),
        .valE(valE),
        .valP(valP),
        .valM(valM),
        .data(data)
    );
  
    //clk,PC,cnd,icode,valC,valM,valP,PC_update
    pcupdate module5(
        .clk(clk),
        .PC(PC),
        .cnd(cnd),
        .icode(icode),
        .valC(valC),
        .valM(valM),
        .valP(valP),
        .PC_update(PC_update)
    );

 always #20 clk=~clk;

 initial begin

    $dumpfile("seq.vcd");
    $dumpvars(0,seq);
    stat[0]=1;
    stat[1]=0;
    stat[2]=0;
    clk=0;
    PC=64'd0;
 end

 always@(*)
 begin
     PC=PC_update;
 end

 always@(*)
 begin
     if(haltins)
     begin
         stat[2]=haltins;
         stat[1]=1'b0;
         stat[0]=1'b0;
     end
     else if(instr_valid)
     begin
         stat[1]=instr_valid;
         stat[2]=1'b0;
         stat[0]=1'b0;
     end
     else
     begin
         stat[0]=1'b1;
         stat[1]=1'b0;
         stat[2]=1'b0;
     end
 end
 always@(*)
begin
    if(stat[2]==1'b1)
    begin
        $finish;
    end
end

initial

  $monitor("PC=%d\n clk=%d\n icode=%b\n ifun=%b\n rA=%b\n rB=%b\n valA=%d\n valB=%d\n valC=%d\n valE=%d\n valM=%d\n instr_valid=%d\n imem_error=%d\n cnd=%d\n halt=%d\n rax=%d\n rcx=%d\n rdx=%d\n rbx=%d\n rsp=%d\n rbp=%d\n rsi=%d\n rdi=%d\n r8=%d\n r9=%d\n r10=%d\n r11=%d\n r12=%d\n r13=%d\n r14=%d\n data=%d \n ",PC,clk,icode,ifun,rA,rB,valA,valB,valC,valE,valM,instr_valid,imem_error,cnd,stat[2],rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,data);

endmodule





