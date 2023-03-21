
`timescale 1ns/10ps

module temp_06;

wire Input, N_Out, Output;
wire [15:0] addr, addr1_bits, addr2_bits;

assign Output = Input & N_Out;
assign N_Out  = ~Input;

assign addr[15:0] = addr1_bits[15:0] ^ addr2_bits[15:0];

reg in1, in2;

wire #3 out;
integer a, b, c;

assign out = in1 & in2; // Delay in a continuous assign
initial
begin
  in1 = 1'b0;
  in2 = 1'b0;
  #20;
  in1 = 1'b1;
  in2 = 1'b1;
  #40;
  in1 = 1'b0;
  #20;
  in1 = 1'b1;
  #5;
  in1 = 1'b0;
  #20;
  $stop;
end


initial
begin
  #5;
  a = -10 / 5;
  #5;
  b = -'d10 / 5;
  #5;
end

//  6.4.1 Arithmetic Operators
    //  Binary operators

reg A = 4'b0011;
reg B = 4'b0100;  // A and B are register vectors


integer   D = 6;
integer   E = 4;
integer   F = 2;  // D and E are integers

integer   R = 0;

initial
begin
  #5;
  R = A * B; // Multiply A and B.
            //  Evaluates to 4'b1100
  #5;
  R = D / E; // Divide D by E. Evaluates to 1. Truncates any fractional part.
  #5;
  R = A + B; // Add A and B. Evaluates to 4'b0111
  #5;
  R = B - A; // Subtract A from B. Evaluates to 4'b0001
  #5;
  F = E ** F; //E to the power F, yields 16
  #5;
end




endmodule