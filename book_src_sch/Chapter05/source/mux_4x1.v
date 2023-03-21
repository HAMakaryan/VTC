//file D:\GitHub\VTC\book_src_sch\Chapter05\source\mux_4x1.v
//cd D:/GitHub/VTC/book_src_sch/Chapter05/source
module mux_4x1 (
  output wire       out,
  input  wire [3:0] i,
  input  wire [1:0] s
);
  wire [3:0] y;
  wire [1:0] sn;

and u1(y[0], i[0], sn[1], sn[0] );
and u2(y[1], i[1], sn[1], s [0] );
and u4(y[2], i[2], s [1], sn[0] );
and u5(y[3], i[3], s [1], s [0] );

or u3(out , y[0] , y[1] ,y[2] , y[3]) ;
not u6 (sn[1] , s[1]);
not u7 (sn[0] , s[0]);


endmodule
