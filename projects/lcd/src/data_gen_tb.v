`timescale 1ns/10ps


module data_gen_tb;



reg   clk;
reg   rst_n;
reg   ready;

wire  [8:0] data;
wire        valid;


always
begin
  clk = 1'b0;
  #5;
  clk = 1'b1;
  #5;
end


initial
begin
  rst_n = 1'b0;
  #24;
  @(posedge clk);
  #1;
  rst_n = 1'b1;
  #6000;
  $stop;
end

initial
begin
  ready = 1'b0;
  repeat (21)
  begin
    @(posedge clk);
  end
  ready = 1'b1;
  repeat (12)
  begin
    @(posedge clk);
  end
  ready = 1'b0;
  repeat (6)
  begin
    @(posedge clk);
  end
  ready = 1'b1;
end

data_gen DUT (
  .clock_i  (clk),
  .rstn_i   (rst_n),
  .data_o   (data),
  .valid_o  (valid),
  .ready_i  (ready)
);



endmodule