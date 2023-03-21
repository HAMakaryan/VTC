`timescale 1ns/10ps
module Structured_Procedures_07_01;

reg a,b,c,d,e;
reg clk;

initial
  a = 1'b1;

initial
begin
  b = 1'b0;
  clk = 1'b0;
  #10;
  c = 1'b1;
end

initial
begin
  # 20;
  d = a;
  # 40;
  d = b;
  # 40;
  d = c;
end

always @(negedge clk)
begin
  e = d;
end


always
begin
  #18;
  clk = !clk;
end


endmodule