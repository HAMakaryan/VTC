// Negative edge-triggered D-flipflop with asynchronous reset
module edge_dff_tb;

wire q, qbar;          //declare q and qbar are registers

reg d;
reg clk;
reg reset;

always
begin
  clk = 1'b0;
  #5;
  clk = 1'b1;
  #5;
end

initial
begin
  reset = 1'b1;
  #53;
  reset = 1'b0;
  #33;
  reset = 1'b1;
  #43;
  reset = 1'b0;
  #200;
//  $stop;
end

always @(posedge clk)
begin
  d <= $random %2;
end

initial
begin
//these statements force value of 1 on dff.q between time 50 and
//100, regardless of the actual output of the edge_dff.
    #17 force   DUT.q = 1'b1; //force value of q to 1 at time 50.
    #15 release DUT.q;        //release the value of q at time 100.
end

edge_dff DUT (
  .q    (q),
  .qbar (qbar),
  .d    (d),
  .clk  (clk),
  .reset(reset)
);
endmodule

