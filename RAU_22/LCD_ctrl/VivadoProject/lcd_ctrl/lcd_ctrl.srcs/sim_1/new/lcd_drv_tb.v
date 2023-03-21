`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/07/2023 09:39:20 AM
// Design Name:
// Module Name: lcd_drv_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module lcd_drv_tb();

reg         clk;
reg         rst_n;
reg   [8:0] data;
reg         data_valid;

always
begin
  clk = 1'b0;
  #5;
  clk = 1'b1;
  #5;
end

initial
begin
  rst_n = 1'b0;
  #48;
  rst_n = 1'b1;
end
 lcd_drv dut (
  //  System signals
  .rst_n_i        (rst_n), //  Active low reset
  .clk_i          (clk), //  System clock @ 100 MHz
  // Data interface (Ready/Valid protocol)
  .data_i         (data), // Input data
  .data_valid_i   (data_valid), // Data on bus is valid
  .device_ready_o (), // Device is ready
  //  LCD interface
  .rs_o           (), //  Register select
  .en_o           (), //  Strobe signal
  .lcd_data_o     ()  //  Data(or instruction) to LCD

);

initial
begin
  data_valid  = 1'b1;
  data        = 9'b0;
end


endmodule
