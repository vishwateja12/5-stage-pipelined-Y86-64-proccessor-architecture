`timescale 1ns/1ps

`include"alu.v"

module execute(clk,icode,ifun,valA,valB,valC,valE,cnd,zeroflag,signflag,overflag);

input clk;
input [3:0] icode;
input [3:0] ifun;
input signed [63:0] valA;
input signed [63:0] valB;
input signed [63:0] valC;

output reg [63:0] valE;
output reg cnd;

output reg zeroflag;
output reg signflag;
output reg overflag;


always@(*) 
begin
    if(clk==0 && icode == 4'b0110)
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

//initialisation

initial 
 begin

     control = 2'b00;
     a=64'b0;
     b=64'b0;

 end

 always@(*)
 begin
     if(clk==0)
         begin

            cnd=0;

             if(icode==4'b0010)
                 begin

                     if(ifun==4'b0000)
                        begin
                            cnd=1;
                        end
                        else if(ifun==4'b0001)
                        begin

                            xor1 = signflag;
                            xor2 = overflag;

                            if(xor_out)
                            begin
                                cnd=1;
                            end
                            else if(zeroflag)
                            begin
                                cnd=1;
                            end
                        end
                        else if(ifun==4'b0010)
                        begin
                            xor1=signflag;
                            xor2=overflag;
                            if(xor_out)
                            begin
                                cnd=1;
                            end
                        end
                        else if(ifun==4'b0011)
                        begin
                            if(zeroflag)
                            begin
                                cnd=1;
                            end
                        end
                        else if(ifun==4'b0100)
                        begin
                            not1=zeroflag;
                            if(not_out)
                            begin
                                cnd=1;
                            end
                        end
                        else if(ifun==4'b0101)
                        begin
                            xor1=signflag;
                            xor2=overflag;
                            not1=xor_out;
                            if(not_out)
                            begin
                                cnd=1;
                            end
                        end
                        else if(ifun==4'b0110)
                        begin
                            xor1=signflag;
                            xor2=overflag;
                            not1=xor_out;
                            if(not_out)
                            begin
                                not1=zeroflag;
                                if(not_out)
                                begin
                                    cnd=1;
                                end
                            end
                        end

                        valE=64'd0+valA;
                 end

                    else if(icode==4'b0011)
                    begin
                        valE=64'd0+valC;
                    end

                    else if(icode==4'b0100)
                    begin
                        valE=valB+valC;
                    end

                    else if(icode==4'b0101)
                    begin
                        valE=valB+valC;
                    end

                 else if(icode==4'b0110)
                 begin
                        if(ifun==4'b0000)
                        begin
                            control=2'b00;
                            a=valA;
                            b=valB;
                        end
                        else if(ifun==4'b0001)
                        begin
                            control=2'b01;
                            a=valB;
                            b=valA;
                        end
                        else if(ifun==4'b0010)
                        begin
                            control=2'b10;
                            a=valA;
                            b=valB;
                        end
                        else if(ifun==4'b0011)
                        begin
                            control=2'b11;
                            a=valA;
                            b=valB;
                        end
                        assign fans=ans;
                        valE=fans;
                 end
                 if(icode==4'b0111)
                 begin
                     if(ifun==4'b0000)
                     begin
                         cnd=1;
                     end
                     else if(ifun==4'b0001)
                     begin
                         xor1=signflag;
                         xor2=overflag;
                         if(xor_out)
                         begin
                             cnd=1;
                         end
                         else if(zeroflag)
                         begin
                             cnd=1;
                         end
                     end
                     else if(ifun==4'b0010)
                     begin
                         xor1=signflag;
                         xor2=overflag;
                         if(xor_out)
                         begin
                             cnd=1;
                         end
                     end
                     else if(ifun==4'b0011)
                     begin
                         if(zeroflag)
                         begin
                             cnd=1;
                         end
                     end
                     else if(ifun==4'b0101)
                     begin
                         xor1=signflag;
                         xor2=overflag;
                         not1=xor_out;
                         if(not_out)
                         begin
                             cnd=1;
                         end
                     end
                     else if(ifun==4'b0110)
                     begin
                         xor1=signflag;
                         xor2=overflag;
                         not1=xor_out;
                         if(not_out)
                         begin
                             not1=zeroflag;
                             if(not_out)
                             begin
                                 cnd=1;
                             end
                         end
                     end
                     if(icode==4'b1000)
                     begin
                         valE=-64'd8+valB;
                     end
                     if(icode==4'b1001)
                     begin
                         valE=64'd8+valB;
                     end
                     if(icode==4'b1010)
                     begin
                         valE=-64'd8+valB;
                     end
                     if(icode==4'b1011)
                     begin
                         valE=64'd8+valB;
                     end
                 end
     
        end
    end

endmodule













