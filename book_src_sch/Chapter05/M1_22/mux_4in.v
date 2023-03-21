module mux_4in (
  input   [3:0] data_i,
  input   [1:0] select_i,
  output        q_o
);

wire [3:0] y;
wire [1:0] s_inv;

not U6 (s_inv [1],select_i [1]);
not U7 (s_inv [0],select_i [0]);
and U1 (y [0], data_i [0],   s_inv[1],   s_inv[0]);
and U2 (y [1], data_i [1],   s_inv[1],select_i[0]);
and U4 (y [2], data_i [2],select_i[1],   s_inv[0]);
and U5 (y [3], data_i [3],select_i[1],select_i[0]);
or  U3 (q_o, y[3], y[2], y[1], y[0]);

endmodule








