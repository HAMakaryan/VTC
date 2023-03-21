`define   TRUE      1'b1
`define   FALSE     1'b0
//Delays
`define   Y2RDELAY  3_000_000_00 //Yellow to red delay
`define   R2GDELAY  2_000_000_00 //Red to green delay

module Traffic_Signal_Controller (
  output reg  [2:0]  rgb_hwy,
  output reg  [2:0]  rgb_cntry,
  input              X,
  input              clock,
  input              rst_n
);

localparam s0=3'b000;
localparam s1=3'b001;
localparam s2=3'b010;
localparam s3=3'b011;
localparam s4=3'b100;

reg [2:0]  next_state;
reg [2:0]  current_state;
reg [28:0] counter;

always @(posedge clock)
  begin
    if (rst_n==1'b0)
    begin
      current_state <= s0;
    end
    else
    begin
      current_state <= next_state;
    end
  end

always @(X, current_state, counter)
  begin
    next_state = current_state;
    case (current_state)
      s0 :
        begin
          if (X == 1'b1)
          begin
            next_state = s1;
          end
        end
      s1 :
        begin
          if (counter == 29'd0)
          begin
            next_state = s2;
          end
        end
      s2 :
        begin
          if (counter == 29'd0)
          begin
            next_state = s3;
          end
        end
      s3 :
        begin
          if (X == 1'b0)
          begin
            next_state = s4;
          end
        end
      s4 :
        begin
          if (counter == 29'd0)
          begin
            next_state = s0;
          end
        end
      default:
        begin
          next_state = s0;
        end
    endcase
  end

  always @(posedge clock)
  begin
    if (rst_n == 1'b0)
    begin
      counter <= 29'd0;
    end
    else
    if ((current_state == s0 && next_state == s1) ||
        (current_state == s3 && next_state == s4))
    begin
      counter <= `Y2RDELAY;
    end
    else
    if (current_state == s1 && next_state == s2)
    begin
      counter <= `R2GDELAY;
    end
    else
    begin
      counter <= counter-29'd1;
    end
  end

  always @(posedge clock)
  begin
    if (rst_n == 1'b0)
    begin
      rgb_hwy   <= 3'b000;
      rgb_cntry <= 3'b000;
    end
    else
    begin
      case (current_state)
        s0 :
        begin
          rgb_hwy   <= 3'b010;
          rgb_cntry <= 3'b100;
        end
        s1 :
        begin
          rgb_hwy   <= 3'b110;
          rgb_cntry <= 3'b100;
        end
        s2 :
        begin
          rgb_hwy   <= 3'b100;
          rgb_cntry <= 3'b100;
        end
        s3:
        begin
          rgb_hwy   <= 3'b100;
          rgb_cntry <= 3'b010;
        end
        s4 :
        begin
          rgb_hwy   <= 3'b100;
          rgb_cntry <= 3'b110;
        end
        default
        begin
          rgb_hwy   <= 3'b100;
          rgb_cntry <= 3'b100;
        end
      endcase
    end
  end

endmodule
