`define   TRUE      1'b1
`define   FALSE     1'b0
//Delays
`define   Y2RDELAY  3_000_000_00 //Yellow to red delay
`define   R2GDELAY  2_000_000_00 //Red to green delay

module sig_control (
  output [1:0]  hwy,
  output [1:0]  cntry,
  input         X,
  input         clock,
  input         clear
);

parameter [2:0] s0    = 3'b000;
parameter [2:0] s1    = 3'b001;
parameter [2:0] s2    = 3'b010;
parameter [2:0] s3    = 3'b011;
parameter [2:0] s4    = 3'b100;
parameter [2:0] s1prs = 3'b101;
parameter [2:0] s2prs = 3'b110;
parameter [2:0] s4prs = 3'b111;

reg [ 2:0]    state_next;
reg [ 2:0]    state_current;
reg [33:0]    counter;
wire          time_over;

assign cntry = 2'b00;
assign hwy   = 2'b01;

always@(posedge clock)
begin
  if(clear == 1'b1)
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
        if(X == 1'b1)
        begin
          state_next = s1prs;
        end
      end
    s1prs  :
      begin
        state_next = s1;
      end
    s1  :
      begin
        if(time_over == 1'b1)
        begin
          state_next = s2prs;
        end
      end
    s2prs  :
      begin
        state_next = s2;
      end
    s2  :
      begin
        if(time_over == 1'b1)
        begin
          state_next = s3;
        end
      end
    s3  :
      begin
        if(X == 1'b0)
        begin
          state_next = s4prs;
        end
      end
    s4prs  :
      begin
        state_next = s4;
      end
    s4  :
      begin
        if(time_over == 1'b1)
        begin
          state_next = s0;
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
  if(clear == 1'b1)
  begin
    counter <= 34'h0;
  end else if (state_current == s1prs || state_current == s4prs)
  begin
    counter <= `Y2RDELAY;
  end else if (state_current == s2prs)
  begin
    counter <= `R2GDELAY;
  end else if (state_current == s1 ||
               state_current == s2 ||
               state_current == s4)
  begin
    counter <= counter - 34'h1;
  end
end

assign time_over = (counter == 34'h1 ) ? 1'b1 : 1'b0;

endmodule


