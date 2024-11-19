///////////////////////////////////////////////////////////////////////////////
// Project: Execution Engine
// Author: Hunter Savage-Pierce
// Date: November 18th, 2024
// Version: 1.0
///////////////////////////////////////////////////////////////////////////////
// Description:
// Top File for a Custom Execution Engine
//
// References:
// - Mark W. Welker EE4321 Execution Engine Supplied Code Texas State University
// - ChatGPT 4o
///////////////////////////////////////////////////////////////////////////////

module top ();

logic [255:0] InstructDataOut;
logic [255:0] MemDataOut;
logic [255:0] ExeDataOut;
logic [255:0] IntDataOut;
logic nRead,nWrite,nReset,Clk;
logic [15:0] address;

logic Fail;

InstructionMemory  U1(Clk,InstructDataOut, address, nRead,nReset);

MainMemory  U2(Clk,MemDataOut,ExeDataOut, address, nRead,nWrite, nReset);

Execution  U3(Clk,InstructDataOut,MemDataOut,IntDataOut,ExeDataOut, address, nRead,nWrite, nReset);

IntegerAlu  U5(Clk,IntDataOut,ExeDataOut, address, nRead,nWrite, nReset);

TestMatrix  UTest(Clk,nReset);

  initial begin //. setup to allow waveforms for edaplayground
   $dumpfile("dump.vcd");
   $dumpvars(1);
    Fail = 0; // SETUP TO PASS TO START 
 end

always @(InstructDataOut) begin // this block checks to make certain the proper data is in the memory.
		if (InstructDataOut[31:0] == 32'hff000000)
// we are about to execute the stop
begin 
// Print out the entire contents of main memory so I can copy and paste.
//			$display ( "memory location 0 = %h", U2.MainMemory[0]);
//			$display ( "memory location 1 = %h", U2.MainMemory[1]);
//			$display ( "memory location 2 = %h", U2.MainMemory[2]);
//			$display ( "memory location 3 = %h", U2.MainMemory[3]);
//			$display ( "memory location 4 = %h", U2.MainMemory[4]);
//			$display ( "memory location 5 = %h", U2.MainMemory[5]);
//			$display ( "memory location 6 = %h", U2.MainMemory[6]);
//			$display ( "memory location 7 = %h", U2.MainMemory[7]);
//			$display ( "memory location 8 = %h", U2.MainMemory[8]);
//			$display ( "memory location 9 = %h", U2.MainMemory[9]);
//			$display ( "memory location 10 = %h", U2.MainMemory[10]);
//			$display ( "memory location 11 = %h", U2.MainMemory[11]);

//			$display ( "Imternal Reg location 0 = %h", U3.InternalReg[0]);
//			$display ( "Internal reg location 1 = %h", U3.InternalReg[1]);

		if (U2.MainMemory[0] == 256'h0004000c0004002200070006000b0009000900020008000d0002000f00100003)
			$display ( "memory location 0 is Correct");
		else Fail = 1;
		if (U2.MainMemory[1] == 256'h0017002d00430016000700060004000100120038000d000c0003000500070009)
			$display ( "memory location 1 is Correct");
		else Fail = 1;
		if (U2.MainMemory[2][15:0] == 16'h000c)
			$display ( "memory location 2 is Correct");
		else Fail = 1;

        if (Fail) begin
        $display("********************************************");
        $display(" Project did not return the proper values");
        $display("********************************************");
        end
        else begin
        $display("********************************************");
        $display(" Project PASSED memory check");
        $display("********************************************");
        end
        
        end

end


endmodule


	
	

