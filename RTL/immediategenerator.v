module immediategenerator(input [31:0] instruction,
input [1:0] ImmSEL,
output  [31:0] immediate);
reg [31:0] immediate1;

always@(*)
begin
case(ImmSEL)
2'b00:
immediate1=instruction[31]?{{20{1'b1}},instruction[31:20]}:{{20{1'b1}},instruction[31:20]};
2'b01:
immediate1={{instruction[31:25]},instruction[11:7]};
2'b10:
immediate1={{instruction[12]},{instruction[7]},{instruction[10:5]},{instruction[11:8]}};
2'b11:
immediate1={{instruction[31]},{instruction[19:12]},{instruction[20]},{instruction[30:21]}};
endcase
end
assign immediate=immediate1;
endmodule


