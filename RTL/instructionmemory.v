module instructionmemory
#(
  parameter integer AWIDTH=8,
  parameter integer DWIDTH=32
 )
 (
  
 input  wire [AWIDTH-1:0] cnt_out ,
  output  wire [DWIDTH-1:0] instruction
 );
  reg [DWIDTH-1:0] imemory [0:31];
  initial 
	begin
		imemory[0]=32'h00007033;
                imemory[1]= 32'h00208433;	
                imemory[2]=32'h404404b3;
                imemory[3]=32'h404404b3;
                imemory[4]=32'h00317533;
                imemory[5]=32'h0041e5b3;
                	
	end

  assign instruction= imemory[1]; 
  
endmodule
