module HexCounter(clk,rst_n,sig); 
input clk,rst_n;
output [25:0] sig;
reg [3:0]hex;
reg [25:0]sig;

//assign clk=(sig<=30000000)

always@(posedge clk,negedge rst_n)
begin
if(!rst_n)
begin
hex<=0;
end
else if(sig==0)
begin
hex<=hex+1;
end
end

always@(posedge clk,negedge rst_n)
begin
if(rst_n==0)
begin
sig<=0;
end
else if(sig<=(30-1))
begin
sig=sig+1;
end
else
begin
sig<=0;
end
end

endmodule
