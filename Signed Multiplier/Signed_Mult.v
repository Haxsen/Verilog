`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:30:06 12/12/2019 
// Design Name: 
// Module Name:    Signed_Mult 
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
module SignedMultiplication(a, b, seg_07, rstn, clk, pin );
parameter N = 3;

input [N-1:0] a, b;
integer i;
reg [2*N -1: 0] sum, t2, t3, t6, t7, out;
reg [N-1:0] t0, t1, t4, t5;

input clk, rstn;
output [7:0] seg_07;
output [3:0] pin;
reg [7:0] seg_07;
reg [25:0] delay;
reg [3:0] pin, disp;
reg  clk_disp;
reg [1:0] count;
wire [7:0] bin;
wire [11:0] bcd;

//------Lab's code------
always @ (*)
begin
	sum = 0;
	for (i=0; i < N-1; i = i+1)
	begin
		t0 = {N{b[i]}} & a;		// x bit by bit 
		t1 = {N{t0[N-1]}};		// MSB replicate 2
		t2 = {t1, t0};			// Concatenate
		t3 = t2 << i;			// shift to left
		sum = sum + t3;
	end
	t4 = {N{b[N-1]}} & (~a +1);		// x MSB with 2's compliment of 'a'
	t5 = {N{t4[N-1]}};					// MSB replicate 2
	t6 = {t5, t4};					// Concatenate
	t7 = t6 << N-1;					// shift to left
	out = sum + t7;					
end

//--------7 segment display code------------
always@(posedge clk, negedge rstn )
begin
	if(rstn == 0)
	delay <= 0;
	else begin
	delay <= delay + 1;
	clk_disp <= delay[17];	// clk for display created
	end
end

assign bin = out;
 bin2bcd obj_01 ( .bin(bin), .bcd(bcd) );
 
 always @(posedge clk_disp, negedge rstn)
 begin
	if(rstn == 0)
	count <= 0;
	else begin
	count <= count + 1;
	end
 end
always @ (*)	// assign values to 7 segment
begin
		if (count == 0)
		begin
			pin[3:0] = 1;
			pin [0] = 0;
			disp = bcd [3:0];
			case(disp)
				4'h0:  seg_07  = 7'b0000001;
				4'h1:  seg_07  = 7'b1001111;
				4'h2:  seg_07  = 7'b0010010;
				4'h3:  seg_07  = 7'b0000110;
				4'h4:  seg_07  = 7'b1001100;
				4'h5:  seg_07  = 7'b0100100;
				4'h6:  seg_07  = 7'b0100000;
				4'h7:  seg_07  = 7'b0001111;
				4'h8:  seg_07  = 7'b0000000;
				4'h9:  seg_07  = 7'b0000100;
				default : seg_07  = 7'b0000000;
			endcase
		end 
		else if (count == 1)
		begin
			pin[3:0] = 1;
			pin [1] = 0;
			disp = bcd [7:4];
			case(disp)
				4'h0:  seg_07  = 7'b0000001;
				4'h1:  seg_07  = 7'b1001111;
				4'h2:  seg_07  = 7'b0010010;
				4'h3:  seg_07  = 7'b0000110;
				4'h4:  seg_07  = 7'b1001100;
				4'h5:  seg_07  = 7'b0100100;
				4'h6:  seg_07  = 7'b0100000;
				4'h7:  seg_07  = 7'b0001111;
				4'h8:  seg_07  = 7'b0000000;
				4'h9:  seg_07  = 7'b0000100;
				default : seg_07  = 7'b0000000;
			endcase
		end
		else if (count == 2)
		begin
			pin[3:0] = 1;
			pin [2] = 0;
			disp = bcd [11:8];
			case(disp)
				4'h0:  seg_07  = 7'b0000001;
				4'h1:  seg_07  = 7'b1001111;
				4'h2:  seg_07  = 7'b0010010;
				4'h3:  seg_07  = 7'b0000110;
				4'h4:  seg_07  = 7'b1001100;
				4'h5:  seg_07  = 7'b0100100;
				4'h6:  seg_07  = 7'b0100000;
				4'h7:  seg_07  = 7'b0001111;
				4'h8:  seg_07  = 7'b0000000;
				4'h9:  seg_07  = 7'b0000100;
				default : seg_07  = 7'b0000000;
			endcase
		end
		else begin
			pin[3:1] = 1;
		end
end

endmodule


module bin2bcd( bin, bcd);
    //input ports and their sizes
    input [7:0] bin;
    //output ports and, their size
    output [11:0] bcd;
    //Internal variables
    reg [11 : 0] bcd; 
    reg [3:0] i;   
     
     //Always block - implement the Double Dabble algorithm
     always @(bin)
        begin
            bcd = 0; //initialize bcd to zero.
            for (i = 0; i < 8; i = i+1) //run for 8 iterations
            begin
                bcd = {bcd[10:0],bin[7-i]}; //concatenation
                    
                //if a hex digit of 'bcd' is more than 4, add 3 to it.  
                if(i < 7 && bcd[3:0] > 4) 
                    bcd[3:0] = bcd[3:0] + 3;
                if(i < 7 && bcd[7:4] > 4)
                    bcd[7:4] = bcd[7:4] + 3;
                if(i < 7 && bcd[11:8] > 4)
                    bcd[11:8] = bcd[11:8] + 3;  
            end
        end     
				
endmodule






