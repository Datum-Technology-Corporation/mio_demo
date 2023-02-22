// Copyright 2023 Datum Technology Corporation
// SPDX-License-Identifier: GPL-3.0
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __MAPU_TOP_SV__
`define __MAPU_TOP_SV__


`include "mapu_macros.svh"


/**
 * Matrix APU operating on 3x3 matrices of unsigned integers.
 */
module mapu_top # (
   parameter DATA_WIDTH = 32
) (
   input                      clk    , ///< Clock
   input                      reset_n, ///< Reset
   input                      i_en   , ///< Block enable
   input                      i_op   , ///< Matrix operation to be performed
   output                     o_of   , ///< Overflow indicator
   output                     o_rdy  , ///< Flow control for upstream block
   input                      i_vld  , ///< Indicates data input lines are valid
   input  [(DATA_WIDTH-1):0]  i_r0   , ///< Input row element 0
   input  [(DATA_WIDTH-1):0]  i_r1   , ///< Input row element 1
   input  [(DATA_WIDTH-1):0]  i_r2   , ///< Input row element 2
   input                      i_rdy  , ///< Flow control from downstream block
   output                     o_vld  , ///< Indicates data output lines are valid
   output [(DATA_WIDTH-1):0]  o_r0   , ///< Output row element 0
   output [(DATA_WIDTH-1):0]  o_r1   , ///< Output row element 1
   output [(DATA_WIDTH-1):0]  o_r2     ///< Output row element 2
);

   reg [3:0]               row_idx_i;
   reg [2:0]               row_idx_o;
   reg                     b_o_vld;
   reg                     op;
   reg                     ready_for_op;
   reg [(DATA_WIDTH-1):0]  ma[3][3];
   reg [(DATA_WIDTH-1):0]  mb[3][3];
   reg [(DATA_WIDTH-1):0]  mc[3][3];

   assign o_vld  = b_o_vld;
   assign o_rdy  = (row_idx_i < 6);
   assign o_r0   = mc[row_idx_o][0];
   assign o_r1   = mc[row_idx_o][1];
   assign o_r2   = mc[row_idx_o][2];

   assign o_of = mc[0][0][DATA_WIDTH-1] | mc[0][1][DATA_WIDTH-1] | mc[0][2][DATA_WIDTH-1] |
                 mc[1][0][DATA_WIDTH-1] | mc[1][1][DATA_WIDTH-1] | mc[1][2][DATA_WIDTH-1] |
                 mc[2][0][DATA_WIDTH-1] | mc[2][1][DATA_WIDTH-1] | mc[2][2][DATA_WIDTH-1] ;

   /**
    * Reset
    */
   always @(posedge clk) begin
      if (reset_n === 0) begin
         row_idx_i    <= 0;
         row_idx_o    <= 2;
         b_o_vld      <= 0;
         op           <= 0;
         ready_for_op <= 0;
         clear_memories();
      end
   end

   /**
    * Data In
    */
   always @(posedge clk) begin
      if (reset_n === 1) begin
         load_row();
         if ((row_idx_i == 6) && (row_idx_o == 2)) begin
            ready_for_op <= 1;
            if (i_en === 1) begin
               op <= i_op;
            end
         end
         else if (row_idx_i == 5) begin
            if (i_en === 1) begin
               op <= i_op;
            end
         end
         else begin
            ready_for_op <= 0;
         end
      end
   end

   /**
    * Data Out
    */
   always @(posedge clk) begin
      if (reset_n === 1) begin
         if (i_en === 1) begin
            if ((row_idx_o === 2) && (ready_for_op === 1)) begin
               do_op();
            end
            else if (row_idx_o < 2) begin
               unload_row();
            end
            else begin
               b_o_vld <= 0;
            end
         end
         else begin
            b_o_vld <= 0;
         end
      end
   end

   function void clear_memories();
      foreach (ma[ii]) begin
         foreach (ma[ii][jj]) begin
            ma[ii][jj] <= 0;
         end
      end
      foreach (mb[ii]) begin
         foreach (mb[ii][jj]) begin
            mb[ii][jj] <= 0;
         end
      end
      foreach (mc[ii]) begin
         foreach (mc[ii][jj]) begin
            mc[ii][jj] <= 0;
         end
      end
   endfunction

   function void load_row();
      if (i_vld === 1) begin
         if (row_idx_i < 3) begin
            ma[row_idx_i][0] <= i_r0;
            ma[row_idx_i][1] <= i_r1;
            ma[row_idx_i][2] <= i_r2;
            row_idx_i <= row_idx_i + 1;
         end
         else if (row_idx_i < 6) begin
            mb[row_idx_i-3][0] <= i_r0;
            mb[row_idx_i-3][1] <= i_r1;
            mb[row_idx_i-3][2] <= i_r2;
            row_idx_i <= row_idx_i + 1;
         end
      end
   endfunction

   function void unload_row();
      if (i_rdy === 1) begin
         b_o_vld <= 1;
         row_idx_o <= row_idx_o + 1;
      end
   endfunction

   function void do_op();
      b_o_vld <= 1;
      row_idx_o <= 0;
      case (op)
         `MAPU_OP_ADD : do_add ();
         `MAPU_OP_MULT: do_mult();
      endcase
      row_idx_i <= 0;
   endfunction

   function void do_add();
      mc[0][0] <= ma[0][0] + mb[0][0];
      mc[0][1] <= ma[0][1] + mb[0][1];
      mc[0][2] <= ma[0][2] + mb[0][2];
      mc[1][0] <= ma[1][0] + mb[1][0];
      mc[1][1] <= ma[1][1] + mb[1][1];
      mc[1][2] <= ma[1][2] + mb[1][2];
      mc[2][0] <= ma[2][0] + mb[2][0];
      mc[2][1] <= ma[2][1] + mb[2][1];
      mc[2][2] <= ma[2][2] + mb[2][2];
   endfunction

   function void do_mult();
      mc[0][0] <= (ma[0][0]*mb[0][0])+(ma[0][1]*mb[1][0]+(ma[0][2]*mb[2][0]));
      mc[0][1] <= (ma[0][0]*mb[0][1])+(ma[0][1]*mb[1][1]+(ma[0][2]*mb[2][1]));
      mc[0][2] <= (ma[0][0]*mb[0][2])+(ma[0][1]*mb[1][2]+(ma[0][2]*mb[2][2]));
      mc[1][0] <= (ma[1][0]*mb[0][0])+(ma[1][1]*mb[1][0]+(ma[1][2]*mb[2][0]));
      mc[1][1] <= (ma[1][0]*mb[0][1])+(ma[1][1]*mb[1][1]+(ma[1][2]*mb[2][1]));
      mc[1][2] <= (ma[1][0]*mb[0][2])+(ma[1][1]*mb[1][2]+(ma[1][2]*mb[2][2]));
      mc[2][0] <= (ma[2][0]*mb[0][0])+(ma[2][1]*mb[1][0]+(ma[2][2]*mb[2][0]));
      mc[2][1] <= (ma[2][0]*mb[0][1])+(ma[2][1]*mb[1][1]+(ma[2][2]*mb[2][1]));
      mc[2][2] <= (ma[2][0]*mb[0][2])+(ma[2][1]*mb[1][2]+(ma[2][2]*mb[2][2]));
   endfunction

endmodule: mapu_top


`endif // __MAPU_TOP_SV__
