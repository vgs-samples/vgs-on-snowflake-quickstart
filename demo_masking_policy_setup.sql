--  this is run for every data classification level that you enter into the data classification table
ALTER TAG VGS_VAULT_TOKENIZER_DEMO.ADMIN.LEVEL_1_TAG SET MASKING POLICY VGS_VAULT_TOKENIZER.ADMIN.VGS_REVEAL_LEVEL_1_MASKING_POLICY;
ALTER TAG VGS_VAULT_TOKENIZER_DEMO.ADMIN.LEVEL_2_TAG SET MASKING POLICY VGS_VAULT_TOKENIZER.ADMIN.VGS_REVEAL_LEVEL_2_MASKING_POLICY;
ALTER TAG VGS_VAULT_TOKENIZER_DEMO.ADMIN.LEVEL_3_TAG SET MASKING POLICY VGS_VAULT_TOKENIZER.ADMIN.VGS_REVEAL_LEVEL_3_MASKING_POLICY;
