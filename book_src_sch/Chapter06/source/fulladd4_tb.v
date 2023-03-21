//Test banch for  4-bit full adder.
`timescale 1ns/10ps

module fulladd4_tb();

reg clk;
reg [8:0] in_vec;
wire[3:0] SUM;
wire C_OUT;

initial
begin
  clk=0;
  forever
  begin
    #5;
    clk=!clk;
  end
end

initial
begin
  in_vec=9'd0;
end

always@(posedge clk)
begin
  in_vec<=in_vec+9'd1;
end

 fulladd4 dut(
   .a(in_vec[3:0]),
   .b(in_vec[7:4]),
   .c_in(in_vec[8]),
   .sum(SUM),
   .c_out(C_OUT)
);



endmodule







