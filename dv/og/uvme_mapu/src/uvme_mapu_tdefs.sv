// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_MAPU_TDEFS_SV__
`define __UVME_MAPU_TDEFS_SV__


/**
 * Scoreboard specialization for Data Plane Output Monitor Transactions.
 */
typedef uvml_sb_simplex_c #(
   .T_ACT_TRN(uvma_mapu_mon_trn_c)
) uvme_mapu_sb_c;

/**
 * FSM state space for DUT.
 */
typedef enum {
   UVME_MAPU_FSM_INIT ///< State out of reset
} uvme_mapu_fsm_enum;

// Add tdefs, enums and structs here
// Ex: typedef bit [(`UVME_MAPU_ABC_MAX_WIDTH-1):0]  uvme_mapu_abc_b_t;
// Ex: typedef enum {
//        UVME_MAPU_MY_ABC
//     } uvme_mapu_my_enum;
// Ex: typedef struct {
//        bit [2:0]  abc;
//        logic      xyz;
//     } uvme_mapu_my_struct;


`endif // __UVME_MAPU_TDEFS_SV__