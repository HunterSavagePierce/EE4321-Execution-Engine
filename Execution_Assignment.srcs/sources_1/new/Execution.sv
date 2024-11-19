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
    
    parameter MainMemEn = 0;
    parameter RegisterEn = 1;
    parameter InstrMemEn = 2;
    parameter AluEn = 3;
    parameter ExecuteEn = 4;
    parameter IntAlu = 5;
    
    parameter Stop       = 8'hFF;
    parameter MMult      = 8'h00;
    parameter Madd       = 8'h01;
    parameter Msub       = 8'h02;
    parameter Mtranspose = 8'h03;
    parameter MScale     = 8'h04;
    parameter MScaleImm  = 8'h05;
    parameter IntAdd     = 8'h10;
    parameter IntSub     = 8'h11;
    parameter IntMult    = 8'h12;
    parameter IntDiv     = 8'h13;
    
    input logic Clk, nReset;
    output logic nRead, nWrite;
    input logic [31:0] InstructDataIn;
    input logic [255:0] MemDataIn; // to the CPU 
    input logic [255:0] IntDataIn;
    
    output logic [255:0] ExecDataOut;
    output logic [15:0] address;
    
    logic [7:0] opcode, dest, src1, src2;
    logic [255:0] src1Data, src2Data, result;
    
    logic [15:0] ProgCount;
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
    
    
    typedef enum logic [2:0] {
        RESET, FETCH, DECODE, FETCH_SRC1, FETCH_SRC2, EXECUTE, WRITE_BACK, HALT
    } state_t;

    state_t current_state, next_state;

    

    always_ff @(negedge Clk) begin
        case (current_state)
            RESET: begin
                ProgCount = 0;
                address = 0;
                next_state = FETCH;
            end
            FETCH: begin
                address[15:12] = InstrMemEn;
                address[11:0] = ProgCount;
                nRead = 0;
                next_state = DECODE;
            end
            DECODE: begin
                nRead = 1;
                opcode = InstructDataIn[31:24];
                dest = InstructDataIn[23:16];
                src1 = InstructDataIn[15:8];
                src2 = InstructDataIn[7:0];
                
                if (opcode == IntAdd) begin
                    address[15:12] = MainMemEn;
                    address[11:0] = src1;
                    nRead = 0;
                    next_state = FETCH_SRC1;
                end else begin
                    next_state = HALT;
                end
            end
            FETCH_SRC1: begin
                src1Data = MemDataIn;   // Perform addition
                address[15:12] = MainMemEn;
                address[11:0] = src2;
                
                next_state = FETCH_SRC2;
            end
            FETCH_SRC2: begin
                src2Data = MemDataIn;   // Perform addition
                nRead = 1;
                next_state = EXECUTE;
            end
            EXECUTE: begin
                result = src1Data + src2Data;  // Perform addition
                address[15:12] = MainMemEn;
                address[11:0] = dest;
                nWrite = 0;
                ExecDataOut = result;
                next_state = WRITE_BACK;
            end
            WRITE_BACK: begin
                nWrite = 1;
                 // Write to memory location 2
                ProgCount += 1;
                next_state = FETCH; 
            end
            HALT: begin
                // Stop execution
                next_state = HALT;
            end
        endcase
    end
    
    always_ff @(negedge Clk or negedge nReset) begin
        if (!nReset) begin
            current_state <= RESET;
        end
        else begin
            current_state <= next_state;
        end
    end

endmodule
