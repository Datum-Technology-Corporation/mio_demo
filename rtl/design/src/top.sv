module top(input clk, reset_n);
   always @(posedge clk) begin
      if (reset_n === 0) begin
         // Reset variables ...
      end
      else if (reset_n === 1) begin
         // Do stuff ...
      end
   end
endmodule
