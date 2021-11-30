module multiplexor#(parameter DWIDTH=32)
(input[DWIDTH-1:0]  a,
input [DWIDTH-1:0] b,
input sel,
output[DWIDTH-1:0] muxout);
assign muxout=sel?a:b;
endmodule

