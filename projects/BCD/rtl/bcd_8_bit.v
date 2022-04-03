// File Name bcd_8_bit.v
module bcd_8_bit
(
  input   wire          clk_i,
  input   wire          rst_n_i,
  input   wire          bin_input_i,
  output  wire  [9:0]   dec_output_o
);

wire          select_1_w;
wire          select_2_w;
wire   [3:0]  sum_1_w;
wire   [9:0]  shift_reg_out_w;
wire   [7:0]  shift_reg_in_w;
wire   [3:0]  sum_2_w;

assign dec_output_o = shift_reg_out_w;
compar_to_4 u1_compar_to_4
(
  .data_i (shift_reg_out_w[3:0]),
  .gt_4_o (select_1_w)
);


mux_2to1_4bit u4_mux_2to1_4bit
(
  .select_i  (select_1_w),
  .input_a_i (shift_reg_out_w[3:0]),
  .input_b_i (sum_1_w),
  .output_o  (shift_reg_in_w[3:0])
);

incement_3 u2_incement_3
(
  .data_i  (shift_reg_out_w[3:0]),
  .data_o  (sum_1_w)
);

shift_reg_4_bit u3_shift_reg_4_bit
(
  .clk_i   (clk_i  ),
  .rst_n_i (rst_n_i),
  .data_i  ({shift_reg_in_w[2:0], bin_input_i}),
  .data_o  (shift_reg_out_w[3:0])
);
/////////////////////////////

compar_to_4 u5_compar_to_4
(
  .data_i (shift_reg_out_w[7:4]),
  .gt_4_o (select_2_w)
);


mux_2to1_4bit u8_mux_2to1_4bit
(
  .select_i  (select_2_w),
  .input_a_i (shift_reg_out_w[7:4]),
  .input_b_i (sum_2_w),
  .output_o  (shift_reg_in_w[7:4])
);

incement_3 u6_incement_3
(
  .data_i  (shift_reg_out_w[7:4]),
  .data_o  (sum_2_w)
);

shift_reg_4_bit u7_shift_reg_4_bit
(
  .clk_i   (clk_i  ),
  .rst_n_i (rst_n_i),
  .data_i  (shift_reg_in_w[6:3]),
  .data_o  (shift_reg_out_w[7:4])
);

shift_reg_4_bit u8_shift_reg_4_bit
(
  .clk_i   (clk_i  ),
  .rst_n_i (rst_n_i),
  .data_i  (shift_reg_out_w[8:7]),
  .data_o  (shift_reg_out_w[9:8])
);








endmodule
