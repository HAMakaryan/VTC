`define SIMULATION


module lcd_drv(
  //  System signals
  input         rst_n_i,        //  Active low reset
  input         clk_i,          //  System clock @ 100 MHz
  // Data interface (Ready/Valid protocol)
  input [8:0]   data_i,         // Input data
  input         data_valid_i,   // Data on bus is valid
  output        device_ready_o, // Device is ready
  //  LCD interface
  output reg       rs_o,        //  Register select
  output           en_o,        //  Strobe signal
  output reg [7:0] lcd_data_o   //  Data(or instruction) to LCD

);

//State encoding
// Initialization states
localparam DATA_FETCHING  = 3'b001;
localparam END_OF_INIT    = 3'b010;
localparam WAITING        = 3'b011;
localparam DATA_VALID     = 3'b100;
localparam ADDR_INCR      = 3'b101;
// Driver states
localparam IDLE           = 2'b00;
localparam SET            = 2'b01;
localparam STROBE         = 2'b10;
localparam DELAY          = 2'b11;

//State reg declaration
reg [1:0]  CurrentState;
reg [1:0]  NextState ;
//reg        InitComplete;
reg [2:0]  InitState;
reg [2:0]  InitNext;
reg [3:0]  RomAddr;

//Counter declaration
reg [20:0]  counter;
wire [7:0]  cnt;
wire [7:0]  dly;
//wire        ReadyInt;
//wire        ValidInt;
wire [8:0]  data;
wire        data_valid;
wire        device_ready;
wire [11:0] InitData;
wire        InitValid;


assign en_o = (CurrentState == STROBE)? 1'b1 : 1'b0;
assign device_ready = (CurrentState == IDLE)? 1'b1 : 1'b0;
assign dly = ({rs_o, lcd_data_o[7:2]} == 0)? 250 : 10;

`ifdef SIMULATION
assign cnt = counter[9:2];
`else
assign cnt = counter[17:10];
`endif

dist_mem_gen_0 ROM_inst (
  .a  (RomAddr ), // input wire  [3 : 0]  a
  .spo(InitData)  // output wire [11 : 0] spo
);




//Data and register_select definition

always@(posedge clk_i)
begin
  if (0 == rst_n_i ) begin
    InitState <= DATA_FETCHING;
  end
  else begin
    InitState <= InitNext;
  end
end


always@(posedge clk_i)
begin
  if (0 == rst_n_i )
  begin
    lcd_data_o  <= 8'H00;
    rs_o        <= 1'b0;
  end
  else
  begin
    if (data_valid && device_ready)
    begin
      lcd_data_o  <= data[7:0];
      rs_o        <= data[8];
    end
  end
end

always@(posedge clk_i)
begin
  if (0 == rst_n_i) begin
    CurrentState <= IDLE;
  end
  else begin
    CurrentState <= NextState;
  end
end

always@ (*)
begin
  InitNext = InitState;
  case (InitState)
        DATA_FETCHING:
        begin
          if(InitData [8:0] == 9'h0)
          begin
            InitNext = END_OF_INIT;
          end else begin
            InitNext = WAITING;
          end
        end
        WAITING:
        begin
          if(counter [20:18] == InitData [11:9])
          begin
            InitNext = DATA_VALID;
          end
        end
        DATA_VALID:
        begin
          if(device_ready == 1'b1)
          begin
            InitNext = DATA_FETCHING;
          end
        end
        END_OF_INIT:
        begin
          InitNext = InitNext;
        end
        default:
        begin
          InitNext = DATA_FETCHING;
        end
  endcase
end


//Counter definition
always@(posedge clk_i)
begin
    if (0 == rst_n_i) begin
         counter <= 18'b0;
    end
    else begin
        if (((CurrentState == IDLE) && (InitState == END_OF_INIT) )|| CurrentState != NextState) begin
            counter <= 21'd0;
        end
        else begin
            counter <= counter + 1;
       end
    end
end


//Conditional State - Transition
always@ (*)
begin
  NextState = CurrentState;
  case (CurrentState)
        IDLE:
        begin
          if(data_valid == 1)
          begin
            NextState = SET;
          end
        end
        SET:
        begin
          if(cnt >= 1)
          begin
            NextState = STROBE;
          end
        end
        STROBE:
        begin
          if(cnt >= 1)
          begin
            NextState = DELAY;
          end
        end
        DELAY:
        begin
          if(cnt >= dly)
          begin
            NextState = IDLE;
          end
        end
        default:
        begin
          NextState = IDLE;
        end
  endcase
end

always@(posedge clk_i)
begin
  if (0 == rst_n_i) begin
    RomAddr <= 4'b0000;
  end else begin
    if (device_ready == 1'b1 && InitState == DATA_VALID)
    begin
      RomAddr <= RomAddr + 4'b0001;
    end
  end
end

//////////////////////////  Initialization  //////////////////////////
assign data           =(InitState == END_OF_INIT)? data_i: InitData;
assign data_valid     =(InitState == END_OF_INIT)? data_valid_i : InitValid;
assign device_ready_o =(InitState == END_OF_INIT)? device_ready : 1'b0;
assign InitValid      =(InitState == DATA_VALID )? 1'b1         : 1'b0;

endmodule