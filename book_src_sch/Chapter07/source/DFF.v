
//`define srst


module DFF (
  input         clock,
  input         rstn,
  input         d,
  output  reg   Q
);

`ifndef srst
always @(posedge clock, negedge rstn)
`else
always @(posedge clock)
`endif

begin
  if(!rstn) begin
    Q <=0;
  end else begin
    Q <=d;
  end
end

endmodule

