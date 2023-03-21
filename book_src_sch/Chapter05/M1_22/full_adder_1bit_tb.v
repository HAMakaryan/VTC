`timescale 1ns/10ps

module full_adder_1bit_tb ();

reg  [2:0] input_reg;
wire       sum_output;
wire       carry_output;

wire       sum_output_2;
wire       carry_output_2;

initial
begin
  input_reg = 3'b000;
end

always
begin
  #10;
  input_reg = input_reg + 3'b001;
end

full_adder_1bit dut (
  input_reg[0],
  input_reg[1],
  input_reg[2],
  sum_output,
  carry_output
);

full_adder_1bit dut_2 (
  .b_i      (input_reg[1]),
  .cin_i    (input_reg[2]),
  .a_i      (input_reg[0]),
  .sum_o    (sum_output_2),
  .cout_o   (carry_output_2)
);

endmodule
