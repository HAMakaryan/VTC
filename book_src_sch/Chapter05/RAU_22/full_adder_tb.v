`timescale 1ns/10ps

module full_adder_tb;

reg [2:0]in_reg;
wire sum;
wire c_out;


full_adder dut (
  .a_i    (in_reg[0]),
  .b_i    (in_reg[1]),
  .c_i    (in_reg[2]),
  .sum_o  (sum),
  .c_o    (c_out)
);

initial
begin
  in_reg = 3'b000;
end

always
begin
  #10;
  in_reg = in_reg + 3'b001;
end

endmodule
