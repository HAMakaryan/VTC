module full_adder_1bit (
  input     a_i,
  input     b_i,
  input     cin_i,
  output    sum_o,
  output    cout_o
);

wire   s1;
wire   c1, c2;

xor u1 (s1,a_i,b_i);
xor u2 (sum_o,s1,cin_i);
and u3 (c1,a_i,b_i);
and u4 (c2,s1,cin_i);
or  u5 (cout_o,c1,c2);

endmodule
