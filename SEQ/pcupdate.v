`timescale 1ns/1ps

module pcupdate(clk,PC,cnd,icode,valC,valM,valP,PC_update);

input clk;
input cnd;
input [3:0] icode;
input [63:0] valC;
input [63:0] valP;
input [63:0] valM;
input [63:0] PC;
output reg [63:0] PC_update;

always@(*)

    begin
         
         case(icode)
           
             4'b0000 : begin

                 PC_update = valP;

             end

             4'b0001 : begin

                 PC_update = valP;

             end

             4'b0010 : begin

                 PC_update = valP;

             end

             4'b0010 : begin

                 PC_update = valP;

             end

             4'b0011 : begin

                 PC_update = valP;

             end

             4'b0100 : begin

                 PC_update = valP;

             end

             4'b0101 : begin

                 PC_update = valP;

             end

             4'b0110 : begin 

                 PC_update = valP;

             end

             4'b0111 : begin

                 case(cnd)

                  1'b1 : begin

                      PC_update = valC;

                  end

                  1'b0 : begin

                      PC_update = valP;

                  end

                 endcase

             end


             4'b1000 : begin 

                 PC_update = valC;

             end

             4'b1001 : begin

                 PC_update = valM;

             end

             4'b1010 : begin 

                 PC_update = valP;

             end

             4'b1011 : begin

                 PC_update = valP;

             end

         endcase

    end

endmodule