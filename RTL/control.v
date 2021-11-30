module control#( parameter instructionwidth=32)
(input [instructionwidth-1:0] instruction,
	input BrEq,
	input  BrLT,
	output reg [1:0] BrUn,
	output reg[1:0] ImmSel,
	output  RegWEn,
	output reg [1:0]WBSel,
	output [3:0] ALUSeL,
	output reg[2:0] MemRW,
	output reg BSel,
        output reg ASel,
         output reg PCSel);
	wire [6:0] opcode;
	wire[4:0] rs1;
	wire[4:0] rs2;
	wire [4:0] rd;
	wire [2:0] func3;
	wire [6:0] func7;
assign opcode=instruction[6:0];
assign rs1=instruction[19:15];
assign rs2=instruction[24:20];
assign rd=instruction[11:7];
assign func3=instruction[14:12];
assign func7=instruction[31:25];
localparam [6:0] RTYPE=7'b0000011;
localparam [6:0] ITYPE_1=7'b0001111;
localparam[6:0] ITYPE_2=7'b0010011;
localparam[6:0] ITYPE_3=7'b0011011;
localparam[6:0] SB=7'b1100011;
localparam[6:0] U=7'b0010111;
localparam[6:0] UJ=7'b1101111;
localparam[6:0] ITYPE_4=7'b1100111;
localparam[6:0] S=7'b0100011;
wire [3:0] temp;
reg [3:0] ALUSEL1;
assign temp={func3[2:0],func7[5]};
always@(*)
	begin
	case(opcode)
RTYPE:
case(temp)
4'b0000:
begin
ALUSEL1=4'b0000;
WBSel=2'b01;
ASel=0;
BSel=0;
end
4'b0001:
begin
ALUSEL1=4'b0011;
WBSel=2'b01;
ASel=0;
BSel=0;
end
4'b0010:
begin
ALUSEL1=4'b0100;
WBSel=2'b01;
ASel=0;
BSel=0;
end
4'b0100:
begin
ALUSEL1=4'b010;
WBSel=2'b01;
ASel=0;
BSel=0;
end
4'b0110:
begin
ALUSEL1=4'b0110;
WBSel=2'b01;
ASel=0;
BSel=0;
end
4'b1000:
begin
ALUSEL1=4'b0011;
WBSel=2'b01;
ASel=0;
BSel=0;
end
4'b1010:
begin
ALUSEL1=4'b0111;
WBSel=2'b01;
ASel=0;
BSel=0;
end
4'b1100:
begin
ALUSEL1=4'b1000;
WBSel=2'b01;
ASel=0;
BSel=0;
end
4'b1110:
begin
ALUSEL1=4'b0001;
WBSel=2'b01;
ASel=0;
BSel=0;
end
endcase
ITYPE_2:
case(func3)
3'b000:
begin
ImmSel=2'b00;
ALUSEL1=4'b0000;
WBSel=2'b01;
BSel=1;
ASel=0;
end
3'b001:
begin
WBSel=2'b01;
ImmSel=2'b00;
ALUSEL1=4'b0100;
BSel=1;
ASel=0;
end
3'b010:
begin
ImmSel=2'b00;
WBSel=2'b01;
ALUSEL1=4'b010;
BSel=1;
ASel=0;
end
3'b011:
begin
ALUSEL1=4'b0110;
ImmSel=2'b00;
WBSel=2'b01;
BSel=1;
ASel=0;
end
endcase
ITYPE_3:
case(func3)
3'b000:
begin
ImmSel=2'b00;
ALUSEL1=4'b0000;
WBSel=2'b01;
BSel=1;
ASel=0;
end
3'b001:
begin
WBSel=2'b01;
ImmSel=2'b00;
ALUSEL1=4'b0100;
BSel=1;
ASel=0;
end
3'b010:
begin
ImmSel=2'b00;
WBSel=2'b01;
ALUSEL1=4'b010;
BSel=1;
ASel=0;
end
3'b011:
begin
ALUSEL1=4'b0110;
ImmSel=2'b00;
BSel=1'b1;
WBSel=2'b01;
ASel=0;
end
endcase
ITYPE_1:
case(func3)
3'b000:
begin
ALUSEL1=4'b0000;
MemRW=3'b000;
BSel=1;
WBSel=2'b00;
end
3'b001:
begin
ALUSEL1=4'b0000;
MemRW=3'b001;
ASel=0;
WBSel=2'b00;
BSel=1;
end
3'b010:
begin
ALUSEL1=4'b0000;
MemRW=3'b010;
ASel=0;
WBSel=2'b00;
BSel=1;
end
3'b101:
begin
ALUSEL1=4'b0000;
MemRW=3'b101;
ASel=0;
WBSel=2'b00;
BSel=1;
end
3'b110:
begin
ALUSEL1=4'b0000;
MemRW=3'b110;
ASel=0;
WBSel=2'b00;
BSel=1;
end
endcase
S:
begin
MemRW=3'b111;
ALUSEL1=4'b0000;
ASel=0;
BSel=1;
ImmSel=2'b01;
end
SB:
case(func3)
3'b000:
begin
BrUn=2'b00;
if(BrEq)
begin
PCSel=1;
ASel=1;
BSel=1;
ImmSel=2'b10;
ALUSEL1=4'b0000;
end
else
begin
PCSel=0;
ASel=0;
BSel=0;
end
end
3'b110:
begin
BrUn=2'b01;
if(BrLT)
begin
PCSel=1;
ASel=1;
BSel=1;
ImmSel=2'b10;
ALUSEL1=4'b0000;
end
else
begin
PCSel=0;
ASel=0;
BSel=0;
end
end
endcase
ITYPE_4:
begin
ALUSEL1=4'b0000;
PCSel=1;
WBSel=2'b10;
end
UJ:
begin
ImmSel=2'b11;
WBSel=2'b10;
PCSel=1;
end
endcase
end
assign ALUSeL=ALUSEL1;
assign RegWEn=(opcode==RTYPE||opcode==ITYPE_1||opcode==ITYPE_2||opcode==ITYPE_3)?1:0;
endmodule

