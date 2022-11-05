// Copyright 2022 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __MAPU_TOP_SV__
`define __MAPU_TOP_SV__


`include "mapu_macros.svh"
`include "mapu_tdefs.sv"


/**
 * Matrix APU operating on 4x4 matrices of unsigned integers.
 */
module mapu_top # (
   parameter DATA_WIDTH = 8
) (
   input                      clk     , ///< Clock
   input                      reset_n , ///< Reset
   input                      i_en    , ///< Block enable
   input  [1:0]               i_op    , ///< Matrix operation to be performed
   input  [(DATA_WIDTH-1):0]  i_r0    , ///< Input row element 0
   input  [(DATA_WIDTH-1):0]  i_r1    , ///< Input row element 1
   input  [(DATA_WIDTH-1):0]  i_r2    , ///< Input row element 2
   input  [(DATA_WIDTH-1):0]  i_r3    , ///< Input row element 3
   output                     o_vld   , ///< Indicates data output lines are valid
   output [(DATA_WIDTH-1):0]  o_r0    , ///< Output row element 0
   output [(DATA_WIDTH-1):0]  o_r1    , ///< Output row element 1
   output [(DATA_WIDTH-1):0]  o_r2    , ///< Output row element 2
   output [(DATA_WIDTH-1):0]  o_r3      ///< Output row element 3
);

   mapu_state_enum               state;
   reg [2:0]                     row_count;
   reg                           b_o_vld;
   reg [(DATA_WIDTH-1):0]        b_o_r0, b_o_r1, b_o_r2, b_o_r3;
   reg [(DATA_WIDTH-1):0][4][4]  ma, mb, mc;

   assign o_vld  = b_o_vld;
   assign o_r0   = b_o_r0 ;
   assign o_r1   = b_o_r1 ;
   assign o_r2   = b_o_r2 ;
   assign o_r3   = b_o_r3 ;

   always @(posedge clk) begin
      if (reset_n === 0) begin
         state     <= MAPU_STATE_LOADING;
         row_count <= 0;
         b_o_vld   <= 0;
         b_o_r0    <= 0;
         b_o_r1    <= 0;
         b_o_r2    <= 0;
         b_o_r3    <= 0;
         clear_matrices();
      end
   end

   always @(posedge clk) begin
      if (reset_n === 1) begin
         case (state)
            MAPU_STATE_LOADING  : fsm_loading  ();
            MAPU_STATE_LOADED   : fsm_loaded   ();
            MAPU_STATE_UNLOADING: fsm_unloading();
            MAPU_STATE_DONE     : fsm_done     ();
         endcase
      end
   end

   function void clear_matrices();
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
   endfunction : clear_matrices

   function void fsm_loading();
      if (en === 1) begin
         if (row_count < 3) begin
            ma[row_count][0] <= i_r0;
            ma[row_count][1] <= i_r1;
            ma[row_count][2] <= i_r2;
            ma[row_count][3] <= i_r3;
         end
         else begin
            mb[row_count][0] <= i_r0;
            mb[row_count][1] <= i_r1;
            mb[row_count][2] <= i_r2;
            mb[row_count][3] <= i_r3;
         end

         row_count <= row_count + 1;
         if (row_count == (7-1)) begin
            state <= MAPU_STATE_LOADED;
         end
      end
      b_o_vld <= 0;
   endfunction : fsm_init

   function void fsm_loaded();
      if (en === 1) begin
         case (op)
            `MAPU_OP_ADD : do_add ();
            `MAPU_OP_SUB : do_sub ();
            `MAPU_OP_MULT: do_mult();
         endcase
         state     <= MAPU_STATE_UNLOADING;
         row_count <= 3;
         b_o_vld   <= 1;
      end
      else begin
         b_o_vld <= 0;
      end
   endfunction : fsm_loaded

   function void fsm_unloading();
      if (en) begin
         b_o_vld <= 1;
         b_o_r0  <= mc[row_count][0];
         b_o_r1  <= mc[row_count][1];
         b_o_r2  <= mc[row_count][2];
         b_o_r3  <= mc[row_count][3];
         row_count <= row_count - 1;
         if (row_count == 1) begin
            state <= MAPU_STATE_DONE;
         end
      end
      else begin
         b_o_vld <= 0;
      end
   endfunction : fsm_unloading

   function void fsm_done();
      clear_matrices();
      state   <= MAPU_STATE_LOADING;
      b_o_vld <= 0;
      b_o_r0  <= 0;
      b_o_r1  <= 0;
      b_o_r2  <= 0;
   endfunction : fsm_done

   function void do_add();
      mc[0][0] <= ma[0][0] + mb[0][0];
      mc[0][1] <= ma[0][1] + mb[0][1];
      mc[0][2] <= ma[0][2] + mb[0][2];
      mc[0][3] <= ma[0][3] + mb[0][3];
      mc[1][0] <= ma[1][0] + mb[1][0];
      mc[1][1] <= ma[1][1] + mb[1][1];
      mc[1][2] <= ma[1][2] + mb[1][2];
      mc[1][3] <= ma[1][3] + mb[1][3];
      mc[2][0] <= ma[2][0] + mb[2][0];
      mc[2][1] <= ma[2][1] + mb[2][1];
      mc[2][2] <= ma[2][2] + mb[2][2];
      mc[2][3] <= ma[2][3] + mb[2][3];
      mc[3][0] <= ma[3][0] + mb[3][0];
      mc[3][1] <= ma[3][1] + mb[3][1];
      mc[3][2] <= ma[3][2] + mb[3][2];
      mc[3][3] <= ma[3][3] + mb[3][3];
   endfunction : do_add

   function void do_sub();
      mc[0][0] <= ma[0][0] - mb[0][0];
      mc[0][1] <= ma[0][1] - mb[0][1];
      mc[0][2] <= ma[0][2] - mb[0][2];
      mc[0][3] <= ma[0][3] - mb[0][3];
      mc[1][0] <= ma[1][0] - mb[1][0];
      mc[1][1] <= ma[1][1] - mb[1][1];
      mc[1][2] <= ma[1][2] - mb[1][2];
      mc[1][3] <= ma[1][3] - mb[1][3];
      mc[2][0] <= ma[2][0] - mb[2][0];
      mc[2][1] <= ma[2][1] - mb[2][1];
      mc[2][2] <= ma[2][2] - mb[2][2];
      mc[2][3] <= ma[2][3] - mb[2][3];
      mc[3][0] <= ma[3][0] - mb[3][0];
      mc[3][1] <= ma[3][1] - mb[3][1];
      mc[3][2] <= ma[3][2] - mb[3][2];
      mc[3][3] <= ma[3][3] - mb[3][3];
   endfunction : do_sub

   function void do_mult();
      mc[0][0] <= (ma[0][0]*mb[0][0])+(ma[0][1]*mb[0][1]+(ma[0][2]*mb[0][2])+(ma[0][3]*mb[0][3]));
      mc[0][1] <= (ma[0][0]*mb[1][0])+(ma[0][1]*mb[1][1]+(ma[0][2]*mb[1][2])+(ma[0][3]*mb[1][3]));
      mc[0][2] <= (ma[0][0]*mb[2][0])+(ma[0][1]*mb[2][1]+(ma[0][2]*mb[2][2])+(ma[0][3]*mb[2][3]));
      mc[0][3] <= (ma[0][0]*mb[3][0])+(ma[0][1]*mb[3][1]+(ma[0][2]*mb[3][2])+(ma[0][3]*mb[3][3]));
      mc[1][0] <= (ma[1][0]*mb[0][0])+(ma[1][1]*mb[0][1]+(ma[1][2]*mb[0][2])+(ma[1][3]*mb[0][3]));
      mc[1][1] <= (ma[1][0]*mb[1][0])+(ma[1][1]*mb[1][1]+(ma[1][2]*mb[1][2])+(ma[1][3]*mb[1][3]));
      mc[1][2] <= (ma[1][0]*mb[2][0])+(ma[1][1]*mb[2][1]+(ma[1][2]*mb[2][2])+(ma[1][3]*mb[2][3]));
      mc[1][3] <= (ma[1][0]*mb[3][0])+(ma[1][1]*mb[3][1]+(ma[1][2]*mb[3][2])+(ma[1][3]*mb[3][3]));
      mc[2][0] <= (ma[2][0]*mb[0][0])+(ma[2][1]*mb[0][1]+(ma[2][2]*mb[0][2])+(ma[2][3]*mb[0][3]));
      mc[2][1] <= (ma[2][0]*mb[1][0])+(ma[2][1]*mb[1][1]+(ma[2][2]*mb[1][2])+(ma[2][3]*mb[1][3]));
      mc[2][2] <= (ma[2][0]*mb[2][0])+(ma[2][1]*mb[2][1]+(ma[2][2]*mb[2][2])+(ma[2][3]*mb[2][3]));
      mc[2][3] <= (ma[2][0]*mb[3][0])+(ma[2][1]*mb[3][1]+(ma[2][2]*mb[3][2])+(ma[2][3]*mb[3][3]));
      mc[3][0] <= (ma[3][0]*mb[0][0])+(ma[3][1]*mb[0][1]+(ma[3][2]*mb[0][2])+(ma[3][3]*mb[0][3]));
      mc[3][1] <= (ma[3][0]*mb[1][0])+(ma[3][1]*mb[1][1]+(ma[3][2]*mb[1][2])+(ma[3][3]*mb[1][3]));
      mc[3][2] <= (ma[3][0]*mb[2][0])+(ma[3][1]*mb[2][1]+(ma[3][2]*mb[2][2])+(ma[3][3]*mb[2][3]));
      mc[3][3] <= (ma[3][0]*mb[3][0])+(ma[3][1]*mb[3][1]+(ma[3][2]*mb[3][2])+(ma[3][3]*mb[3][3]));
   endfunction : do_mult

endmodule: mapu_top


`endif // __MAPU_TOP_SV__
