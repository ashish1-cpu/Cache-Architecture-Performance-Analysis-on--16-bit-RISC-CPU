`timescale 1ns / 1ps

// General Purpose Register File (8 registers, 16-bit each)
module GPRs(
 input clk,

 // -------- WRITE PORT --------
 input reg_write_en,             // Enable writing
 input [2:0] reg_write_dest,     // Destination register (0–7)
 input [15:0] reg_write_data,    // Data to write

 // -------- READ PORT 1 --------
 input [2:0] reg_read_addr_1,    
 output [15:0] reg_read_data_1,

 // -------- READ PORT 2 --------
 input [2:0] reg_read_addr_2,    
 output [15:0] reg_read_data_2
);

 // 8 registers (R0–R7), each 16-bit
 reg [15:0] reg_array [7:0];

 integer i;

 // -------- INITIALIZATION --------
 initial begin
  for(i = 0; i < 8; i = i + 1)
    reg_array[i] = 16'd0;   // blocking assignment better here
 end

 // -------- WRITE OPERATION --------
 // Happens on rising clock edge
/* always @(posedge clk) begin
   if (reg_write_en)
     reg_array[reg_write_dest] <= reg_write_data;
 //R0 = constant zero
 if(reg_write_en && reg_write_dest != 3'b000)
    reg_array[reg_write_dest] <= reg_write_data;
    end */
    always @(posedge clk) begin

   // R0 is hardwired to zero

   if(reg_write_en && reg_write_dest != 3'b000)
      reg_array[reg_write_dest] <= reg_write_data;

   reg_array[0] <= 16'd0;

end

 // -------- READ OPERATION --------
 // Asynchronous read (instant)
 assign reg_read_data_1 = reg_array[reg_read_addr_1];
 assign reg_read_data_2 = reg_array[reg_read_addr_2];

endmodule