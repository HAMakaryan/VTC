// Edge-triggered D flipflop

module d_ff (
  input   clk,
  input   clear,
  input   d,
  output  qbar,
  output  q
);

// Internal variables
wire s, sbar, r, rbar,cbar;

// dataflow statements

//Create a complement of signal clear
assign cbar = ~clear;

// Input latches; A latch is level sensitive. An edge-sensitive
// flip-flop is implemented by using 3 SR latches.
assign sbar = ~(rbar & s),
s = ~(sbar & cbar & ~clk),
r = ~(rbar & ~clk & s),
rbar = ~(r & cbar & d);

// Output latch
assign    q = ~(s & qbar);
assign qbar = ~(q & r & cbar);

endmodule