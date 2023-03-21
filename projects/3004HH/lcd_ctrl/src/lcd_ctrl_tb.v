`timescale 1ns/10ps

module lcd_ctrl_tb;


reg clk;
reg reset_n;
reg [8:0] data;
reg data_valid;

wire ready;
wire lcd_reg_sel;
wire [7:0]lcd_data;
wire lcd_enable;

initial
begin
  reset_n = 1'b0;
  #47;
  reset_n = 1'b1;
end

always
begin
  clk = 0'b0;
  #5;
  clk = 1'b1;
  #5;
end

initial
begin
  wait(reset_n);
  @(posedge clk);
  data       = 9'h030;
  data_valid = 1'b1;
  wait(ready == 1'b1);
  @(posedge clk);
  data       = 9'h101;
  @(posedge ready);
  @(posedge clk);
  data       = 9'h002;
  @(posedge ready);
  @(posedge clk);
  data       = 9'h007;
  @(posedge ready);
  @(posedge clk);
  data       = 9'h005;
  @(posedge ready);
  @(posedge clk);
  data       = 9'h005;
  @(posedge ready);
  @(posedge clk);
  data       = 9'h006;
  @(posedge ready);
  @(posedge clk);
  data       = 9'h103;
  @(posedge ready);
  @(posedge clk);
  data       = 9'h102;
  @(posedge ready);
  @(posedge clk);
  data       = 9'h101;
  @(posedge ready);
  data_valid = 1'b0;
  #200;
  $stop;
end

lcd_ctrl DUT(
/* system interface */
.rst_n(reset_n),
.clk(clk),
/* data interface   */
.data(data),
.data_valid(data_valid),
.ready(ready),
/* lcd interface    */
.lcd_rs(lcd_reg_sel),
.lcd_data(lcd_data),
.lcd_enable(lcd_enable)
);

endmodule

