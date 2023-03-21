module full_adder_4bit (
 input [3:0] a_i,
 input [3:0] b_i,
 //input c_i,
 output [3:0] sum_o,
 output c_o
);

wire c_0,c_1,c_2;

full_adder fa0(
  .a_i     (a_i [0]),
  .b_i     (b_i [0]),
  .c_i     (1'b0),
  .sum_o   (sum_o [0]),
  .c_o     (c_0)
);

full_adder fa1(
  .a_i     (a_i [1]),
  .b_i     (b_i [1]),
  .c_i     (c_0),
  .sum_o   (sum_o [1]),
  .c_o     (c_1)
);

full_adder fa2(
  .a_i     (a_i [2]),
  .b_i     (b_i [2]),
  .c_i     (c_1),
  .sum_o   (sum_o [2]),
  .c_o     (c_2)
);

full_adder fa3(
  .a_i     (a_i [3]),
  .b_i     (b_i [3]),
  .c_i     (c_2),
  .sum_o   (sum_o [3]),
  .c_o     (c_o)
);

endmodule
