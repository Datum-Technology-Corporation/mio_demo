// Copyright 2022 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __MAPU_TDEFS_SV__
`define __MAPU_TDEFS_SV__


typedef enum logic [1:0] {
   MAPU_STATE_LOADING   = 2'b00,
   MAPU_STATE_LOADED    = 2'b01,
   MAPU_STATE_UNLOADING = 2'b10,
   MAPU_STATE_DONE      = 2'b11
} mapu_state_enum;


`endif // __MAPU_TDEFS_SV__
