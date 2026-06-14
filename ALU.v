`timescale 1ns/ 1ps

// Arithmetic Logic Unit (ALU)
module ALU(
 input  [15:0] a,           // operand 1
 input  [15:0] b,           // operand 2
 input  [2:0] alu_control,  // operation select
 
 output reg [15:0] result,  // ALU result
 output zero                // zero flag
);

always @(*) begin 
 case(alu_control)

 3'b000: result = a + b;        // ADD
 3'b001: result = a - b;        // SUB
 3'b010: result = ~a;           // NOT (only on a)

 // ⚠️ IMPORTANT FIX (shift amount limited)
 3'b011: result = a << b[3:0];  // SHIFT LEFT
 3'b100: result = a >> b[3:0];  // SHIFT RIGHT

 3'b101: result = a & b;        // AND
 3'b110: result = a | b;        // OR

 3'b111: result = (a < b) ? 16'd1 : 16'd0;  // SLT

 default: result = 16'd0;

 endcase
end

// Zero flag → used in BEQ/BNE
assign zero = (result == 16'd0);

endmodule