// File Name mux_2to1_4bit.v
module mux_2to1_4bit
(
  input   wire          select_i,
  input   wire  [3:0]   input_a_i,
  input   wire  [3:0]   input_b_i,
  output  wire  [3:0]   output_o

);

assign output_o = (select_i == 1'b0)? input_a_i : input_b_i;

endmodule
