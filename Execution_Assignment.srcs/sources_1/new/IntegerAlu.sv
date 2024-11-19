///////////////////////////////////////////////////////////////////////////////
// Project: Execution Engine
// Author: Hunter Savage-Pierce
// Date: November 18th, 2024
// Version: 1.0
///////////////////////////////////////////////////////////////////////////////
// Description:
// Integer ALU Implementation File for a Custom Execution Engine
//
// References:
// - Mark W. Welker EE4321 Execution Engine Supplied Code Texas State University
// - ChatGPT 4o
///////////////////////////////////////////////////////////////////////////////

module IntegerAlu(Clk,IntDataOut,ExecDataIn, address, nRead,nWrite, nReset);

input logic nRead, nWrite, nReset, Clk;
input logic [15:0] address;
input logic [255:0] ExecDataIn;

output logic [255:0] IntDataOut;




endmodule
