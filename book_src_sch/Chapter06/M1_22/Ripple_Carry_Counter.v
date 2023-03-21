// D:\GitHub\VTC\book_src_sch\Chapter06\M1_22\Ripple_Carry_Counter.v

module Ripple_Carry_Counter (
   input clock,
   input clear,
   output [3:0]q
);

t_ff tff_0 (
  .clock (clock),
  .reset (clear),
  .q (q[0])
);

t_ff tff_1 (
  .clock (q[0]),
  .reset (clear),
  .q (q[1])
);

t_ff tff_2 (
  .clock (q[1]),
  .reset (clear),
  .q (q[2])

t_ff tff_3 (
  .clock (q[2]),
  .reset (clear),
  .q (q[3])
endmodule

