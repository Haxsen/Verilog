module ProgramCounter(in1,in2,in3,counter,clk,rst_n);
input[3:0] in1,in2,in3;
input clk,rst_n;
output [4:0] counter;

reg[4:0] counter;
//assign temp=out+1;

always@(posedge clk,negedge rst_n)
begin
if(!rst_n)
begin
counter<=0;
end
else if((in1==in2) && (in2==in3)==1)
begin
counter<=0;
end
else begin
counter=counter+1;
end
end
endmodule
