`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Top Level RISC Processor
//
// Supports:
//
// cache_type = 0 -> Direct Cache
// cache_type = 1 -> Fully Associative Cache
// cache_type = 2 -> 2-Way Set Associative Cache
//
//////////////////////////////////////////////////////////////////////////////////

module Risc_16_bit
(

    input clk,
    input rst,
input [1:0] pattern_select,
    //------------------------------------------------------
    // Cache Selection
    //------------------------------------------------------

    input [1:0] cache_type,

    //------------------------------------------------------
    // Cache Statistics Outputs
    //------------------------------------------------------

    output [31:0] hit_count,
    output [31:0] miss_count,
    output [31:0] total_access,
    output [31:0] stall_cycles

);

////////////////////////////////////////////////////////////
// Control Signals
////////////////////////////////////////////////////////////

wire jump;
wire bne;
wire beq;

wire mem_read;
wire mem_write;

wire alu_src;

wire reg_dst;
wire mem_to_reg;
wire reg_write;

wire [1:0] alu_op;

wire [3:0] opcode;

////////////////////////////////////////////////////////////
// Datapath
////////////////////////////////////////////////////////////

Datapath_Unit DU
(
    .clk(clk),
    .rst(rst),

    .pattern_select(pattern_select),
    .cache_type(cache_type),

    .jump(jump),
    .beq(beq),

    .mem_read(mem_read),
    .mem_write(mem_write),

    .alu_src(alu_src),

    .reg_dst(reg_dst),
    .mem_to_reg(mem_to_reg),

    .reg_write(reg_write),

    .bne(bne),

    .alu_op(alu_op),

    .opcode(opcode),

    //--------------------------------------------------
    // Statistics
    //--------------------------------------------------

    .hit_count_out(hit_count),

    .miss_count_out(miss_count),

    .total_access_out(total_access),

    .stall_cycles_out(stall_cycles)
);

////////////////////////////////////////////////////////////
// Control Unit
////////////////////////////////////////////////////////////

Control_Unit control
(
    .opcode(opcode),

    .reg_dst(reg_dst),

    .mem_to_reg(mem_to_reg),

    .alu_op(alu_op),

    .jump(jump),

    .bne(bne),

    .beq(beq),

    .mem_read(mem_read),

    .mem_write(mem_write),

    .alu_src(alu_src),

    .reg_write(reg_write)
);

endmodule