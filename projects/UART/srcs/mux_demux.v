module mux_demux(
input dg_done,

input [7:0]rx_data,
input rx_data_valid_i,

input ready_i,

input [7:0]sym_data,
input sym_data_valid_i,

output [7:0]data,
output data_valid_o,
output rx_ready_o,
output sym_ready_o
);

assign  data[8:0]    = (dg_done == 1'b1)? rx_data[8:0]    : sym_data[8:0];
assign  data_valid_o = (dg_done == 1'b1)? rx_data_valid_i : sym_data_valid_i;
assign  sym_ready_o  = (dg_done == 1'b0)? ready_i         : 1'b0;
assign  rx_ready_o   = (dg_done == 1'b1)? ready_i         : 1'b0;

endmodule