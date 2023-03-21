module full_adder
(
  input  a_i,
  input  b_i,
  input  c_i,
  output s_o,
  output c_o
);

wire c1;
wire c2;
wire s1;

xor u1(s1,  a_i, b_i);
xor u2(s_o, s1,  c_i);
and u3(c1,  a_i, b_i);
and u4(c2,  c_i, s1 );
or  u5(c_o, c2,  c1 );


endmodule