module datamemory#(parameter DWIDTH=32,
    parameter AWIDTH=32)
(input [DWIDTH-1:0] aluout,
input[2:0] MemRW,
input [DWIDTH-1:0] portb,
input clk,
output [DWIDTH-1:0] dataout);
reg [DWIDTH-1:0] memory[2*AWIDTH-1:0];
reg [31:0] dataout1;
wire [31:0] temp;
assign temp=memory[aluout];
always@(posedge clk)
begin
if(MemRW==3'b111)
begin
memory[aluout]=portb;
end
end
always@(*)
begin
case(MemRW)
3'b000:
begin
dataout1=temp[7]?{{24{1'b1}},temp[31:24]}:{{24{1'b1}},temp[31:24]};
end
3'b001:
dataout1=temp[15]?{{16{1'b1}},temp[31:15]}:{{16{1'b0}},temp[31:15]};
3'b011:
dataout1=temp;
3'b101:
dataout1={{16{1'b0}},temp[31:15]};
3'b110:
dataout1=temp;
endcase
end
assign dataout=dataout1;
endmodule

  
