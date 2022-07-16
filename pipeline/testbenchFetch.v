module testbench();

reg clk;
reg [3:0] M_icode;
reg M_cnd;
reg [3:0] W_icode;
reg [63:0] M_valA;
reg [63:0] W_valM;
reg [63:0] F_predPC;
wire [3:0] f_rA;
wire [3:0] f_rB ;
wire [63:0] f_valC;
wire [63:0] f_PC;

reg [63:0] PC;
wire [3:0] f_icode;
wire [3:0] f_ifun;

wire [2:0] f_stat;                    // it stores the halt-0,instr_valid-1,imem_error-2
wire [63:0] f_valP;                   // it stores the new PC
reg [7:0] Instruction_memory [0:1023] ;     // it stores the insrtuction bytes
reg [63:0] Instruction;                     // it combines the needfull bytes for valC

wire [63:0] f_predPC1;
wire [63:0] f_predPC;
fetch  model(clk,F_predPC,f_stat,f_rA,f_rB,f_valC,f_icode,f_ifun,f_valP,f_PC,
             M_icode,M_cnd,M_valA,W_icode,W_valM,f_predPC);


initial begin
     $dumpfile("fetch.vcd");
    $dumpvars(0,testbench);
    clk=0;
 assign   F_predPC=64'd0;
end

always #5 clk=~clk;




 initial begin

           $monitor("f_predPC=%d  f_pc = %d clk=%d f=%d m=%d wb=%d",f_predPC,f_PC,clk,f_icode,M_icode,W_icode);
 end



endmodule