//4-bit Binary counter
module counter(Q , clock, clear);
// I/O ports
  output [3:0] Q;
  input clock,
        clear;

//output defined as register
  reg [3:0] Q;

always @( posedge clear or negedge clock)
begin
  if (clear)
    Q <= 4'd0; //Nonblocking assignments are recommended
  //for creating sequential logic such as flipflops
  else
    Q <= Q + 1;// Modulo 16 is not necessary because Q is a
  // 4-bit value and wraps around.
end

endmodule
