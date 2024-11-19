// Mark W. Welker
// Matrix_add assignment
// Spring 2021
//
//

parameter    matrixMemory0 = 256'h0004_000c_0004_0022_0007_0006_000b_0009_0009_0002_0008_000d_0002_000f_0010_0003;
parameter    matrixMemory1 = 256'h0017_002d_0043_0016_0007_0006_0004_0001_0012_0038_000d_000c_0003_0005_0007_0009;

module MainMemory(Clk,Dataout,DataIn, address, nRead,nWrite, nReset);


input logic [255:0] DataIn; // from the CPU
input logic nRead,nWrite, nReset, Clk;
input logic [15:0] address;

output logic [255:0] Dataout; // to the CPU 

  logic [255:0]MainMemory[12]; // this is the physical memory

always_ff @(negedge Clk or negedge nReset)
begin
	if (~nReset) begin
	
	MainMemory[0] = matrixMemory0;
	MainMemory[1] = matrixMemory1;
	MainMemory[2] = 256'h0;
	MainMemory[3] = 256'h0;
	MainMemory[4] = 256'h0;
	MainMemory[5] = 256'h0;
	MainMemory[6] = 256'h0;
	MainMemory[7] = 256'h0;
	MainMemory[8] = 256'h4;
	MainMemory[9] = 256'hb;
	MainMemory[10] = 256'h0;
	MainMemory[11] = 256'h0;
	
	
      Dataout=0;
	end

  else if(address[15:12] == MainMemEn) // talking to Instruction
		begin
			if (~nRead)begin
				Dataout <= MainMemory[address[11:0]]; // data will remain on dataout until it is changed.
			end
			if(~nWrite)begin
		    MainMemory[address[11:0]] <= DataIn;
			end
		end
end // from negedge nRead	

endmodule


