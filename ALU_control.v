`timescale 1ns / 1ps

// ALU Control Unit
module alu_control(
 output reg [2:0] ALU_Cnt,   // Control signal to ALU
 input  [1:0] ALUOp,         // From control unit
 input  [3:0] Opcode         // From instruction
);

 wire [5:0] ALUControlIn;

 // Combine ALUOp and Opcode
 assign ALUControlIn = {ALUOp, Opcode};

 // Combinational logic
 always @(*) begin
  casex (ALUControlIn)

   // -------- HIGH LEVEL CONTROL --------
   6'b10xxxx: ALU_Cnt = 3'b000;  // ADD (for memory ops)
   6'b01xxxx: ALU_Cnt = 3'b001;  // SUB (for branch)

   // -------- BASED ON OPCODE --------
   6'b000010: ALU_Cnt = 3'b000;  // ADD
   6'b000011: ALU_Cnt = 3'b001;  // SUB
   6'b000100: ALU_Cnt = 3'b010;  // NOT
   6'b000101: ALU_Cnt = 3'b011;  // SHIFT LEFT
   6'b000110: ALU_Cnt = 3'b100;  // SHIFT RIGHT
   6'b000111: ALU_Cnt = 3'b101;  // AND
   6'b001000: ALU_Cnt = 3'b110;  // OR
   6'b001001: ALU_Cnt = 3'b111;  // SLT

   default:   ALU_Cnt = 3'b000;  // Default ADD

  endcase
 end

endmodule