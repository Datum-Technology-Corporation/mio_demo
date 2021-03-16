// 
// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// 
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may
// not use this file except in compliance with the License, or, at your option,
// the Apache License version 2.0. You may obtain a copy of the License at
// 
//     https://solderpad.org/licenses/SHL-2.1/
// 
// Unless required by applicable law or agreed to in writing, any work
// distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
// WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
// License for the specific language governing permissions and limitations
// under the License.
// 


`ifndef __UVME_PKT_SNF_RAL_SV__
`define __UVME_PKT_SNF_RAL_SV__


/**
 * Top-level object encapsulating the Moore.io Demo Project Store-and-Forward
 * (SnF) Register Abstraction Layer (RAL).
 */
class uvme_pkt_snf_ral_c extends uvml_ral_reg_block_c;
   
   // Objects
   uvme_pkt_snf_cfg_c    cfg;
   uvme_pkt_snf_cntxt_c  cntxt;
   
   // Sub-Blocks
   // TODO Add sub-block(s)
   //      Ex: rand uvme_pkt_snf_abc_reg_block_c  abc;
   
   // Registers
   // TODO Add register(s)
   //      Ex: rand uvme_pkt_snf_xyz_reg_c  xyz;
   
   
   `uvm_object_utils_begin(uvme_pkt_snf_ral_c)
      // TODO Add field macros for sub-block(s) and register(s)
      //      Ex: `uvm_field_object(abc, UVM_DEFAULT)
      //          `uvm_field_object(xyz, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_pkt_snf_ral", int has_coverage=UVM_NO_COVERAGE);
   
   /**
    * Creates sub-block(s).
    */
   extern virtual function void create_blocks();
   
   /**
    * Creates register(s).
    */
   extern virtual function void create_regs();
   
   /**
    * TODO Describe uvme_pkt_snf_ral_c::create_reg_map()
    */
   extern virtual function void create_reg_map();
   
   /**
    * Adds register(s) to register map.
    */
   extern virtual function void add_regs_to_map();
   
endclass : uvme_pkt_snf_ral_c


function uvme_pkt_snf_ral_c::new(string name="uvme_pkt_snf_ral", int has_coverage=UVM_NO_COVERAGE);
   
   super.new(name, has_coverage);
   
endfunction : new


function void uvme_pkt_snf_ral_c::create_blocks();
   
   // TODO uvme_pkt_snf_ral_c::create_blocks()
   //      Ex: abc = uvme_pkt_snf_abc_reg_block_c::type_id::create("abc");
   //          abc.configure(this);
   //          abc.build();
   
endfunction : create_blocks


function void uvme_pkt_snf_ral_c::create_regs();
   
   // TODO Implement uvme_pkt_snf_ral_c::create_regs()
   //      Ex:  xyz = uvme_pkt_snf_xyz_reg_c::type_id::create("xyz");
   //           xyz.configure(this);
   //           xyz.build();
   
endfunction : create_regs


function void uvme_pkt_snf_ral_c::create_reg_map();
   
   default_map = create_map(
      .name     ("default_map"),
      .base_addr(/*base_address*/0),
      .n_bytes  (uvme_pkt_snf_ral_reg_n_bytes),
      .endian   (UVM_LITTLE_ENDIAN)
   );
   
endfunction : create_reg_map


function void uvme_pkt_snf_ral_c::add_regs_to_map();
   
   // TODO Implement uvme_pkt_snf_ral_c::add_regs_to_map()
   //      Ex: default_map.add_reg(
   //             .rg    (xyz),
   //             .offset(32'h00_00_00_00),
   //             .rights("RW")
   //          );
   
endfunction : add_regs_to_map


`endif // _UVME_PKT_SNF_RAL_SV__
