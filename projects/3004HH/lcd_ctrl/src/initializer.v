module initializer(
  input       rstn_i,
  input       clk_i,
  input       ready_i,
  output [8:0]data_o,
  output      data_valid_o
);

reg [5:0]  address;
reg [20:0] timer;

always@(posedge clk_i)
begin
  if(rstn_i == 1'b0)
  begin
    timer <= 21'h0;
  end else begin
    timer <= timer + 21'h1;
  end
end

endmodule
