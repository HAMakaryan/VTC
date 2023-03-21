module four_bit_adder(
  input     [3:0] A_i,
  input     [3:0] B_i,
  //input           C_i,
  output    [3:0] S_o,
  output          C_o
  );

wire    [2:0]C;

full_adder fa0(
  .a_i    (A_i[0]),
  .b_i    (B_i[0]),
  .c_i    (1'b0),
  .s_o    (S_o[0]),
  .c_o    (C[0])
 );

full_adder fa1(
  .a_i    (A_i[1]),
  .b_i    (B_i[1]),
  .c_i    (C[0]),
  .s_o    (S_o[1]),
  .c_o    (C[1])
 );

full_adder fa2(
  .a_i    (A_i[2]),
  .b_i    (B_i[2]),
  .c_i    (C[1]),
  .s_o    (S_o[2]),
  .c_o    (C[2])
 );

full_adder fa3(
  .a_i    (A_i[3]),
  .b_i    (B_i[3]),
  .c_i    (C[2]),
  .s_o    (S_o[3]),
  .c_o    (C_o)
 );

endmodule
