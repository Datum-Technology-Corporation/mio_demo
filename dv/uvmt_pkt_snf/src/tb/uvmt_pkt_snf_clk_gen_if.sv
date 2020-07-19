// 
// Copyright 2020 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// 
// Licensed under the Solderpad Hardware License v 2.1 (the “License”); you may
// not use this file except in compliance with the License, or, at your option,
// the Apache License version 2.0. You may obtain a copy of the License at
// 
//     https://solderpad.org/licenses/SHL-2.1/
// 
// Unless required by applicable law or agreed to in writing, any work
// distributed under the License is distributed on an “AS IS” BASIS, WITHOUT
// WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
// License for the specific language governing permissions and limitations
// under the License.
// 

`ifndef __UVMT_PKT_SNF_CLK_GEN_IF_SV__
`define __UVMT_PKT_SNF_CLK_GEN_IF_SV__


/**
 * Interface providing clock signals to all other interfaces used by Packet Store-and-Forward
 * test bench (uvmt_pkt_snf_tb). Managed by test cases.
 */
interface uvmt_pkt_snf_clk_gen_if;
   
   import uvme_pkt_snf_pkg::*;
   
   
   bit       start_clk = 0;
   logic     reset_clk        = 0;
   realtime  reset_clk_period = uvme_pkt_snf_reset_default_clk_period * 1ps;
   logic     apb_clk        = 0;
   realtime  apb_clk_period = uvme_pkt_snf_apb_default_clk_period * 1ps;
   
   
   /**
    * Generates clock signals.
    */
   initial begin
      wait (start_clk);
      fork
         forever begin
            #(reset_clk_period/2) reset_clk = ~reset_clk;
         end
         forever begin
            #(apb_clk_period/2) apb_clk = ~apb_clk;
         end
      join_none
   end
   
   /**
    * Sets clock period in ps.
    */
   function void set_clk_periods(
      real reset_period,
      real apb_period
   );
      reset_clk_period = reset_period * 1ps;
      apb_clk_period = apb_period * 1ps;
   endfunction : set_clk_periods
   
   /**
    * Triggers the generation of clk.
    */
   function void start();
      start_clk = 1;
   endfunction : start
   
endinterface : uvmt_pkt_snf_clk_gen_if


`endif // __UVMT_PKT_SNF_CLK_GEN_IF_SV__
