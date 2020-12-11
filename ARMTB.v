`timescale 1ns/1ns

module ARMTB();
  reg clk = 0;
  reg rst = 0;
  ARM ARMInstance(.clk(clk), .rst(rst));


  initial begin
    #20 rst = 1;
    #90 rst = 0;
    #50000
    $stop;
  end
  always #50 clk = ~ clk;
endmodule
