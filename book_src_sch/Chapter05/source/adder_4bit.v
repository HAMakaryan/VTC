
module adder_4bit
(
  input [3:0]a_in,
  input [3:0]b_in,
  input      c_in,
  output [3:0] sum_out,
  output       c_out
);

wire [2:0]carry;

full_adder fa0
(
  .a      (a_in [0]),
  .b      (b_in [0]),
  .c_in   (c_in),
  .sum    (sum_out [0]),
  .c_out  (carry[0])
);

full_adder fa1
(
  .a      (a_in [1]),
  .b      (b_in [1]),
  .c_in   (carry[0]),
  .sum    (sum_out [1]),
  .c_out  (carry[1])
);

full_adder fa2
(
  .a      (a_in [2]),
  .b      (b_in [2]),
  .c_in   (carry[1]),
  .sum    (sum_out [2]),
  .c_out  (carry[2])
);

full_adder fa3
(
  .a      (a_in [3]),
  .b      (b_in [3]),
  .c_in   (carry[2]),
  .sum    (sum_out [3]),
  .c_out  (c_out)
);

endmodule
