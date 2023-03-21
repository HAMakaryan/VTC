`timescale 1ns/10ps

module full_adder_4bit_tb;

reg  [7:0]in_reg;
wire [3:0]sum;
wire c_out;

full_adder_4bit DUT (
  .a_i    (in_reg[3:0]),
  .b_i    (in_reg[7:4]),
  .sum_o  (sum),
  .c_o    (c_out)
);

initial
begin
  in_reg = 8'h00;
end

always
begin
  #50;
  in_reg = in_reg + 8'h01;
end

endmodule
