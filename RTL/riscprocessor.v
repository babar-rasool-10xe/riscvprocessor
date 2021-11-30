module riscprocessor(
input CLK,
input rst
);

	localparam  integer AWIDTH=32,DWIDTH=32;
        localparam integer instructionwidth=32;
	wire [AWIDTH-1:0] cnt_out;
        wire [AWIDTH-1:0] cnt_out1;
        wire[31:0] muxout1;
        programcounter#(.WIDTH(AWIDTH))
	programcounter_inst
        (.rst(rst),  
	.clk(clk),
	.cnt_in(muxout1),
	.cnt_out(cnt_out));
wire [DWIDTH-1:0] instruction;
wire[DWIDTH-1:0] aluout;
wire[31:0]wb;
wire [2:0] MemRW;
datamemory#(.DWIDTH(DWIDTH),
.AWIDTH(AWIDTH))
datamemory_inst
(.aluout(aluout),
.MemRW(MemRW));
instructionmemory#(.AWIDTH(AWIDTH),
.DWIDTH(DWIDTH))
instructionmemory_inst
(.cnt_out(cnt_out),
.instruction(instruction));
wire [6:0] opcode;
wire [4:0] rs1;
wire [4:0]rs2;
wire [4:0] rd;
wire [3:0] func3;
wire [6:0]func7;
wire[DWIDTH-1:0] porta;
wire[DWIDTH-1:0] portb;
wire RegWen;
wire[DWIDTH-1:0] dataout;
 regfile#(.DWIDTH(DWIDTH),
.AWIDTH(AWIDTH))
regfile_inst
(.rs1(rs1) ,
.rs2(rs2),
.rd(rd),
.clk(clk),
.writedata(wb),
.RegWen(RegWen),
.porta(porta),
.portb(portb));
wire[3:0] ALUSEL;
wire [1:0] BrUn;
wire [1:0] ImmSel;
wire RegWEn;
wire [1:0]WBSel;
wire [3:0] ALUSeL;
wire  BSel;
wire ASel;
wire PCSel;
control
#(.instructionwidth(instructionwidth) ) 
 control_inst(
.instruction(instruction),
.BrEq(BrEq),
.BrLT(BrLT),
.BrUn(BrUn),
.ImmSel(ImmSel),
.RegWEn(RegWEn),
.WBSel(WBSel),
.ALUSeL(ALUSel),
.MemRW(MemRW),
.BSel(BSel),
.ASel(ASel),
.PCSel(PCSel));

alu #(.DWIDTH(DWIDTH))
alu_inst
(.ALUSEL(ALUSEL),
  .porta(porta),
  .portb(portb),
 .aluout(aluout));
pcadder#(.DWIDTH(DWIDTH))
pcadder_inst
(.cnt_out(cnt_out),
.cnt_out1(cnt_out1));
multiplexor#(.DWIDTH(DWIDTH))
multiplexor_inst1
(.a(aluout),
.b(cntout1),
.sel(PCSel),
 .mux(muxout1));
parser parser_int(.instruction(instruction),
.opcode(opcode),
.rs1(rs1),
.rs2(rs2),
.rd(rd),
.func3(func3),
.func7(func7));
multiplexorfour#(.DWIDTH(DWIDTH))
multiplexorfour_inst
(.ina(dataout),
.inb(aluout),
.inc(dataout1),
.select(WBSel),
.wb(wb));




endmodule












