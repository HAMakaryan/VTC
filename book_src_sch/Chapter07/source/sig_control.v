`define   TRUE      1'b1
`define   FALSE     1'b0
//Delays
`define   Y2RDELAY  3_000_000_00 //Yellow to red delay
`define   R2GDELAY  2_000_000_00 //Red to green delay

module sig_control (
  output      [2:0]  rgb_hwy,
  output      [2:0]  rgb_cntry,
  input              X,
  input              clock,
  input              rst_n
);

parameter [2:0] s0    = 3'b000;
parameter [2:0] s1    = 3'b001;
parameter [2:0] s2    = 3'b010;
parameter [2:0] s3    = 3'b011;
parameter [2:0] s4    = 3'b100;

parameter [1:0] GREEN  = 2'b00;
parameter [1:0] RED    = 2'b01;
parameter [1:0] YELLOW = 2'b11;

reg [ 2:0]    state_next;
reg [ 2:0]    state_current;
reg [28:0]    counter;
reg [ 1:0]     hwy;
reg [ 1:0]     cntry;


assign rgb_hwy =    (GREEN  == hwy)? 3'b010 :
                    (RED    == hwy)? 3'b100 :
                    (YELLOW == hwy)? 3'b001 :
                     3'b000;

assign rgb_cntry =  (GREEN  == cntry)? 3'b010 :
                    (RED    == cntry)? 3'b100 :
                    (YELLOW == cntry)? 3'b001 :
                     3'b000;

always@(posedge clock)
begin
  if(rst_n == 1'b0)
  begin
    state_current <= s0;
  end else
  begin
    state_current <= state_next;
  end
end

always@(*)
begin
  state_next = state_current;
  case(state_current)
    s0  :
      begin
        if (X == 1'b1)
        begin
          state_next = s1;
        end
      end
    s1  :
      begin
        if (counter == 0)
        begin
          state_next = s2;
        end
      end
    s2  :
      begin
        if (counter == 0)
        begin
          state_next = s3;
        end
      end
    s3  :
      begin
        if (X == 0)
        begin
          state_next = s4 ;
        end
      end
    s4  :
      begin
        if (counter == 0)
        begin
          state_next = s0 ;
        end
      end
    default  :
      begin
        state_next = s0;
      end
  endcase
end


always@(posedge clock)
begin
  if(rst_n == 1'b0)
  begin
    counter <= 29'h0;
  end else if ((state_current == s0 && state_next == s1) ||
               (state_current == s3 && state_next == s4))
  begin
    counter <= `Y2RDELAY;
  end else if (state_current == s1 && state_next == s2)
  begin
    counter <= `R2GDELAY;
  end else if (state_current == s1 ||
               state_current == s2 ||
               state_current == s4)
  begin
    counter <= counter - 29'h1;
  end
end

always@(posedge clock)
begin
  if(rst_n == 1'b0)
  begin
    cntry <= 2'b10;
    hwy   <= 2'b10;
  end else
  begin
    case(state_current)
    s0  :
      begin
        hwy   <= GREEN;
        cntry <= RED;
      end
    s1  :
      begin
        hwy   <= YELLOW;
        cntry <= RED;
      end
    s2  :
      begin
        hwy   <= RED;
        cntry <= RED;
      end
    s3  :
      begin
        hwy   <= RED;
        cntry <= GREEN;
      end
    s4  :
      begin
        hwy   <= RED;
        cntry <= YELLOW;
      end
    default  :
      begin
        cntry <= 2'b10;
        hwy   <= 2'b10;
      end
  endcase

  end
end


endmodule


