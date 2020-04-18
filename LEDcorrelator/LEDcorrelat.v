`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:48:28 11/28/2019 
// Design Name: 
// Module Name:    task7_1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Task1(
input[1:0] switch,
output[6:0] led
);

reg[5:0] ROM[0:7];
reg[4:0] correlator;
reg[6:0] led;
wire[3:0] N;

assign N=2**(switch);

always @(*)
begin
 case(correlator)
 0: led = 7'b0000001; // "0"  
 1: led = 7'b1001111; // "1" 
 2: led = 7'b0010010; // "2" 
 3: led = 7'b0000110; // "3" 
 4: led = 7'b1001100; // "4" 
 5: led = 7'b0100100; // "5" 
 6: led = 7'b0100000; // "6" 
 7: led = 7'b0001111; // "7" 
 8: led = 7'b0000000; // "8"  
 9: led = 7'b0000100; // "9" 
 default: led = 7'b0000001; // "0"
 endcase
end

initial
begin
ROM[0]=6'b001001;
ROM[1]=6'b001001;
ROM[2]=6'b001001;
ROM[3]=6'b001001;
ROM[4]=6'b001001;
ROM[5]=6'b001001;
ROM[6]=6'b001001;
ROM[7]=6'b001001;
end

always@(*)
begin
case(N)
1:correlator=ROM[0][2:0]*ROM[0][5:3];
2:correlator=ROM[0][2:0]*ROM[0][5:3] + ROM[1][2:0]*ROM[1][5:3];
4:correlator=ROM[0][2:0]*ROM[0][5:3] + ROM[1][2:0]*ROM[1][5:3]+ROM[2][2:0]*ROM[2][5:3] + ROM[3][2:0]*ROM[3][5:3];
8:correlator=ROM[0][2:0]*ROM[0][5:3] + ROM[1][2:0]*ROM[1][5:3]+ROM[2][2:0]*ROM[2][5:3] + ROM[3][2:0]*ROM[3][5:3]+ROM[4][2:0]*ROM[4][5:3] + ROM[5][2:0]*ROM[5][5:3]+ROM[6][2:0]*ROM[6][5:3] + ROM[7][2:0]*ROM[7][5:3];
default:correlator=0;
endcase
end
endmodule
