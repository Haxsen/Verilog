module Stim4x1();
	reg A,B, C,D;
	reg [1:0] slc;
	wire out1, out2, final_out;
	Multiplexer obj(A, B, slc[0], out1);
	Multiplexer obj1(C, D, slc[0], out2);
	Multiplexer obj2(out1, out2, slc[1], final_out);

	initial 
		begin
			A=0; B=0; C=0; D=0; slc[0]=0; slc[1]=0;
			#10
			A=1; B=0; C=1; D=0; slc[0]=0; slc[1]=1;
			#10
			A=0; B=1; C=0; D=1; slc[0]=1; slc[1]=0;
			#10
			A=1; B=0; C=1; D=1; slc[0]=1; slc[1]=1;
		end
endmodule