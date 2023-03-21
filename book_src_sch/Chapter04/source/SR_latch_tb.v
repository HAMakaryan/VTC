`timescale 1ns/10ps

module SR_latch_tb;

reg Sbar;
reg Rbar;
wire Qbar;
wire Q;


SR_latch DUT(
  .Q    (Q)     ,
  .Qbar (Qbar)  ,
  .Sbar (Sbar)  ,
  .Rbar (Rbar)
);

initial
begin
  Sbar=1'b0;
  Rbar=1'b0;
  #10;
  Sbar=1'b1;
  Rbar=1'b0;
  #10;
  Sbar=1'b0;
  Rbar=1'b1;
  #10;
  Sbar=1'b0;
  Rbar=1'b0;
  #10;
  Rbar=1'b1;
  Sbar=1'b1;
  #10;
  Sbar=1'b1;
  Rbar=1'b0;
  #10;
  Sbar=1'b1;
  Rbar=1'b1;
  #10;
  Sbar=1'b0;
  Rbar=1'b1;
  #10;
  Sbar=1'b1;
  Rbar=1'b1;
  #10;
end

endmodule
