module alu #(parameter DWIDTH=32)
(input [3:0]ALUSEL,
input [DWIDTH-1:0] porta,
input [DWIDTH-1:0] portb,
output reg [DWIDTH-1:0] aluout );
always@(*)
case(ALUSEL)
4'b0000:
aluout=porta+portb;
4'b0001:
aluout=porta&portb;
4'b0010:
aluout=porta^portb;
4'b0011:
aluout=porta-portb;
4'b0100:
aluout=porta<<portb;
4'b0101:
aluout=($signed(porta)<$signed(portb))?1:0;
4'b0110:
aluout=(porta<portb)?1:0;
4'b0111:
aluout=porta>>portb;
4'b1000:
aluout=porta|portb;
endcase
endmodule











