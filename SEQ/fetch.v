module fetch(clk,PC,rA,rB,valC,icode,ifun,halt,valP,instr_valid,imem_error);

input clk;
input  [63:0] PC; 
output reg [3:0] rA;
output reg [3:0] rB ;
output reg [63:0] valC;

output reg [3:0] icode;
output reg [3:0] ifun;
output reg halt ;

output reg [63:0] valP;                 // it stores the new PC
output reg instr_valid;                     // it checks wheter itnstruction is true or false
output reg imem_error;                      // it checks where the PC is more than the instruction memeory or not
reg [7:0] Instruction_memory [0:1023] ; // it stores the insrtuction bytes
reg [63:0] Instruction;                 // it combines the needfull bytes for valC

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

               

always @(negedge clk) 
begin

Instruction = {Instruction_memory [PC+2],
               Instruction_memory [PC+3],
               Instruction_memory [PC+4],
               Instruction_memory [PC+5],
               Instruction_memory [PC+6],
               Instruction_memory [PC+7],              
               Instruction_memory [PC+8],               
               Instruction_memory [PC+9] };

 imem_error = 0 ;
if (PC>1023)
imem_error = 1'b1 ;



 icode = Instruction_memory [PC][7:4] ;
 ifun  = Instruction_memory [PC][3:0] ;

assign instr_valid = 1'b1 ;

case (icode)                
    4'b0000 : 
    begin                       // halt
    halt = 1'b1 ;
    valP = PC +1 ;
    end

    4'b0001:                    //nop
    valP=PC+1;
    
    4'b0010:                    //cmovxx
    begin
    rA = Instruction_memory [PC+1][7:4] ;
    rB = Instruction_memory [PC+1][3:0] ;
    valP = PC+64'd2;
    end

    4'b0011:                     //irmovq
    begin
    rA = Instruction_memory [PC+1][7:4] ;
    rB = Instruction_memory [PC+1][3:0] ;
    valC = Instruction ;
    valP = PC+64'd10;
    end

    4'b0100:                     //rmmovq
    begin
    rA = Instruction_memory [PC+1][7:4] ;
    rB = Instruction_memory [PC+1][3:0] ;
    valC = Instruction ;
    valP = PC+64'd10;
    end

    4'b0101:                    //mrmovq
    begin
    rA = Instruction_memory [PC+1][7:4] ;
    rB = Instruction_memory [PC+1][3:0] ;
    valC = Instruction ;
    valP = PC+64'd10;
    end

    4'b0110:                     //OPq
    begin
    rA = Instruction_memory [PC+1][7:4] ;
    rB = Instruction_memory [PC+1][3:0] ;
    valP = PC+64'd2;
    end

    4'b0111:                     //jxx
    begin
    valC={Instruction_memory[PC+1], Instruction[63:8]} ;
    valP=PC+64'd9;
    end
    
    4'b1000:                    //call
    begin
    valC={Instruction_memory[PC+1], Instruction[63:8]} ;
    valP=PC+64'd9;
    end

    4'b1001: 
    begin                     //ret
    valP = PC+64'd1;
    end

    4'b1010:                      //pushq
    begin
    rA = Instruction_memory [PC+1][7:4] ;
    rB = Instruction_memory [PC+1][3:0] ;
    valP = PC+64'd2;
    end

    4'b1011:                       //popq
    begin
    rA = Instruction_memory [PC+1][7:4] ;
    rB = Instruction_memory [PC+1][3:0] ;
    valP = PC+64'd2;
    end

    default:  instr_valid=1'b0;
  
endcase
end
endmodule


