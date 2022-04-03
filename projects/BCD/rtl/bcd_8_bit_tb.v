`timescale 1ns/10ps

module bcd_8_bit_tb;
reg clk;
reg rst_n;
reg bin_input;
wire [9:0] dec_output;

initial begin
  clk = 1'b0;
  rst_n = 1'b0;
  bin_input = 1'b1;
  #41 ;
  rst_n = 1'b1;
end

always begin
  #5;
  clk = ~clk;
end

initial begin
  @(posedge rst_n);
  @(posedge clk);
  bin_input = 1'b1;
  @(posedge clk);
  bin_input = 1'b1;
  @(posedge clk);
  bin_input = 1'b0;
  @(posedge clk);
  bin_input = 1'b1;
  @(posedge clk);
  bin_input = 1'b0;
  @(posedge clk);
  bin_input = 1'b1;
  @(posedge clk);
  bin_input = 1'b1;
  @(posedge clk);
  bin_input = 1'b0;
end

bcd_8_bit DUT
(
  .clk_i(clk),
  .rst_n_i(rst_n),
  .bin_input_i(bin_input),
  .dec_output_o(dec_output)
);



endmodule