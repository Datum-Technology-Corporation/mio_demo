// Copyright 2023 Acme Enterprises Inc.
// All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_MAPU_TDEFS_SV__
`define __UVMA_MAPU_TDEFS_SV__


typedef enum bit {
   UVMA_MAPU_OP_ADD  = 0,
   UVMA_MAPU_OP_MULT = 1
} uvma_mapu_op_enum;

typedef bit   [(`UVMA_MAPU_MAX_DATA_WIDTH-1):0]  uvma_mapu_data_b_t;
typedef logic [(`UVMA_MAPU_MAX_DATA_WIDTH-1):0]  uvma_mapu_data_l_t;

// Default sequences
typedef class uvma_mapu_mon_vseq_c    ;
typedef class uvma_mapu_idle_vseq_c   ;
typedef class uvma_mapu_drv_in_vseq_c ;
typedef class uvma_mapu_drv_out_vseq_c;

// Forward Type Declarations
typedef class uvma_mapu_cfg_c         ;
typedef class uvma_mapu_cntxt_c       ;
typedef class uvma_mapu_seq_item_c    ;
typedef class uvma_mapu_cp_seq_item_c ;
typedef class uvma_mapu_dpi_seq_item_c;
typedef class uvma_mapu_dpo_seq_item_c;


/**
 * Empty coverage model.
 */
typedef uvmx_agent_cov_model_c #(
   .T_CFG     (uvma_mapu_cfg_c     ),
   .T_CNTXT   (uvma_mapu_cntxt_c   ),
   .T_SEQ_ITEM(uvma_mapu_seq_item_c)
) uvma_mapu_cov_model_c;

/**
 *
 */
typedef uvmx_sqr_c #(
   .T_CFG     (uvma_mapu_cfg_c        ),
   .T_CNTXT   (uvma_mapu_cntxt_c      ),
   .T_SEQ_ITEM(uvma_mapu_cp_seq_item_c)
) uvma_mapu_cp_sqr_c;

/**
 *
 */
typedef uvmx_sqr_c #(
   .T_CFG     (uvma_mapu_cfg_c         ),
   .T_CNTXT   (uvma_mapu_cntxt_c       ),
   .T_SEQ_ITEM(uvma_mapu_dpi_seq_item_c)
) uvma_mapu_dpi_sqr_c;

/**
 *
 */
typedef uvmx_sqr_c #(
   .T_CFG     (uvma_mapu_cfg_c         ),
   .T_CNTXT   (uvma_mapu_cntxt_c       ),
   .T_SEQ_ITEM(uvma_mapu_dpo_seq_item_c)
) uvma_mapu_dpo_sqr_c;


`endif // __UVMA_MAPU_TDEFS_SV__
