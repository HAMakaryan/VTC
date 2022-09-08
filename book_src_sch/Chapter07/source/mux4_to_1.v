// 4-to-1 multiplexer. Port list is taken exactly from
// the I/O diagram.

module mux4_to_1 (
  out,
  i0,
  i1,
  i2,
  i3,
  s1,
  s0
);

// Port declarations from the I/O diagram
output out;
input i0, i1, i2, i3;
input s1, s0;

//output declared as register
reg out;

//recompute the signal out if any input signal changes.
//All input signals that cause a recomputation of out to
//occur must go into the always @(...) sensitivity list.

always @(s1 or s0 or i0 or i1 or i2 or i3)
begin
  case ({s1, s0})
    2'b00:    out = i0;
    2'b01:    out = i1;
    2'b10:    out = i2;
    2'b11:    out = i3;
    default:  out = 1'bx;
  endcase
end
endmodule// 4-to-1 multiplexer. Port list is taken exactly from

