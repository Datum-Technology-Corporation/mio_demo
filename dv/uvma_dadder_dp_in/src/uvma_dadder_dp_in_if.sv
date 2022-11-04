// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_DADDER_DP_IN_IF_SV__
`define __UVMA_DADDER_DP_IN_IF_SV__


/**
 * Encapsulates all signals and clocking of Decimal adder/subtracter Block Data Plane Input interface.
 * Used by monitor (uvma_dadder_dp_in_mon_c) and driver (uvma_dadder_dp_in_drv_c).
 * Assertions must be captured within uvma_dadder_dp_in_if_chkr.
 * @ingroup uvma_dadder_dp_in_misc
 */
interface uvma_dadder_dp_in_if #(
   parameter DATA_WIDTH = `UVMA_DADDER_DP_IN_MAX_DATA_WIDTH
) (
   input  clk    ,
   input  reset_n
);

   wire                     carry_in; ///< Carry in for additions
   wire [(DATA_WIDTH-1):0]  op_a    ; ///< Operand A
   wire [(DATA_WIDTH-1):0]  op_b    ; ///< Operand B


   /**
    * Used by uvma_dadder_dp_in_drv_c.
    */
   clocking drv_cb @(posedge clk);
      output carry_in, op_a, op_b;
   endclocking : drv_cb

   /**
    * Used by uvma_dadder_dp_in_mon_c.
    */
   clocking mon_cb @(posedge clk);
      input carry_in, op_a, op_b;
   endclocking : mon_cb


   /**
    * Used by uvma_dadder_dp_in_drv_c.
    */
   modport drv_mp (
      clocking drv_cb ,
      input    clk    ,
      input    reset_n
   );

   /**
    * Used by uvma_dadder_dp_in_mon_c.
    */
   modport mon_mp (
      clocking mon_cb ,
      input    clk    ,
      input    reset_n
   );

endinterface : uvma_dadder_dp_in_if


`endif // __UVMA_DADDER_DP_IN_IF_SV__