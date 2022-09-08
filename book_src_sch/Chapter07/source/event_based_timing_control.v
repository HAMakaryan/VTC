`timescale 1ns/10ps

`define LEVELSENSITIVE_CONTROL
                                  // REGULAR_EVENT_CONTROL
                                  // NAMED_EVENT_CONTROL
                                  // EVENT_OR_CONTROL
                                  // LEVELSENSITIVE_CONTROL

module event_based_timing_control;

reg clock = 0;
reg q, d, Q, Y;
reg count_enable;
reg last_data_packet;
reg [3:0] data_pkt = 4'bXZ10;
reg [3:0] data_buf = 4'b0000;
reg reset;
reg rstn;
integer count = 0;


always
begin
  #5 clock = !clock;
end
/*
There are four types of event-based timing control:
  .Regular event control
  .Named event control
  .Event OR control
  .Levelsensitive timing control
*/

`ifdef REGULAR_EVENT_CONTROL
  initial
  begin
    #1 d = 0;
    @(clock) q = d; //q = d is executed whenever signal clock changes value
    #7 d = 1;
    @(clock) q = d; //q = d is executed whenever signal clock changes value
    #6 d = 0;       // 21 ns
    @(posedge clock) q = d; //q = d is executed whenever signal clock does
                            //a positive transition ( 0 to 1,x or z,
                            // x to 1, z to 1 )
    #6 d = 1;               // 31 ns
    @(negedge clock) q = d; //q = d is executed whenever signal clock does
                            //a negative transition ( 1 to 0,x or z,
                            //x to 0, z to 0)
    #6 d = 0;               // 46 ns
    q  <= @(posedge clock) d; //d is evaluated immediately and assigned
    #1 d = 1;               //to q at the positive edge of clock
  end

`elsif NAMED_EVENT_CONTROL
//This is an example of a data buffer storing data after the
//last packet of data has arrived.

initial
begin
  last_data_packet = 1'b0;
  @(posedge clock) #24 last_data_packet = !last_data_packet;
  @(posedge clock) #13 last_data_packet = !last_data_packet;
  @(posedge clock) #16 last_data_packet = !last_data_packet;
  @(posedge clock) #33 last_data_packet = !last_data_packet;
  @(posedge clock) #24 last_data_packet = !last_data_packet;
  @(posedge clock) #13 last_data_packet = !last_data_packet;
  @(posedge clock) #16 last_data_packet = !last_data_packet;
  @(posedge clock) #33 last_data_packet = !last_data_packet;
end


event received_data; //Define an event called received_data

always @(posedge clock) //check at each positive clock edge
begin
  if(last_data_packet)  //If this is the last data packet
  #3 ->received_data;      //trigger the event received_data
end
//data_pkt = 4'bXZ10;
always @(received_data)     //Await triggering of event received_data
begin
  data_buf = {data_pkt[0],  //When event is triggered, store all four
              data_pkt[1],  //packets of received data in data buffer
              data_pkt[2],  //use concatenation operator { }
              data_pkt[3]
              };
  #4;
  data_pkt = data_buf;
end

`elsif EVENT_OR_CONTROL
initial
begin
  reset = 1'b1;
  rstn  = !reset;
  #46;
  reset = 1'b0;
  rstn  = !reset;
  #11;
  reset = 1'b1;
  rstn  = !reset;
  #13;
  reset = 1'b0;
  rstn  = !reset;
  #38;
  reset = 1'b1;
  rstn  = !reset;
  #9;
  reset = 1'b0;
  rstn  = !reset;

end

initial
begin
  d = 1'b0;
  #4 d = !d;
  #3 d = !d;
  #5 d = !d;
  #4 d = !d;
  #1 d = !d;
  #70 d = !d;
  #3 d = !d;
  #4 d = !d;
  #4 d = !d;
  #4 d = !d;
  #4 d = !d;
  #1.5 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;
  #3 d = !d;
  #1 d = !d;
  #1 d = !d;
  #1 d = !d;

  end
//A level-sensitive latch with asynchronous reset

//always @( reset, clock, d) //Wait for reset or clock or d to change
always @( reset or clock or d) //Wait for reset or clock or d to change
begin
  if (reset) //if reset signal is high, set q to 0.
  begin
    q = 1'b0;
  end
  else if(clock) //if clock is high, latch input
  begin
    q = d;
  end
end

//A positive edge triggered D flipflop with asynchronous falling
//reset can be modeled as shown below
always @(posedge clock, negedge rstn) //Note use of comma operator
begin
  if(!rstn) begin
    Q <=0;
  end else begin
    Q <=d;
  end
end

always @(posedge clock)
begin
  if(!rstn) begin
    Y <=0;
  end else begin
    Y <=d;
  end
end

////Combination logic block using the or operator
////Cumbersome to write and it is easy to miss one input to the block
//always @(a or b or c or d or e or f or g or h or p or m)
//begin
//  out1 = a ? b+c : d+e;
//  out2 = f ? g+h : p+m;
//end
//  //Instead of the above method, use @(*) symbol
//  //Alternately, the @* symbol can be used
//  //All input variables are automatically included in the
//  //sensitivity list.
//always @(*)
//begin
//  out1 = a ? b+c : d+e;
//  out2 = f ? g+h : p+m;
//end

`elsif LEVELSENSITIVE_CONTROL
initial
begin
  count_enable = 0;
  #55;
  count_enable = 1;
  #74;
  //count_enable = 0;
  #25;
  count_enable = 1;
end


always
begin
  wait (count_enable)
  begin
    #20 count = count + 1; // 75ns
    @(posedge clock);
    @(posedge clock);
    @(posedge clock);
    @(posedge clock);
    @(posedge clock);
  end
end
`endif

initial
begin
  #4000;
  $stop;
end


endmodule