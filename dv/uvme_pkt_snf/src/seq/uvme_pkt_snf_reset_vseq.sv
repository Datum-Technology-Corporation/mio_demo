// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_PKT_SNF_RESET_VSEQ_SV__
`define __UVME_PKT_SNF_RESET_VSEQ_SV__



/**
 * Virtual sequence responsible for asserting reset with the Packet
 * Store-and-Forward DUT.
 */
class uvme_pkt_snf_reset_vseq_c extends uvme_pkt_snf_base_vseq_c;
   
   // TODO Add reset sequence to uvme_pkt_snf_reset_vseq_c
   //      Ex: rand uvma_reset_simple_seq_c  reset_seq;
   
   `uvm_object_utils_begin(uvme_pkt_snf_reset_vseq_c)
      // TODO Add sub-sequence(s) utility macros
   //      Ex: `uvm_field_object(reset_seq, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   // TODO Add constraint(s) to uvme_pkt_snf_reset_vseq_c
   //      Ex: constraint reset_seq_cons {
   //             reset_seq.abc == 123;
   //          }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_pkt_snf_reset_vseq_c");
   
   /**
    * TODO Describe uvme_pkt_snf_reset_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvme_pkt_snf_reset_vseq_c


function uvme_pkt_snf_reset_vseq_c::new(string name="uvme_pkt_snf_reset_vseq_c");
   
   super.new(name);
   
   // TODO Create sub-sequence(s)
   //      Ex: reset_seq = uvma_reset_simple_seq_c::type_id::create("reset_seq");
   
endfunction : new


task uvme_pkt_snf_reset_vseq_c::body();
   
   // TODO Implement uvme_pkt_snf_reset_vseq_c::body()
   //      Ex: `uvm_do_with(reset_seq, p_sequencer.reset_sequencer)
   
endtask : body


`endif // __UVME_PKT_SNF_RESET_VSEQ_SV__
