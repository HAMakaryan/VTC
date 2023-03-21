// file full_adder.v

module full_adder
(
  input a,
  input b,
  input c_in,
  output sum,
  output c_out
);

wire s1,c1,c2;

xor u1(s1,a,b);
and u2(c1,a,b);
xor u3(sum,s1,c_in);
and u4(c2,s1,c_in);
or u5(c_out ,c1,c2);

endmodule
