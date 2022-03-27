module uart
#(
  parameter integer   DBIT    = 8,
  parameter integer   SB_TICK = 16,
  parameter integer   FIFO_W  = 4
)
(
  /* System Interface */
  input           clk_in,
  input           resetn,
//HAM Debug//  input   [10:0]  dvsr,
  /* Tx Interface */
// HAM Debug //  input           wr_uart,
// HAM Debug //  input   [ 7:0]  w_data,
//  output          tx_full,
  /* Rx Interface */
// HAM Debug //  input           rd_uart,
//HAM Debug//  output  [ 7:0]  r_data,
//HAM Debug//  output          rx_empty,
  /* UART Interface */
  input           rx,
  output          tx
);

wire            tick;
wire            rx_done_tick;
wire  [ 7:0]    tx_fifo_out;
wire  [ 7:0]    rx_data_out;
wire            tx_empty;
wire            tx_fifo_not_empty;
wire            tx_done_tick;
wire            reset;
wire            sys_clk;
wire            wr_rd_uart;


      //HAM Debug//
wire            tx_full;
wire            rx_empty;
wire  [ 7:0]    rx_data;
wire  [ 7:0]    tx_data;

nor (wr_rd_uart,tx_full,rx_empty);
assign tx_data = rx_data & 8'b1101_1111;

baud_gen #(
)
baud_gen_unit
(
  .clk   (sys_clk),
  .reset (reset),
  .dvsr  (11'd650),
  .tick  (tick)
);

uart_rx #(
  .DBIT    (DBIT),
  .SB_TICK (SB_TICK)
) uart_rx_unit (
  .clk           (sys_clk),
  .reset         (reset),
  .rx            (rx),
  .s_tick        (tick),
  .rx_done_tick  (rx_done_tick),
  .dout          (rx_data_out)

);

uart_tx #(
  .DBIT    (DBIT),
  .SB_TICK (SB_TICK)
) uart_tx_unit (
  .clk           (sys_clk),
  .reset         (reset),
  .tx_start      (tx_fifo_not_empty),
  .s_tick        (tick),
  .din           (tx_fifo_out),
  .tx_done_tick  (tx_done_tick),
  .tx            (tx)
);

fifo #(
  .DATA_WIDTH   (DBIT),
  .ADDR_WIDTH   (FIFO_W)
) fifo_rx_unit (
  .clk          (sys_clk),
  .reset        (reset),
// HAM Debug //    .rd           (rd_uart),
  .rd           (wr_rd_uart),
  .wr           (rx_done_tick),
  .w_data       (rx_data_out),
  .empty        (rx_empty),
  .full         (),
// HAM Debug //  .r_data       (r_data)
  .r_data       (rx_data)  // HAM Debug //
);

fifo #(
  .DATA_WIDTH   (DBIT),
  .ADDR_WIDTH   (FIFO_W)
) fifo_tx_unit (
  .clk     (sys_clk),
  .reset   (reset),
  .rd      (tx_done_tick),
  .wr      (wr_rd_uart),// HAM Debug //
// HAM Debug //  .wr      (wr_uart),
  .w_data  (tx_data),// HAM Debug //
// HAM Debug //  .w_data  (w_data),
  .empty   (tx_empty),
  .full    (tx_full),
  .r_data  (tx_fifo_out)
);

clk_wiz_0 Digital_Clock_Manager
   (
// Clock in ports
    .clk_in1(clk_in),   // input clk_in1
// Status and control signals
    .resetn(resetn),    // input resetn
// Clock out ports
    .clk_out1(sys_clk), // output clk_out1
    .locked(locked)     // output locked
);

assign tx_fifo_not_empty = !tx_empty;
assign reset             = !locked;

endmodule