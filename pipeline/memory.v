`timescale 1ns/1ps

module memory(clk,M_stat,M_icode,M_valA,M_valE,m_stat,m_valM);
        
integer i=0;
input clk;
input [2:0] M_stat;
input [3:0] M_icode;
input [63:0] M_valA;
input [63:0] M_valE;

output reg [2:0] m_stat;
output reg [63:0] m_valM;           // data
reg [63:0] data_mem[0:1023];

initial begin

for(i=0;i<1024;i=i+1) begin

data_mem[i]=64'd2;

         end

 
        end

     always@(*)
        begin

            case(M_icode)
            
                    4'b0100 : begin
                        //rmmovq
                        data_mem[M_valE] = M_valA;

                    end

                    4'b0101 : begin
                        //mrmovq
                        m_valM = data_mem[M_valE];
                    end

                    4'b1000 : begin
                        //call
                        data_mem[M_valE] = M_valA;
                    end

                    4'b1001 : begin
                        //ret
                        m_valM = data_mem[M_valA];
                    end

                    4'b1010 : begin
                        //pushq
                        data_mem[M_valE] = M_valA;
                    end

                    4'b1011 : begin
                        //popq
                        m_valM = data_mem[M_valE];
                    end
            endcase

            m_valM = data_mem[M_valE];


        end

    endmodule
