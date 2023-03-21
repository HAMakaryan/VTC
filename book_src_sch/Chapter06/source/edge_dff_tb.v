// file edge_dff_tb.v

`timescale 10ns/10ps

module edge_dff_tb();

wire  q_w;
wire  qbar_w;
reg   d_reg;
reg   clk_reg;
reg   clear_reg;
integer scenario;
reg   [8*40:1]comment;

always
begin
  clk_reg = 1'b0;
  # 5;
  clk_reg = 1'b1;
  # 5;
end

initial
begin
  d_reg     = 1'b0;
  clear_reg = 1'b0;
  scenario= 0;
  #11;
  // Scenario 10 reset
  scenario= 10;
  comment = "reset";
  clear_reg = 1'b1;
  #11;
  clear_reg = 1'b0;
  // Scenario 20 d = 0
  scenario= 20;
  comment = "d = 0";
  repeat(2) @(posedge clk_reg);
  // Scenario 30 d = 1
  scenario= 30;
  comment = "d = 1";
  #0.5;
  d_reg     = 1'b1;
  repeat(2) @(posedge clk_reg);
  // Scenario 40 d = 0
  scenario= 40;
  comment = "d = 0";
  #0.5;
  d_reg     = 1'b0;
  repeat(2) @(posedge clk_reg);
  // Scenario 50; d=0, clk=1, d=pulse, d=0
  scenario= 50;
  comment = "d=0, clk=1, d=pulse, d=0";
  @(negedge clk_reg);
  #1;
  d_reg     = 1'b0;
  @(posedge clk_reg);
  #1;
  repeat(20) #0.1 d_reg = !d_reg;
  @(posedge clk_reg);
  #1;
  repeat(20) #0.1 d_reg = !d_reg;
  @(posedge clk_reg);
  // Scenario 60; d=1, clk=1, d=pulse, 1=0
  scenario= 60;
  comment = "d=1, clk=1, d=pulse, 1=0";
  @(negedge clk_reg);
  #1;
  d_reg     = 1'b1;
  @(posedge clk_reg);
  #1;
  repeat(20) #0.1 d_reg = !d_reg;
  @(posedge clk_reg);
  #1;
  repeat(20) #0.1 d_reg = !d_reg;
  @(posedge clk_reg);
  // Scenario 70; d=0, clk=0, d=pulse, d=0
  scenario= 70;
  comment = "d=0, clk=0, d=pulse, d=0";
  @(posedge clk_reg);
  #1;
  d_reg     = 1'b0;
  @(negedge clk_reg);
  #1;
  repeat(20) #0.1 d_reg = !d_reg;
  @(negedge clk_reg);
  #1;
  repeat(20) #0.1 d_reg = !d_reg;
  @(posedge clk_reg);
  // Scenario 80; d=1, clk=1, d=pulse, 1=0
  scenario= 80;
  comment = "d=1, clk=1, d=pulse, 1=0";
  @(posedge clk_reg);
  #1;
  d_reg     = 1'b1;
  @(negedge clk_reg);
  #1;
  repeat(20) #0.1 d_reg = !d_reg;
  @(negedge clk_reg);
  #1;
  repeat(20) #0.1 d_reg = !d_reg;
  repeat(20) @(posedge clk_reg);
  $stop;
end

edge_dff DUT (
  .q     (q_w),
  .qbar  (qbar_w),
  .d     (d_reg),
  .clk   (clk_reg),
  .clear (clear_reg)
);

endmodule



