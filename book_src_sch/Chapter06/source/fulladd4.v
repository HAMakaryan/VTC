// Define a 4-bit full adder by using dataflow statements.

module fulladd4(
// Input port declarations

  input [3:0] a,
  input [3:0] b,
  input       c_in,
// Output port declarations
  output [3:0] sum,
  output c_out
);

// Specify the function of a full adder
assign {c_out, sum} = a + b + c_in;

endmodule







