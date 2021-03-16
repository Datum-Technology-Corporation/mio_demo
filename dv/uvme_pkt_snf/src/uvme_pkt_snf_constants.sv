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


`ifndef __UVME_PKT_SNF_CONSTANTS_SV__
`define __UVME_PKT_SNF_CONSTANTS_SV__


const int unsigned      uvme_pkt_snf_reset_default_clk_period  = 10_000; // 10ns
const int unsigned      uvme_pkt_snf_apb_default_clk_period    = 10_000; // 10ns
const longint unsigned  uvme_pkt_snf_ral_default_base_address  = 64'h0000_0000_0000_0000;
const int unsigned      uvme_pkt_snf_ral_reg_n_bytes           = 4; // bytes (B)


`endif // __UVME_PKT_SNF_CONSTANTS_SV__
