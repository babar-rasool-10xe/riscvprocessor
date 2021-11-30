module regfile#(parameter DWIDTH=32,
AWIDTH=32)
(input [0:4] rs1 ,
input [0:4] rs2,
input [0:4] rd,
input clk,
input[DWIDTH-1:0] writedata,
input RegWen,
output [DWIDTH-1:0] porta,
output[DWIDTH-1:0] portb);
reg [0:31] reg1[AWIDTH-1:0];
assign porta=reg1[rs1];
assign portb=reg1[rs2];
integer i;
initial
begin
for(i=0;i<32;i=i+1)
begin
reg1[i]='b0;
end
end
always@(posedge clk)
begin
reg1[0]=32'b0;
if(RegWen)
reg1[rd]=writedata;
else
reg1[rd]=reg1[rd];
end

endmodule
//is there any need to initialize registers???




