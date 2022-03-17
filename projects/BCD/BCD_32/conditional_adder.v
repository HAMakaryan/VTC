
module conditional_adder (
  input   [3:0] data_i,
  output  [3:0] sum_o
);

assign sum_o = (data_i > 4'b0100)? data_i + 4'b0011 : data_i;

endmodule
