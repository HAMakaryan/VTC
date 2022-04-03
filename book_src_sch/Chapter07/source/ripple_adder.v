// This module generates a gate level ripple adder

module ripple_adder
#(
// Parameter Declaration. This can be redefined
parameter N = 16 // 4-bit bus by default
)

(
  co,
  sum,
  a0,
  a1,
  ci
);

// Port declarations
output  [N-1:0] sum;
output          co;
input   [N-1:0] a0, a1;
input           ci;

//Local wire declaration
wire    [N:0] carry;

//Assign 0th bit of carry equal to carry input
assign carry[0]   = ci;
assign co         = carry[N];


// Declare a temporary loop variable. This variable is used only
// in the evaluation of generate blocks. This variable does not
// exist during the simulation of a Verilog design because the
// generate loops are unrolled before simulation.
genvar i;
//Generate the bit-wise Xor with a single loop
generate
  for (i=0; i<N; i=i+1) begin: r_loop
    wire t1, t2, t3;

    xor g1 (t1,         a0[i],  a1[i]);
    xor g2 (sum[i],     t1,     carry[i]);
    and g3 (t2,         a0[i],  a1[i]);
    and g4 (t3,         t1,     carry[i]);
    or  g5 (carry[i+1], t2,     t3);
  end //end of the for loop inside the generate block
endgenerate //end of the generate block
// For the above generate loop, the following relative hierarchical
// instance names are generated
// xor : r_loop[0].g1, r_loop[1].g1, r_loop[2].g1, r_loop[3].g1
//r_loop[0].g2, r_loop[1].g2, r_loop[2].g2, r_loop[3].g2
// and : r_loop[0].g3, r_loop[1].g3, r_loop[2].g3, r_loop[3].g3
//r_loop[0].g4, r_loop[1].g4, r_loop[2].g4, r_loop[3].g4
// or : r_loop[0].g5, r_loop[1].g5, r_loop[2].g5, r_loop[3].g5
// Generated instances are connected with the following
// generated nets
// Nets: r_loop[0].t1, r_loop[0].t2, r_loop[0].t3
// r_loop[1].t1, r_loop[1].t2, r_loop[1].t3
// r_loop[2].t1, r_loop[2].t2, r_loop[2].t3
// r_loop[3].t1, r_loop[3].t2, r_loop[3].t3




endmodule





