module full_adder(
  input a_i,
  input b_i,
  input c_i,
  output sum_o,
  output c_o
);

  wire s1,c2,c1;

  xor X1(s1,a_i,b_i);
  and A1(c1,a_i,b_i);
  xor X2(sum_o,s1,c_i);
  and A2(c2,c_i,s1);
  or O1(c_o,c2,c1);

endmodule
