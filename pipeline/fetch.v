`timescale 1ns/1ps
`include "Predict_PC.v"
`include "select_PC.v"

module fetch(clk,F_predPC,f_stat,f_rA,f_rB,f_valC,f_icode,f_ifun,f_valP,f_PC,
             M_icode,M_cnd,M_valA,W_icode,W_valM,f_predPC);


input clk;
input [3:0] M_icode;
input M_cnd;
input [3:0] W_icode;
input [63:0] M_valA;
input [63:0] W_valM;
input [63:0] F_predPC;
output reg [3:0] f_rA;
output reg [3:0] f_rB ;
output reg [63:0] f_valC;

input [63:0] PC;
output reg [3:0] f_icode;
output reg [3:0] f_ifun;

output reg [2:0] f_stat;                    // it stores the halt-0,instr_valid-1,imem_error-2
output reg [63:0] f_valP;                   // it stores the new PC
reg [7:0] Instruction_memory [0:1023] ;     // it stores the insrtuction bytes
reg [63:0] Instruction;                     // it combines the needfull bytes for valC

wire [63:0] f_predPC1;
output [63:0] f_PC;
output [63:0] f_predPC;

select_PC Model(clk,M_icode,M_cnd,W_icode,M_valA,W_valM,F_predPC,f_PC);
Predict_PC Model2(clk,f_icode,f_valC,f_valP,f_predPC);


initial begin

    
    Instruction_memory[0]=8'b00010000; // 1 0
    Instruction_memory[1]=8'b01100001; //6 fn
    Instruction_memory[2]=8'b01110110; //rA rB
    Instruction_memory[3]=8'b00010000;
    Instruction_memory[4]=8'b00010000;

    Instruction_memory[5]=8'b00100000;
    Instruction_memory[6]=8'b00000010;
    Instruction_memory[7]=8'b00010000;
    Instruction_memory[8]=8'b00010000;
    Instruction_memory[9]=8'b00000000;


end

               

always @(posedge clk) 
begin

Instruction = {Instruction_memory [f_PC+2],
               Instruction_memory [f_PC+3],
               Instruction_memory [f_PC+4],
               Instruction_memory [f_PC+5],
               Instruction_memory [f_PC+6],
               Instruction_memory [f_PC+7],              
               Instruction_memory [f_PC+8],               
               Instruction_memory [f_PC+9] };

end

 
always @(*) begin
    
 f_icode <= Instruction_memory [f_PC][7:4] ;
 f_ifun  <= Instruction_memory [f_PC][3:0] ;
 f_stat[2] = 0 ;
if (f_PC>1023)
f_stat[2] = 1'b1 ;




f_stat[1] = 1'b1 ;
case (f_icode)                
    4'b0000 : 
    begin                       // halt
    f_stat[0] = 1'b1 ;
    f_valP = f_PC +64'd1 ;
    end

    4'b0001:                    //nop
    f_valP=f_PC+1;
    
    4'b0010:                    //cmovxx
    begin
    f_rA = Instruction_memory [f_PC+1][7:4] ;
    f_rB = Instruction_memory [f_PC+1][3:0] ;
    f_valP = f_PC+64'd2;
    end

    4'b0011:                     //irmovq
    begin
    f_rA = Instruction_memory [f_PC+1][7:4] ;
    f_rB = Instruction_memory [f_PC+1][3:0] ;
    f_valC = Instruction ;
    f_valP = f_PC+64'd10;
    end

    4'b0100:                     //rmmovq
    begin
    f_rA = Instruction_memory [f_PC+1][7:4] ;
    f_rB = Instruction_memory [f_PC+1][3:0] ;
    f_valC = Instruction ;
    f_valP = f_PC+64'd10;
    end

    4'b0101:                    //mrmovq
    begin
    f_rA = Instruction_memory [f_PC+1][7:4] ;
    f_rB = Instruction_memory [f_PC+1][3:0] ;
    f_valC = Instruction ;
    f_valP = f_PC+64'd10;
    end

    4'b0110:                     //OPq
    begin
    f_rA = Instruction_memory [f_PC+1][7:4] ;
    f_rB = Instruction_memory [f_PC+1][3:0] ;
    f_valP = f_PC+64'd2;
    end

    4'b0111:                     //jxx
    begin
    f_valC={Instruction_memory[f_PC+1], Instruction[63:8]} ;
    f_valP=f_PC+64'd9;
    end
    
    4'b1000:                    //call
    begin
    f_valC={Instruction_memory[f_PC+1], Instruction[63:8]} ;
    f_valP=f_PC+64'd9;
    end

    4'b1001: 
    begin                     //ret
    f_valP = f_PC+64'd1;
    end

    4'b1010:                      //pushq
    begin
    f_rA = Instruction_memory [f_PC+1][7:4] ;
    f_rB = Instruction_memory [f_PC+1][3:0] ;
    f_valP = f_PC+64'd2;
    end

    4'b1011:                       //popq
    begin
    f_rA = Instruction_memory [f_PC+1][7:4] ;
    f_rB = Instruction_memory [f_PC+1][3:0] ;
    f_valP = f_PC+64'd2;
    end

    default:  f_stat[1]=1'b0;
  
endcase

//Predict_PC Model(f_icode,f_valC,f_valP,f_predPC1);
end

//Predict_PC Model2(clk,f_icode,f_valC,f_valP,f_predPC1);

// initial begin
//     f_predPC = f_predPC1;
// end


endmodule

