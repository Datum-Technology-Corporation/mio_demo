// Copyright 2022 Contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DADDER_TDEFS_SV__
`define __UVME_DADDER_TDEFS_SV__


// Scoreboard specialization
typedef uvml_sb_simplex_c #(
   .T_ACT_TRN(uvma_dadder_dp_out_mon_trn_c)
) uvme_dadder_sb_simplex_c;

// Add tdefs, enums and structs here
// Ex: typedef bit [(`UVME_DADDER_ABC_MAX_WIDTH-1):0]  uvme_dadder_abc_b_t;
// Ex: typedef enum {
//        UVME_DADDER_MY_ABC
//     } uvme_dadder_my_enum;
// Ex: typedef struct {
//        bit [2:0]  abc;
//        logic      xyz;
//     } uvme_dadder_my_struct;


`endif // __UVME_DADDER_TDEFS_SV__