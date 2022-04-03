// File Name compar_to_4.v
module compar_to_4
(
  input wire  [3:0]   data_i,
  output wire         gt_4_o
);

assign gt_4_o = (data_i > 4'b0100)? 1'b1 : 1'b0;

endmodule
