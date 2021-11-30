module parsertb;
reg instruction;
wire [6:0] opcode;
wire [4:0] rs1;
wire[4:0] rs2;
wire [4:0] rd;
wire [2:0] func3;
wire[6:0] func7;
parser parser_int(.instruction(32'h00007033),
.opcode(opcode),
.rs1(rs1),
.rs2(rs2),
.rd(rd),
.func3(func3),
.func7(func7));
endmodule

