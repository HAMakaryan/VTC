//Define a module called operation that contains the task bitwise_oper
module operation;

parameter     delay = 10;

reg   [15:0]  A, B;
reg   [15:0]  AB_AND, AB_OR, AB_XOR;
reg   [15:0]  AB_AND_d, AB_OR_d, AB_XOR_d;



always @(A or B) //whenever A or B changes in value
begin
  //invoke the task bitwise_oper. provide 2 input arguments A, B
  //Expect 3 output arguments AB_AND, AB_OR, AB_XOR
  //The arguments must be specified in the same order as they
  //appear in the task declaration.
  bitwise_oper(AB_AND, AB_OR, AB_XOR, A, B);
  #delay;

end

//define task bitwise_oper
task bitwise_oper;
  output  [15:0] ab_and, ab_or, ab_xor; //outputs from the task
  input   [15:0] a, b; //inputs to the task
  begin
    ab_and  = a & b;
    ab_or   = a | b;
    ab_xor  = a ^ b;

    AB_AND_d  = a & b;
    AB_OR_d   = a | b;
    AB_XOR_d  = a ^ b;
    #(delay/4 );
  end
endtask

initial
begin
  A = 16'h0;
  B = 16'h0;
  forever
  begin
    #delay;
    A = A + 16'h1;
    B = B + 16'h100;
  end
end

//    Example 8-11 Constant Functions


//Define a RAM model
  parameter RAM_DEPTH = 256;

integer RD = clogb2(RAM_DEPTH);

//by calling constant
//function defined below
//Result of clogb2 = 8
//input [7:0] addr_bus;

//Constant function
function integer clogb2 (input integer depth);
begin
  for(clogb2=0; depth > 0; clogb2=clogb2+1)
    depth = depth >> 1;
  end
endfunction




endmodule
