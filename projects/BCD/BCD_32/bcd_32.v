
module bcd_32 (
  //    System signals
  input           clk_i,    // 100 MHz
  input           rstn_i,
  //  Bin input interface
  input   [31:0]  bin_data_i,         // Input to be converted to BCD
  input           bin_data_valid_i,
  output          bin_redy_o,
  //  BDC output interface
  output  [39:0]  bdc_data_o,         // Converted data
  output          bdc_data_valid_o,
  input           bdc_redy_i
);

localparam  IDLE      = 2'b00;    // Ready to receive data from BIN input
localparam  CONVERT   = 2'b01;    // Converting in progress
localparam  COMPLETE  = 2'b10;    // Converted data is redy

reg     [31:0]  bin_data;
reg     [39:0]  bdc_data;
reg     [ 4:0]  counter;
reg     [ 1:0]  state_next;
reg     [ 1:0]  state_current;

wire    [39:0]  bdc_shift;
wire            update_en;
wire            shift_en;

assign update_en  = (bin_data_valid_i == 1'b1 && bin_redy_o == 1'b1)? 1'b1 : 1'b0;
assign bdc_data_o = bdc_data;
assign bin_redy_o = (state_current == IDLE)? 1'b1 : 1'b0;
assign bdc_data_valid_o = (state_current == COMPLETE)? 1'b1 : 1'b0;

always @(posedge clk_i)
begin
  if (rstn_i == 1'b0)
  begin
    bdc_data <= {40{1'b0}};
  end else if (state_current == IDLE) begin
    bdc_data <= {40{1'b0}};
  end else if (shift_en == 1'b1) begin
    bdc_data <= {bdc_shift[38:0], bin_data[31]};
  end
end // always

always @(posedge clk_i)
begin
  if (rstn_i == 1'b0)
  begin
    bin_data <= {32{1'b0}};
  end else if (update_en == 1'b1)  begin
    bin_data <= bin_data_i;
  end else if (shift_en == 1'b1)  begin
    bin_data <= bin_data << 1;
  end
end // always

always @(posedge clk_i)
begin
  if (rstn_i == 1'b0)
  begin
    state_current <= IDLE;
  end else begin
    state_current <= state_next;
  end
end // always


always @(*)
begin
  state_next = state_current;
  case (state_current)
    IDLE:
    begin
      if (bin_data_valid_i == 1'b1)
      begin
        state_next = CONVERT;
      end
    end
    CONVERT :
    begin
      if (counter == 5'h1F)
      begin
        state_next = COMPLETE;
      end
    end
    COMPLETE:
    begin
      if (bdc_redy_i == 1'b1)
      begin
        state_next = IDLE;
      end
    end
    default :
    begin
      state_next = COMPLETE;
    end
  endcase
end


always @(posedge clk_i)
begin
  if (rstn_i == 1'b0)
  begin
    counter <= 5'h0;
  end else if (state_current == IDLE) begin
    counter <= counter + 5'h0;
  end else if (state_current == CONVERT) begin
    counter <= counter + 5'h1;
  end
end // always

conditional_adder adder_3_0(
  .data_i (bdc_data [3:0]),
  .sum_o  (bdc_shift[3:0])
);

conditional_adder adder_7_4(
  .data_i (bdc_data [7:4]),
  .sum_o  (bdc_shift[7:4])
);

conditional_adder adder_11_8(
  .data_i (bdc_data [11:8]),
  .sum_o  (bdc_shift[11:8])
);

conditional_adder adder_15_12(
  .data_i (bdc_data [15:12]),
  .sum_o  (bdc_shift[15:12])
);

conditional_adder adder_19_16(
  .data_i (bdc_data [19:16]),
  .sum_o  (bdc_shift[19:16])
);

conditional_adder adder_23_20(
  .data_i (bdc_data [23:20]),
  .sum_o  (bdc_shift[23:20])
);

conditional_adder adder_27_24(
  .data_i (bdc_data [27:24]),
  .sum_o  (bdc_shift[27:24])
);

conditional_adder adder_31_28(
  .data_i (bdc_data [31:28]),
  .sum_o  (bdc_shift[31:28])
);

always @(posedge clk_i)
begin
  if (rstn_i == 1'b0)
  begin
    //
  end else begin
    //
  end
end // always

endmodule
