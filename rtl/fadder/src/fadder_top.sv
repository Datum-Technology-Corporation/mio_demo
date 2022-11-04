// Copyright 2022 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __FADDER_TOP_SV__
`define __FADDER_TOP_SV__


/**
 * Full adder/subtractor.
 */
module fadder_top # (
   parameter DATA_WIDTH = 8
) (
   input                      clk      , ///< Clock
   input                      reset_n  , ///< Reset
   input                      op       , ///< Operation: '1' is addition and '0' is subtraction
   input                      ex       , ///< Execution: a '1' triggers addition/subtraction
   input                      vld_in   , ///< Indicates data input lines are valid
   input  [(DATA_WIDTH-1):0]  op_a     , ///< Operand A
   input  [(DATA_WIDTH-1):0]  op_b     , ///< Operand B
   input                      carry_in , ///< Carry in for additions
   output                     vld_out  , ///< Indicates data output lines are valid
   output [(DATA_WIDTH-1):0]  data_out , ///< Result of operation
   output                     carry_out  ///< Carry out for addition, negative sign for subtraction
);

   reg [(DATA_WIDTH-1):0]  buff_op_a, buff_op_b, buff_data_out;
   reg buff_carry_in, buff_carry_out, buff_vld_out;

   assign data_out  = buff_data_out ;
   assign carry_out = buff_carry_out;
   assign vld_out   = buff_vld_out  ;

   always @(posedge clk) begin
      if (reset_n === 0) begin
         buff_carry_in  <= 0;
         buff_op_a      <= 0;
         buff_op_b      <= 0;
         buff_data_out  <= 0;
         buff_carry_out <= 0;
         buff_vld_out   <= 0;
      end
   end

   always @(posedge clk) begin
      if (reset_n === 1) begin
         if (ex) begin
            if (op === 0) begin
               buff_data_out <= buff_op_a - buff_op_b;
               if (buff_op_b > buff_op_a) begin
                  buff_carry_out <= 1;
               end
               else begin
                  buff_carry_out <= 0;
               end
            end
            else begin
               {buff_carry_out, buff_data_out} <= buff_op_a + buff_op_b + buff_carry_in;
            end
            buff_vld_out <= 1;
         end
         else begin
            if (vld_in === 1) begin
               buff_op_a     <= op_a;
               buff_op_b     <= op_b;
               buff_carry_in <= carry_in;
            end
         end
      end
   end

endmodule: fadder_top


`endif // __FADDER_TOP_SV__
