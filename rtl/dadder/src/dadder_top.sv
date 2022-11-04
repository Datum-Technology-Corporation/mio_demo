// Copyright 2022 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __DADDER_TOP_SV__
`define __DADDER_TOP_SV__


/**
 * Decimal adder/subtracter.
 */
module dadder_top # (
   parameter DATA_WIDTH = 8
) (
   input                      clk     , ///< Clock
   input                      reset_n , ///< Reset
   input                      en      , ///< Block enable
   input                      op      , ///< Operation: '1' is addition and '0' is subtraction
   input                      carry_in, ///< Carry in for additions
   input  [(DATA_WIDTH-1):0]  op_a    , ///< Operand A
   input  [(DATA_WIDTH-1):0]  op_b    , ///< Operand B
   output                     vld_out , ///< Indicates data output lines are valid
   output                     of_out  , ///< Overflow for addition, negative sign for subtraction
   output [(DATA_WIDTH-1):0]  data_out  ///< Result of operation
);

   reg                     b_vld_out, b_of_out;
   reg [(DATA_WIDTH-1):0]  b_data_out;

   assign vld_out  = b_vld_out ;
   assign of_out   = b_of_out  ;
   assign data_out = b_data_out;

   always @(posedge clk) begin
      if (reset_n === 0) begin
         b_vld_out  <= 0;
         b_of_out   <= 0;
         b_data_out <= 0;
      end
   end

   always @(posedge clk) begin
      if (reset_n === 1) begin
         if (en === 1) begin
            if (op === 0) begin
               if (op_b > op_a) begin
                  b_data_out  <= ~(op_a - op_b) + 1;
                  b_of_out <= 1;
               end
               else begin
                  b_data_out  <= ~(op_b - op_a) + 1;
                  b_of_out <= 0;
               end
            end
            else begin
               {b_of_out, b_data_out} <= op_a + op_b + carry_in;
            end
            b_vld_out <= 1;
         end
         else begin
            if (en === 0) begin
               b_vld_out <= 0;
            end
         end
      end
   end

endmodule: dadder_top


`endif // __DADDER_TOP_SV__
