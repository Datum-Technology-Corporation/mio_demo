// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_DP_OUT_IF_SV__
`define __UVMA_DADDER_DP_OUT_IF_SV__


/**
 * Encapsulates all signals and clocking of Decimal adder/subtracter Block Data Plane Output interface.
 * Used by monitor (uvma_dadder_dp_out_mon_c) and driver (uvma_dadder_dp_out_drv_c).
 * Assertions must be captured within uvma_dadder_dp_out_if_chkr.
 * @ingroup uvma_dadder_dp_out_misc
 */
interface uvma_dadder_dp_out_if #(
   parameter DATA_WIDTH = `UVMA_DADDER_DP_OUT_MAX_DATA_WIDTH
) (
   input  clk    ,
   input  reset_n
);

   wire                     vld_out ; ///< Indicates data output lines are valid
   wire                     of_out  ; ///< Overflow for addition, negative sign for subtraction
   wire [(DATA_WIDTH-1):0]  data_out; ///< Result of operation


   /**
    * Used by uvma_dadder_dp_out_drv_c.
    */
   clocking drv_cb @(posedge clk);
   endclocking : drv_cb

   /**
    * Used by uvma_dadder_dp_out_mon_c.
    */
   clocking mon_cb @(posedge clk);
      input vld_out, of_out, data_out;
   endclocking : mon_cb


   /**
    * Used by uvma_dadder_dp_out_drv_c.
    */
   modport drv_mp (
      clocking drv_cb ,
      input    clk    ,
      input    reset_n
   );

   /**
    * Used by uvma_dadder_dp_out_mon_c.
    */
   modport mon_mp (
      clocking mon_cb ,
      input    clk    ,
      input    reset_n
   );

endinterface : uvma_dadder_dp_out_if


`endif // __UVMA_DADDER_DP_OUT_IF_SV__