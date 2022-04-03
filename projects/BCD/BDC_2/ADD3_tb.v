`timescale 1ns/10ps

module add3_tb;
reg clk;
reg  [7:0]  in_vector;
wire [3:0]  add3_out;
wire [3:0]  ONES;
wire [3:0]  TENS;
wire [1:0]  HUNDREDS;

initial begin
  clk         = 1'b0;
  in_vector   = 8'b0000_0000;
end



always begin
  #10;
  clk = ~clk;
end


always @(posedge clk)
begin
  in_vector <= in_vector + 8'b0000_0001;
end


add3 dut
  (
    .in   (in_vector),
    .out  (add3_out)

  );


binary_to_BCD dut_2
(
    .A        (in_vector),
    .ONES     (ONES),
    .TENS     (TENS),
    .HUNDREDS (HUNDREDS)
);


AA
0

endmodule

