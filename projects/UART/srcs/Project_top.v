module Project_top (
input resetn,
input clk_in1,

input rx
input sw3,

output tx,
output led_4,

//lcd_drv_outputs
output rs_lcd_drv;
output data_lcd_drv;
output enable_lcd_drv;
);

reg [8:0]r_data;

wire reg for_dvsr = 11d'650; 

wire r_valid;
wire r_ready;


// baud gen
wire tick_wr_s_tick;

//fifo_rx
wire wr_wr_rx_done_tick;
wire w_data_wr_dout;
wire r_data_7; 
wire empty_rx;
wire rd_rx;

//fifo_tx
wire rd_wr_tx_done_tick;
wire r_data_wr_din;
wire empty__fifo_tx;

//uart_tx_unit
wire wr_tx_start;

//mux_demux
wire dg_done_wr__sym_gen;
wire dg_data_wr_sym_gen;
wire r_data_wr_fifo_rx_r_data;
wire dg_valid_wr_sym_gen_data_valid_o;
wire r_valid_wr_fifo_rx_r_valid;
wire dg_ready_wr_sym_gen_ready_i;
wire r_ready_wr_fifo_ready_i;
wire data_wr_lcd_drv_top_lcd_input_data_i;
wire valid_wr_lcd_input_data_valid_i;
wire ready_wr_lcd_input_data_ready_o;

assign wr_tx_start = ~empty__fifo_tx;
assign rd_rx = and(r_valid,r_ready);
assign r_valid = ~empty_rx;
assign r_data = {sw3,r_data_7};

baud_gen baud_gen1(
.clk(),
.reset(),
.dvsr(for_dvsr),
.tick(tick_wr_s_tick)
);


uart_rx rx_1(
.clk(),
.reset(),
.rx(rx),
.s_tick(tick_wr_s_tick),
.rx_done_tick(wr_wr_rx_done_tick),
.dout(w_data_wr_dout)
);

fifo fifo_rx_unit
#(
  parameter integer   ADDR_WIDTH  = 2,
  parameter integer   DATA_WIDTH  = 8
)
(
.clk(),
.reset(),
.rd(rd_rx),
.wr(wr_wr_rx_done_tick),
.w_data(w_data_wr_dout),
.empty(empty_rx),
.full(),
.r_data(r_data_wr_fifo_rx_r_data)
);

uart_tx #(
  parameter integer   DBIT        =  8,
  parameter integer   SB_TICK     = 16
)
(
.clk(),
.reset(),
.tx_start(wr_tx_start),
.s_tick(tick_wr_s_tick),
.din(r_data_wr_din),
.tx_done_tick(rd_wr_tx_done_tick),
.tx(tx)
);

fifo fifo_tx_unit
#(
  parameter integer   ADDR_WIDTH  = 2,
  parameter integer   DATA_WIDTH  = 8
)
(
.clk(),
.reset(),
.rd(rd_wr_tx_done_tick),
.wr(rd_rx),
.w_data(r_data_7),
.empty(wr_tx_start),
.r_data(r_data_wr_din),
.full()
);

lcd_drv lcd_drv(
  //  System signals
.rst_n_i(),        //  Active low reset
.clk_i(),          //  System clock @ 100 MHz
  // Data interface (Ready/Valid protocol)
.data_i(r_data),         // Input data
.data_valid_i(valid_wr_lcd_input_data_valid_i),   // Data on bus is valid
.device_ready_o(ready_wr_lcd_input_data_ready_o), // Device is ready
  //  LCD interface
.rs_o(rs_lcd_drv),        //  Register select
.en_o(enable_lcd_drv),        //  Strobe signal
.lcd_data_o(data_lcd_drv)   //  Data(or instruction) to LCD
);

symbol_gen sg1(
.restn_i(),
.clk_i(),
  // Data interface
.ready_i(dg_ready_wr_sym_gen_ready_i),
.data_o(dg_data_wr_sym_gen),
.data_valid_o(dg_valid_wr_sym_gen_data_valid_o)
.init_done(dg_done_wr__sym_gen)
);

mux_demux mux_demux_i (
.dg_done(dg_done_wr__sym_gen),

.rx_data(r_data_wr_fifo_rx_r_data),
.rx_data_valid_i(r_valid),

.ready_i(ready_wr_lcd_input_data_ready_o),

.sym_data(dg_data_wr_sym_gen),
.sym_data_valid_i(dg_valid_wr_sym_gen_data_valid_o),

.data(r_data),
.data_valid_o(valid_wr_lcd_input_data_valid_i),

.rx_ready_o(r_ready),
.sym_ready_o(dg_ready_wr_sym_gen_ready_i)
);

/* clk_wiz_0 Digital_Clock_Manager
   (
// Clock in ports
    .clk_in1(clk_in),   // input clk_in1
// Status and control signals
    .resetn(resetn),    // input resetn
// Clock out ports
    .clk_out1(sys_clk), // output clk_out1
    .locked(locked)     // output locked
); */

endmodule