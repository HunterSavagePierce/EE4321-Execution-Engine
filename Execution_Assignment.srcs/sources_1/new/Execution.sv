///////////////////////////////////////////////////////////////////////////////
// Project: Execution Engine
// Author: Hunter Savage-Pierce
// Date: November 18th, 2024
// Version: 1.0
///////////////////////////////////////////////////////////////////////////////
// Description:
// Execution Engine Implementation File for a Custom Execution Engine
//
// References:
// - Mark W. Welker EE4321 Execution Engine Supplied Code Texas State University
// - ChatGPT 4o
///////////////////////////////////////////////////////////////////////////////

module Execution(Clk,InstructDataIn,MemDataIn,IntDataIn,ExecDataOut, address, nRead,nWrite, nReset);

    input logic nRead, nWrite, nReset, Clk;
    input logic [31:0] InstructDataIn;
    input logic [255:0] MemDataIn; // to the CPU 
    input logic [255:0] IntDataIn;
    
    output logic [255:0] ExecDataOut;
    output logic [15:0] address;
    
    logic [7:0] opcode, dest, src1, src2;
    logic [255:0] src1Data, src2Data, result;
    
    // instruction: OPcode :: dest :: src1 :: src2 Each section is 8 bits.
    //Stop::FFh::00::00::00
    //MMult::00h::Reg/mem::Reg/mem::Reg/mem
    //Madd::01h::Reg/mem::Reg/mem::Reg/mem
    //Msub::02h::Reg/mem::Reg/mem::Reg/mem
    //Mtranspose::03h::Reg/mem::Reg/mem::Reg/mem
    //MScale::04h::Reg/mem::Reg/mem::Reg/mem
    //MScaleImm::05h:Reg/mem::Reg/mem::Immediate
    //IntAdd::10h::Reg/mem::Reg/mem::Reg/mem
    //IntSub::11h::Reg/mem::Reg/mem::Reg/mem
    //IntMult::12h::Reg/mem::Reg/mem::Reg/mem
    //IntDiv::13h::Reg/mem::Reg/mem::Reg/mem
    
    // State machine states
    typedef enum logic [2:0] {
        RESET,          // Reset state
        FETCH,          // Fetch instruction
        DECODE,         // Decode instruction
        EXECUTE,        // Execute instruction
        HALT            // Stop execution
    } state_t;
    
    state_t current_state, next_state;
    



endmodule
