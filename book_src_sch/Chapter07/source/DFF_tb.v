`timescale 1 ns / 10 ps


module DFF_tb ();

reg   clk;
reg   rst_n;
reg   d_reg;
wire  q_wire;

DFF DUT(
  .clock(clk),
  .rstn (rst_n),
  .d    (d_reg),
  .Q    (q_wire)
);


initial
  begin
    clk   = 1'b0;
    rst_n = 1'b1;
    d_reg = 1'b1;
    @(posedge clk);
    @(posedge clk);
    # 3;
    rst_n = 1'b0;
    # 20;
    rst_n = 1'b1;
  end

always
  begin
    #5
    clk = !clk;
  end



endmodule