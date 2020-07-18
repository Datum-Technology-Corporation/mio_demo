// 
// Copyright 2020 Datum Technology Corporation
// 
// Licensed under the Solderpad Hardware License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     https://solderpad.org/licenses/
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// 


`ifndef __UVMT_PKT_SNF_TB_SV__
`define __UVMT_PKT_SNF_TB_SV__


/**
 * Module encapsulating the Packet Store-and-Forward DUT wrapper, agents and clock
 * generating interfaces. The clock and reset interfaces only feed into the
 * Packet Store-and-Forward and apb interfaces as their
 * clocks and resets, respectively.
 */
module uvmt_pkt_snf_tb;
   
   import uvm_pkg::*;
   import uvmt_pkt_snf_pkg::*;
   
   // Clocking & Reset
   uvmt_pkt_snf_clk_gen_if  clk_gen_if();
   uvma_reset_if  reset_if(.clk(clk_gen_if.reset_clk));
   
   // Agent interfaces
   uvma_apb_if  apb_if(.clk(clk_gen_if.apb_clk), .reset(reset_if.reset));
   
   // DUT instance
   uvmt_pkt_snf_dut_wrap  dut_wrap(.*);
   
   
   /**
    * Test bench entry point.
    */
   initial begin
      // Specify time format for simulation (units_number, precision_number, suffix_string, minimum_field_width)
      $timeformat(-9, 3, " ns", 18);
      
      // Add interfaces to uvm_config_db
      uvm_config_db#(virtual uvmt_pkt_snf_clk_gen_if)::set(null, "*"                , "clk_gen_vif", clk_gen_if);
      uvm_config_db#(virtual uvma_reset_if          )::set(null, "*.env.reset_agent", "vif"        , reset_if  );
      uvm_config_db#(virtual uvma_apb_if            )::set(null, "*.env.apb_agent"  , "vif"        , apb_if    );
      
      // Run test
      uvm_top.enable_print_topology = 1;
      uvm_top.finish_on_completion  = 1;
      uvm_top.run_test();
   end
   
   
   /**
    * End-of-test summary printout.
    */
   final begin
      string             summary_string;
      uvm_report_server  rs;
      int                err_count;
      int                fatal_count;
      static bit         sim_finished = 0;
      
      static string  red   = "\033[31m\033[1m";
      static string  green = "\033[32m\033[1m";
      static string  reset = "\033[0m";
      
      rs          = uvm_top.get_report_server();
      err_count   = rs.get_severity_count(UVM_ERROR);
      fatal_count = rs.get_severity_count(UVM_FATAL);
      
      void'(uvm_config_db#(bit)::get(null, "", "sim_finished", sim_finished));
      
      $display("\n*** Test Summary ***\n");
      
      if (sim_finished && (err_count == 0) && (fatal_count == 0)) begin
         $display("    PPPPPPP    AAAAAA    SSSSSS    SSSSSS   EEEEEEEE  DDDDDDD     ");
         $display("    PP    PP  AA    AA  SS    SS  SS    SS  EE        DD    DD    ");
         $display("    PP    PP  AA    AA  SS        SS        EE        DD    DD    ");
         $display("    PPPPPPP   AAAAAAAA   SSSSSS    SSSSSS   EEEEE     DD    DD    ");
         $display("    PP        AA    AA        SS        SS  EE        DD    DD    ");
         $display("    PP        AA    AA  SS    SS  SS    SS  EE        DD    DD    ");
         $display("    PP        AA    AA   SSSSSS    SSSSSS   EEEEEEEE  DDDDDDD     ");
         $display("    ----------------------------------------------------------");
         $display("                        SIMULATION PASSED                     ");
         $display("    ----------------------------------------------------------");
      end
      else begin
         $display("    FFFFFFFF   AAAAAA   IIIIII  LL        EEEEEEEE  DDDDDDD       ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FFFFF     AAAAAAAA    II    LL        EEEEE     DD    DD      ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FF        AA    AA  IIIIII  LLLLLLLL  EEEEEEEE  DDDDDDD       ");
         
         if (sim_finished == 0) begin
            $display("    --------------------------------------------------------");
            $display("                   SIMULATION FAILED - ABORTED              ");
            $display("    --------------------------------------------------------");
         end
         else begin
            $display("    --------------------------------------------------------");
            $display("                       SIMULATION FAILED                    ");
            $display("    --------------------------------------------------------");
         end
      end
   end
   
endmodule : uvmt_pkt_snf_tb


`endif // __UVMT_PKT_SNF_TB_SV__
