// File Name incement_3.v
module incement_3
(
  input wire  [3:0]   data_i,
  output wire [3:0]   data_o
);

assign data_o = data_i + 4'b0011;

endmodule
