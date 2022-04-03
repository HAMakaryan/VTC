module Project_top (
input resetn,
input clk_in1,

input rx
input sw3,

output tx,
output led_4,
);

reg [8:0]r_data;

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
wire empty_wr_tx_start;
wire empty__fifo_tx;

//uart_tx_unit
wire tx_start;

//mux_demux
wire dg_done_wr__sym_gen;
wire dg_data_wr_sym_gen;
wire r_data_wr_;
wire dg_valid_wr_;
wire r_valid_wr_;
wire dg_ready_wr_;
wire r_ready_wr_;
wire data_wr_;
wire valid_wr_;
wire ready_wr_;

assign tx_start = ~empty__fifo_tx;
assign rd_rx = and(r_valid,r_ready);
assign r_valid = ~empty_rx;
assign r_data = {sw3,r_data_7};

baud_gen baud_gen1(
.clk(),
.reset(),
.dvsr(),
.tick()
);


uart_rx rx_1(
.clk(),
.reset(),
.rx(),
.s_tick(),
.rx_done_tick(),
.dout()
);

fifo fifo_rx_unit
#(
  parameter integer   ADDR_WIDTH  = 2,
  parameter integer   DATA_WIDTH  = 8
)
(
.clk(),
.reset(),
.rd(),
.wr(),
.w_data(),
.empty(),
.full(),
.r_data()
);

uart_tx #(
  parameter integer   DBIT        =  8,
  parameter integer   SB_TICK     = 16
)
(
.clk(),
.reset(),
.tx_start(),
.s_tick(),
.din(),
.tx_done_tick(),
.tx()
);

fifo fifo_tx_unit
#(
  parameter integer   ADDR_WIDTH  = 2,
  parameter integer   DATA_WIDTH  = 8
)
(
.clk(),
.reset(),
.rd(),
.wr(),
.w_data(),
.empty(),
.full(),
.r_data()
);

lcd_drv lcd_drv(
  //  System signals
.rst_n_i(),        //  Active low reset
.clk_i(),          //  System clock @ 100 MHz
  // Data interface (Ready/Valid protocol)
.data_i(),         // Input data
.data_valid_i(),   // Data on bus is valid
.device_ready_o(), // Device is ready
  //  LCD interface
.rs_o(),        //  Register select
.en_o(),        //  Strobe signal
.lcd_data_o()   //  Data(or instruction) to LCD
);

symbol_gen sg1(
.restn_i(),
.clk_i(),
  // Data interface
.ready_i(),
.data_o(),
.data_valid_o()
);

mux_demux mux_demux_i (
.dg_done(),

.rx_data(),
.rx_data_valid_i(),

.ready_i(),

.sym_data(),
.sym_data_valid_i(),

.data(),
.data_valid_o(),
.rx_ready_o(),
.sym_ready_o()
);