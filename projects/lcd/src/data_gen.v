module data_gen (
  input             clock_i,
  input             rstn_i,
  output  reg [8:0] data_o,
  output  reg       valid_o,
  input             ready_i,
);


always @(posedge clock_i)
begin
  if (rstn_i == 1'b0) begin
    valid_o <= 1'b0;
  end else begin
    valid_o <= 1'b1;
  end
end


always @(posedge clock_i)
begin
  if (rstn_i == 1'b0) begin
    data_o  <=  {9{1'b0}};
  end else if (ready_i == 1'b1) begin
    data_o  <=  data_o + 9'h1;
  end
end

endmodule