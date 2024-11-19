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

    logic [255:0] ALU_s0;       // Source 0 for ALU operation
    logic [255:0] ALU_s1;       // Source 1 for ALU operation
    logic [255:0] ALU_result;   // Result of ALU operation
    
    typedef enum logic [1:0] {
        ADDITION,           // Perform Addition Operand
        SUBTRACTION,        // Perform Subtraction Operand
        MULTIPLICATION,     // Perform Multiplication Operand
        DIVISION            // Perform Division Operand
    } state_t;
    
    state_t ALU_select;

    always_ff @(negedge Clk or negedge nReset) begin
        if (~nReset) begin
            IntDataOut <= 256'h0;
            ALU_s0 <= 256'h0;
            ALU_s1 <= 256'h0;
            ALU_result <= 256'h0;
        end else begin

            if (address[15:12] == IntAlu) begin
                if (address[11:0] == AluStatusIn) begin
                
                end 
                else if (address[11:0] == AluStatusOut) begin
                
                end
                else if (address[11:0] == ALU_Source1) begin
                
                end
                else if (address[11:0] == ALU_Source2) begin
                
                end
                else if (address[11:0] == ALU_Result) begin
                
                end
                else if (address[11:0] == Overflow_err) begin
                
                end
                if (~nWrite) begin
                    case (ALU_select)
                        ADDITION: ALU_result <= ALU_s0 + ALU_s1;
                        SUBTRACTION: ALU_result <= ALU_s0 - ALU_s1;
                        MULTIPLICATION: ALU_result <= ALU_s0 * ALU_s1;
                        DIVISION: ALU_result <= (ALU_s1 != 0) ? ALU_s0 / ALU_s1 : 256'h0;

                        default: begin
                            // Default case for safety, no operation
                            ALU_result <= ALU_result;
                        end 
                    endcase
                end
            end
        end
    end
endmodule
