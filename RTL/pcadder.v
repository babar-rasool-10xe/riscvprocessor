module pcadder#(parameter AWIDTH=32)
(input [AWIDTH-1:0] cnt_out,
output [AWIDTH-1:0] cnt_out1);
assign  cnt_out1=cnt_out+1;
endmodule


