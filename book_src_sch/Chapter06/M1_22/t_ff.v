
module t_ff (
  input clock,
  input reset,
  output q
);

wire qbar_w;

  d_ff D_FF (
    .clock (clock),
    .reset (reset),
    .d (qbar_w),
    .qbar (qbar_w),
    .q (q)
  );
endmodule