import uvm_pkg::*;
`include "uvm_macros.svh"
`include "hello_world_test.sv"

module tb;
   logic  clk, reset_n;
   top    dut(.*);

   initial begin
      clk = 0;
      forever begin
         #10ns;
         clk = !clk;
      end
   end

   initial begin
      reset_n = 0;
      #100ns;
      reset_n = 1;
   end

   initial begin
      uvm_top.run_test();
   end

endmodule
