`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 12/20/2022 11:08:58 AM
// Design Name:
// Module Name: lcd_ctrl
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


module lcd_ctrl(
    input clk_100MHz_i,
    input rstn_i,
    output lcd_reg_select_o,
    output [7:0] lcd_data_o,
    output lcd_enable_o,
    output lcd_rwn_o
    );

wire clk;
wire rstn;
wire [8:0] data;
wire data_valid;
wire ready;

assign lcd_rwn_o = 1'b0;

clk_wiz_0 pll_100MHz (
// Clock out ports
  .clk_out1(clk),         // output clk_out1
// Status and control signals
  .resetn(rstn_i),        // input resetn
  .locked(rstn),          // output locked
// Clock in ports
  .clk_in1(clk_100MHz_i)  // input clk_in1
);

data_gen u2_data_gen(
    .rstn_i        (rstn),
    .clk_i         (clk),
    .data_o        (data),
    .data_valid_o  (data_valid),
    .ready_i       (ready)
    );

lcd_drv u3_lcd_drv(
  .rstn_i       (rstn),
  .clk_i        (clk),
  .data_i       (data),
  .data_valid_i (data_valid),
  .ready_o      (ready),
  .rs_o         (lcd_reg_select_o),
  .lcd_data_o   (lcd_data_o),
  .en_o         (lcd_enable_o)
);


endmodule
