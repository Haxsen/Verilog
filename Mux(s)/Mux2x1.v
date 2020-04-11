module Stim2x1();
	reg A,B,slc;
	wire out;
	Multiplexer obj(A, B, slc, out);

	initial 
		begin
			A=0; B=0; slc=0;
			#10
			A=1; B=0; slc=0;
			#10
			A=0; B=1; slc=1;
		end
endmodule