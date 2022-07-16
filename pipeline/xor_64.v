`timescale 1ns/1ps

module xor_64(ans,a,b);

input signed [63:0] a;
input signed [63:0] b;

output signed [63:0] ans;


genvar i;

generate for(i=0;i<=63;i=i+1)
begin
    
    xor g1 (ans[i],a[i],b[i]); 

end
endgenerate

endmodule