// D:/GitHub/ITC/A_Guide_to_Digital_Design_and_Synthesis/Chapter03_Basic_Concepts/source

`timescale 1ns/10ps




module ch3_test;

reg [0:40] virtual_addr;
reg [3:0] bus;
reg [8*19:1] string_value; // Declare a variable that is 18 bytes wide

initial
begin
  $monitor ($time, "\n\nMONITOR\nvirtual_addr = %d\nbus = %h\nstring_value = %s", virtual_addr, bus, string_value);
  #7;
  string_value = "Hello Verilog World"; // String can be stored in variable

end

// 0100_1000


initial
begin
  $display("Hello Verilog World");
  #10;
  $display($time);
  #10;
  $display($time, "String_Value = %s", string_value);
  $display("String_Value = %h", string_value);
  $display("At time %d virtual address is %h", $time, virtual_addr);
  $display("Bus value is %b", bus);
  #10;
  virtual_addr = 41'd100;
  #10;
  bus = 4'hF;
  $display("At time %d virtual address is %h", $time, virtual_addr);
  $display("Bus value is %b", bus);   //  1111
  $display("Bus value is %d", bus);   //  15
  $display("Bus value is %H", bus);   //  f

end



initial
begin
  #100
  $stop;
end

endmodule

