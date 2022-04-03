// File Name shift_reg_4_bit.v
module shift_reg_4_bit
(
  input wire          clk_i,
  input wire          rst_n_i,
  input wire  [3:0]   data_i,
  output reg  [3:0]   data_o
);

always @(posedge clk_i)
begin
  if (rst_n_i == 1'b0)
  begin
    data_o <= 4'b0000;
  end else
  begin
    data_o <= data_i;
  end
end

endmodule
