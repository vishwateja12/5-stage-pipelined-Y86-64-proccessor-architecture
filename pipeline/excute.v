`timescale 1ns/1ps
`include"alu.v"
`include "e_setCC.v"

module execute(clk,E_icode,E_ifun,E_valA,E_valB,E_valC,e_valE,W_stat,m_stat,E_dstE,e_dstE,E_dstM,E_stat,e_cnd,zeroflag,signflag,overflag);

input clk;
input [3:0] E_icode;
input [3:0] E_ifun;
input signed [63:0] E_valA;
input signed [63:0] E_valB;
input signed [63:0] E_valC;
inout [2:0] E_stat;
input [2:0] W_stat; 
input [2:0] m_stat;
input [3:0] E_dstE;
input [3:0] E_dstM;

output reg [63:0] e_valE;
output [3:0] e_dstE;
output reg e_cnd;

output reg zeroflag;
output reg signflag;
output reg overflag;


always@(*) 
begin
    if(clk==0 && E_icode == 4'b0110)
        begin

             zeroflag=(ans==1'b0);

             signflag=(ans<1'b0);

             overflag=(a<1'b0==b<1'b0)&&(ans<1'b0!=a<1'b0);

        end
end

initial begin
    zeroflag=0;
    signflag=0;
    overflag=0;
end

reg signed [63:0] fans;
reg [1:0] control;
reg signed [63:0] a;
reg signed [63:0] b;

wire signed [63:0] ans;
wire signed overflow;

alu module1(

    .ans(ans),
    .overflow(overflow),
    .control(control),
    .a(a),
    .b(b)

);

reg xor1;
reg xor2;
reg or1;
reg or2;
reg and1;
reg and2;
reg not1;

wire xor_out;
wire or_out;
wire and_out;
wire not_out;

xor g1(xor_out,xor1,xor2);
or g2(or_out,or1,or2);
and g3(and_out,and1,and2);
not g4(not_out,not1);
E_dstE g5(clk,E_icode,e_cnd,E_dstE,e_dstE);

//initialisation

initial 
 begin

     control = 2'b00;
     a=64'b0;
     b=64'b0;

 end

 always@(*)
 begin

            e_cnd=0;

             if(E_icode==4'b0010)
                 begin

                     if(E_ifun==4'b0000)
                        begin
                            e_cnd=1;
                        end
                        else if(E_ifun==4'b0001)
                        begin

                            xor1 = signflag;
                            xor2 = overflag;

                            if(xor_out)
                            begin
                                e_cnd=1;
                            end
                            else if(zeroflag)
                            begin
                                e_cnd=1;
                            end
                        end
                        else if(E_ifun==4'b0010)
                        begin
                            xor1=signflag;
                            xor2=overflag;
                            if(xor_out)
                            begin
                                e_cnd=1;
                            end
                        end
                        else if(E_ifun==4'b0011)
                        begin
                            if(zeroflag)
                            begin
                                e_cnd=1;
                            end
                        end
                        else if(E_ifun==4'b0100)
                        begin
                            not1=zeroflag;
                            if(not_out)
                            begin
                                e_cnd=1;
                            end
                        end
                        else if(E_ifun==4'b0101)
                        begin
                            xor1=signflag;
                            xor2=overflag;
                            not1=xor_out;
                            if(not_out)
                            begin
                                e_cnd=1;
                            end
                        end
                        else if(E_ifun==4'b0110)
                        begin
                            xor1=signflag;
                            xor2=overflag;
                            not1=xor_out;
                            if(not_out)
                            begin
                                not1=zeroflag;
                                if(not_out)
                                begin
                                    e_cnd=1;
                                end
                            end
                        end

                        e_valE=64'd0+E_valA;
                 end

                    else if(E_icode==4'b0011)
                    begin
                        e_valE=64'd0+E_valC;
                    end

                    else if(E_icode==4'b0100)
                    begin
                        e_valE=E_valB+E_valC;
                    end

                    else if(E_icode==4'b0101)
                    begin
                        e_valE=E_valB+E_valC;
                    end

                 else if(E_icode==4'b0110)
                 begin
                        if(E_ifun==4'b0000)
                        begin
                            control=2'b00;
                            a=E_valA;
                            b=E_valB;
                        end
                        else if(E_ifun==4'b0001)
                        begin
                            control=2'b01;
                            a=E_valB;
                            b=E_valA;
                        end
                        else if(E_ifun==4'b0010)
                        begin
                            control=2'b10;
                            a=E_valA;
                            b=E_valB;
                        end
                        else if(E_ifun==4'b0011)
                        begin
                            control=2'b11;
                            a=E_valA;
                            b=E_valB;
                        end
                        assign fans=ans;
                        e_valE=fans;
                 end
                 if(E_icode==4'b0111)
                 begin
                     if(E_ifun==4'b0000)
                     begin
                         e_cnd=1;
                     end
                     else if(E_ifun==4'b0001)
                     begin
                         xor1=signflag;
                         xor2=overflag;
                         if(xor_out)
                         begin
                             e_cnd=1;
                         end
                         else if(zeroflag)
                         begin
                             e_cnd=1;
                         end
                     end
                     else if(E_ifun==4'b0010)
                     begin
                         xor1=signflag;
                         xor2=overflag;
                         if(xor_out)
                         begin
                             e_cnd=1;
                         end
                     end
                     else if(E_ifun==4'b0011)
                     begin
                         if(zeroflag)
                         begin
                             e_cnd=1;
                         end
                     end
                     else if(E_ifun==4'b0101)
                     begin
                         xor1=signflag;
                         xor2=overflag;
                         not1=xor_out;
                         if(not_out)
                         begin
                             e_cnd=1;
                         end
                     end
                     else if(E_ifun==4'b0110)
                     begin
                         xor1=signflag;
                         xor2=overflag;
                         not1=xor_out;
                         if(not_out)
                         begin
                             not1=zeroflag;
                             if(not_out)
                             begin
                                 e_cnd=1;
                             end
                         end
                     end
                     if(E_icode==4'b1000)
                     begin
                         e_valE=-64'd8+E_valB;
                     end
                     if(E_icode==4'b1001)
                     begin
                         e_valE=64'd8+E_valB;
                     end
                     if(E_icode==4'b1010)
                     begin
                         e_valE=-64'd8+E_valB;
                     end
                     if(E_icode==4'b1011)
                     begin
                         e_valE=64'd8+E_valB;
                     end
                 end
     
        end

endmodule












