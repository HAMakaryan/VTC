module mux4(
  input i0,
  input i1,
  input i2,
  input i3,
  input s0,
  input s1,
  output q
);

  wire s0n, s1n;
  wire y0, y1, y2, y3;

  not U6(s1n,s1);
  not U7(s0n,s0);
  and U1(y0,i0,s1n,s0n);
  and U2(y1,i1,s1n,s0 );
  and U4(y2,i2,s1 ,s0n);
  and U5(y3,i3,s1 ,s0 );
  or U3(q,y0,y1,y2,y3 );

endmodule
