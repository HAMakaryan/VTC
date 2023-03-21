/// `define SIM

module lcd_ctrl (
/* system interface */
input rst_n,
input clk,
/* data interface   */
input [8:0]data,
input data_valid,
output ready,
/* lcd interface    */
output reg      lcd_rs,
output reg [7:0]lcd_data,
output          lcd_enable
);

localparam [1:0]IDLE   = 2'b00;
localparam [1:0]SET    = 2'b01;
localparam [1:0]STROBE = 2'b10;
localparam [1:0]DELAY  = 2'b11;

reg [1:0]state_next;
reg [1:0]state_current;
reg [17:0]counter;


wire  [7:0]cnt;
wire  [7:0]delay;

`ifdef SIM
assign cnt = counter[12:5];
`else
assign cnt = counter[17:10];
`endif
assign delay = ({lcd_rs,lcd_data[7:2]} == 7'd0)? 8'd250 : 8'd10;
assign lcd_enable = (state_current == STROBE)  ? 1'b1   : 1'b0;
assign ready = (state_current == IDLE)  ? 1'b1   : 1'b0;

always @(posedge clk)
begin
  if (rst_n == 1'b0)
  begin
    state_current <= IDLE;
  end else
  begin
    state_current <= state_next;
  end
end

always @(data_valid , state_current , cnt)
begin
  state_next = state_current;
  case(state_current)
    IDLE:
      begin
        if(data_valid == 1'b1)
          begin
            state_next = SET;
          end
      end
    SET:
      begin
        if(cnt >= 8'd1)
          begin
            state_next = STROBE;
          end
      end
    STROBE:
      begin
        if(data_valid == 1'b1)
          begin
            state_next = DELAY;
          end
      end
    DELAY:
      begin
        if(cnt >= delay)
          begin
            state_next = IDLE;
          end
      end
    default:
      begin
        state_next  = IDLE;
      end
  endcase
end

always @(posedge clk)
begin
  if(rst_n == 1'b0)
    begin
      counter <= 18'd0;
    end else
      begin
        if(state_current != state_next)
          begin
            counter <= 18'd0;
          end else if(state_current != IDLE)
                begin
                  counter = counter + 18'd1;
                end
      end

end

always @(posedge clk)
  begin
    if(rst_n == 1'b0)
      begin
        lcd_data <= 8'd0;
        lcd_rs   <= 1'b0;
      end
      else if(ready == 1'b1 && data_valid == 1'b1)
       begin
        lcd_data <= data[7:0];
        lcd_rs   <= data[8];
       end
  end

endmodule
