module comparator#(parameter DWIDTH=32)
(input [DWIDTH-1:0] porta,
input [DWIDTH-1:0] portb,
input [1:0] BrUn,
output BrEq,
output BrLT);
reg BrEq1;
reg BrLT1;
always@(*)
begin
if(BrUn==2'b00)
begin
BrEq1=($signed(porta)==$signed(portb))?1:0;
end
else if(BrUn==2'b01)
begin 
BrLT1=($unsigned (porta)<$unsigned(portb))?1:0;
end
end
assign BrEq=BrEq1;
assign BrLT=BrLT1;
endmodule






