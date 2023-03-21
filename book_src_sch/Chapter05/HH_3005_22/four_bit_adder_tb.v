`timescale 1ns/10ps

module four_bit_adder_tb;

reg  [8:0]  in_vec;
wire [3:0]  sum;
wire        carry;

four_bit_adder DUT(
  .A_i  (in_vec [3:0]),
  .B_i  (in_vec [7:4]),
//  .C_i  (in_vec [8]),
  .S_o  (sum),
  .C_o  (carry)
);

initial
begin
  in_vec = 9'b0_0000_0000;
end

always
begin
  #100;
  in_vec = in_vec + 9'b0_0000_0001;
end

endmodule
