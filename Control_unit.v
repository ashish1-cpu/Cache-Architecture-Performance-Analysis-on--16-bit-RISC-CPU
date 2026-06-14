`timescale 1ns/1ps

// Control Unit
module Control_Unit(
 input  [3:0] opcode,

 output reg [1:0] alu_op,
 output reg jump, beq, bne,
 output reg mem_read, mem_write,
 output reg alu_src, reg_dst,
 output reg mem_to_reg, reg_write    
);

always @(*) begin

 // -------- DEFAULT VALUES (VERY IMPORTANT ) --------
 reg_dst     = 0;
 alu_src     = 0;
 mem_to_reg  = 0;
 reg_write   = 0;
 mem_read    = 0;
 mem_write   = 0;
 beq         = 0;
 bne         = 0;
 alu_op      = 2'b00;
 jump        = 0;

 case(opcode)

 // -------- LOAD --------
 4'b0000: begin  // LW
  reg_dst    = 0;
  alu_src    = 1;
  mem_to_reg = 1;
  reg_write  = 1;
  mem_read   = 1;
  alu_op     = 2'b10;
 end

 // -------- STORE --------
 4'b0001: begin  // SW
  alu_src    = 1;
  mem_write  = 1;
  alu_op     = 2'b10;
 end

 // -------- R-TYPE (ALL DATA PROCESSING) --------
 4'b0010,
 4'b0011,
 4'b0100,
 4'b0101,
 4'b0110,
 4'b0111,
 4'b1000,
 4'b1001: begin

  reg_dst    = 1;
  reg_write  = 1;
  alu_op     = 2'b00;

 end

 // -------- BEQ --------
 4'b1011: begin
  beq    = 1;
  alu_op = 2'b01;
 end

 // -------- BNE --------
 4'b1100: begin
  bne    = 1;
  alu_op = 2'b01;
 end

 // -------- JUMP --------
 4'b1101: begin
  jump = 1;
 end

 endcase
end

endmodule