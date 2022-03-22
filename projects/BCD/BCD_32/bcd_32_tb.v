`timescale 1ns/10ps

module bcd_32_tb;
reg         clk             ;
reg         rstn            ;
reg [31:0]  bin_data        ;
reg         bin_data_valid  ;
reg         bcd_redy        ;
wire        bin_redy        ;
wire[39:0]  bcd_data        ;
wire        bcd_data_valid  ;

// 100 MHz clock generator
initial
begin
  clk = 1'b1;
  forever
  begin
    #5 clk = ~clk;
  end
end

// Generate active low reset and bcd_redy
initial
begin
  rstn      = 1'b0;
  bcd_redy  = 1'b0;

  repeat(11) @(posedge clk);
  #6;
  rstn      = 1'b1;
  repeat(4) @(posedge clk);
  bcd_redy  = 1'b1;
end

always @(posedge clk)
begin
  if (rstn == 1'b0)
  begin
    bin_data_valid <= 1'b0;
  end else begin
    bin_data_valid <= 1'b1;
  end
end // always

always @(posedge clk)
begin
  if (rstn == 1'b0)
  begin
    bin_data  = 32'h0;
  end else begin
    if (bin_redy == 1'b1)
    begin
      bin_data <= $random;
    end
  end
end // always

always @(posedge clk)
begin
  if(bin_data_valid == 1'b1 && bin_redy == 1'b1 )
  begin
      $display("Time%d\nBin Data = %d", $time, bin_data);
  end
end // always

always @(posedge clk)
begin
  if(bcd_data_valid == 1'b1 && bcd_redy == 1'b1 )
  begin
      $display("BCD Data = %h", bcd_data);
  end
end // always


bcd_32 DUT (
  //    System signals
  .clk_i            (clk),    // 100 MHz
  .rstn_i           (rstn),
  //  Bin input interface
  .bin_data_i       (bin_data),         // Input to be converted to BCD
  .bin_data_valid_i (bin_data_valid),
  .bin_redy_o       (bin_redy),
  //  BCD output interface
  .bcd_data_o       (bcd_data),         // Converted data
  .bcd_data_valid_o (bcd_data_valid),
  .bcd_redy_i       (bcd_redy)
);


endmodule
