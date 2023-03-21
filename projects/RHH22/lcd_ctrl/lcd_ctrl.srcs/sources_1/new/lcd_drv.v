`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 12/20/2022 11:33:47 AM
// Design Name:
// Module Name: lcd_drv
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module lcd_drv(
// system interface
    input         rstn_i,
    input         clk_i,   //100mHz
// data interface
    input [8:0]   data_i,
    input         data_valid_i,
    output ready_o,
// LCD interface
    output reg        rs_o,
    output reg [7:0]  lcd_data_o,
    output            en_o
    );

localparam IDLE     = 2'b00;
localparam SET      = 2'b01;
localparam STROBE   = 2'b10;
localparam DELAY    = 2'b11;

localparam FETCH      = 2'b00;
localparam DELAY_INIT = 2'b01;
localparam VALID      = 2'b10;
localparam INC        = 2'b11;


reg [ 1:0]  current_state;
reg [ 1:0]  next_state;
reg [ 1:0]  init_current;
reg [ 1:0]  init_next;
reg [20:0]  counter;
reg         init_complete;
reg         init_data_valid;
reg [ 7:0]  lcd_data;
reg         rs;
reg [ 3:0]  rom_address;


wire [10:0] cnt;
wire        data_valid;
wire [ 8:0] data;
wire [ 7:0] delay;
wire        ready;
wire        init_ready;
wire [ 8:0] init_data;
wire [ 1:0] init_delay;

assign cnt        = counter [20:10];
assign data_valid = (init_complete == 1'b1)? data_valid_i : init_data_valid;
assign data       = (init_complete == 1'b1)? data_i : init_data;
assign ready_o    = ((init_complete == 1'b1) && (current_state == IDLE))? 1'b1 : 1'b0;
assign delay      = ({ rs_o,lcd_data_o[7:2]} == 0 )? 8'hFF : 8'd10;
assign ready      = (current_state == IDLE)? 1'b1 : 1'b0;
assign init_ready = ((init_complete == 1'b0) && (current_state == IDLE))? 1'b1 : 1'b0;
assign init_complete = (init_data == 9'h0)? 1'b1 : 1'b0;

always @(posedge clk_i)
begin
    if (rstn_i == 1'b0)
    begin
      init_current <= FETCH;
    end
    else
    begin
      init_current <= init_next;
    end
end

always @(posedge clk_i)
begin
    if (rstn_i == 1'b0)
    begin
      current_state <= IDLE;
    end
    else
    begin
      current_state <= next_state;
    end
end

always@(*)
begin
  next_state = current_state;
  case (current_state)
    IDLE:
    begin
      if(data_valid == 1'b1)
      begin
        next_state = SET;
      end
    end
    SET:
    begin
      if(cnt == 11'b1)
      begin
        next_state = STROBE;
      end
    end
    STROBE:
    begin
      if(cnt == 11'b1)
      begin
        next_state = DELAY;
      end
    end
    DELAY:
    begin
      if(cnt == delay)
      begin
        next_state = IDLE;
      end
    end
    default:
    begin
      next_state = IDLE;
    end
  endcase
end

always@(*)
begin
  init_next = init_current;
  case (init_current)
    FETCH:
    begin
      init_next = DELAY_INIT;
    end
    DELAY_INIT:
    begin
      if((init_delay == counter[20:19]) && (init_complete == 1'b0))
      begin
        init_next = VALID;
      end
    end
    VALID:
    begin
      if(init_ready == 1'b1)
      begin
        init_next = INC;
      end
    end
    INC:
    begin
      init_next = FETCH;
    end
    default:
    begin
      init_next = FETCH;
    end
  endcase
end

always @(posedge clk_i)
begin
  if(rstn_i == 0)
  begin
    lcd_data_o  <= 8'h00;
    rs_o        <= 1'b0;
  end
  else
  begin
    lcd_data_o  <= data[7:0];
    rs_o        <= data[8];
  end
end

always @(posedge clk_i)
begin
  if(rstn_i == 0)
  begin
    rom_address <= 4'b0000;
  end
  else
  begin
    if(init_current == INC)
    begin
      rom_address <= rom_address + 4'b0001;
    end
  end
end

always @(posedge clk_i)
begin
  if(rstn_i == 0)
  begin
    counter <= 21'b0;
  end
  else
  begin
    if((current_state != next_state) || ((init_complete == 1'b1) && (current_state == IDLE) ))
    begin
      counter <= 21'b0;
    end
    else
    begin
      counter <= counter + 21'b1;
    end
  end
end

dist_mem_gen_0 your_instance_name (
  .a  (rom_address),            // input wire [3 : 0] a
  .spo({init_delay, init_data})   // output wire [10 : 0] spo
);


endmodule
