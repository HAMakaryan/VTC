`timescale 1ns/10ps

module mux_4x1_tb;

reg [1:0] sel;
reg [3:0] in;
wire q;

initial
begin
  sel = 2'b00;
  in  = 4'b0000;
end

always
begin
  #10;
  in = in + 4'b0001;
end

always
begin
  #200;
  sel = sel + 2'b01;
end


mux_4in  dut (
  .data_i (in),
  .select_i (sel),
  .q_o  (q)
);

endmodule
