-- Enable integration on application
GRANT USAGE ON INTEGRATION VGS_APP_INTEGRATION to application VGS_VAULT_TOKENIZER;
GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE TO APPLICATION VGS_VAULT_TOKENIZER; 

-- These two, we have to change the database name
GRANT USAGE ON DATABASE DEMO_DB TO APPLICATION VGS_VAULT_TOKENIZER;
GRANT MODIFY ON DATABASE DEMO_DB TO APPLICATION VGS_VAULT_TOKENIZER;

-- These two, we have to change the schema name
GRANT USAGE ON SCHEMA DEMO_DB.PUBLIC TO APPLICATION VGS_VAULT_TOKENIZER;
GRANT MODIFY ON SCHEMA DEMO_DB.PUBLIC TO APPLICATION VGS_VAULT_TOKENIZER;

-- We need a warehouse to exist and all permissions on them to use tasks.
GRANT OPERATE ON WAREHOUSE ANALYST_WH TO APPLICATION VGS_VAULT_TOKENIZER;
GRANT USAGE ON WAREHOUSE ANALYST_WH TO APPLICATION VGS_VAULT_TOKENIZER;
GRANT MODIFY ON WAREHOUSE ANALYST_WH TO APPLICATION VGS_VAULT_TOKENIZER;

-- Allow the VGS app to execute tasks
GRANT EXECUTE TASK ON ACCOUNT TO APPLICATION VGS_VAULT_TOKENIZER;

CREATE or replace TABLE Customers (
    name STRING,
    SSN STRING,
    drivers_license_number STRING,
    email_address STRING,
    customer_identifier STRING PRIMARY KEY
);

CREATE OR REPLACE TABLE AccountSummary (
    account_nick_name STRING,
    account_value FLOAT,
    asset_manager_id STRING,
    account_ssn STRING,
    account_identifier STRING PRIMARY KEY
);

INSERT INTO Customers (name, SSN, drivers_license_number, email_address, customer_identifier) 
VALUES 
    ('John Doe', '123-45-6789', 'D123456', 'johndoe@email.com', 'JD12345678'), 
    ('Jane Smith', '987-65-4321', 'D987654', 'janesmith@email.com', 'JS98765432'), 
    ('Carlos Baker', '456-78-9123', 'D456789', 'carlosbaker@email.com', 'CB45678912'), 
    ('Emma Davis', '111-22-3333', 'D111222', 'emmadavis@email.com', 'ED11122333'), 
    ('Oliver Miller', '444-55-6666', 'D444556', 'olivermiller@email.com', 'OM44455666'), 
    ('Alice Thompson', '777-88-9999', 'D777889', 'alicethompson@email.com', 'AT77788999'), 
    ('William Adams', '123-32-2123', 'D123322', 'williamadams@email.com', 'WA12332212'), 
    ('Sophie Turner', '456-45-3434', 'D456453', 'sophieturner@email.com', 'ST45645343'), 
    ('Joseph Johnson', '789-56-4545', 'D789564', 'josephjohnson@email.com', 'JJ78956454'), 
    ('Mia Williams', '321-67-5656', 'D321675', 'miawilliams@email.com', 'MW32167565'), 
    ('Lucas Harris', '654-78-6767', 'D654786', 'lucasharris@email.com', 'LH65478676'), 
    ('Harper Thomas', '987-89-7878', 'D987897', 'harperthomas@email.com', 'HT98789787'), 
    ('Mason Moore', '345-90-9090', 'D345909', 'masonmoore@email.com', 'MM34590909'), 
    ('Ella Garcia', '234-01-1111', 'D234011', 'ellagarcia@email.com', 'EG23401111'), 
    ('Benjamin Clark', '567-12-2222', 'D567122', 'benjaminclark@email.com', 'BC56712222'), 
    ('Carter Rodriguez', '678-23-3333', 'D678233', 'carterrodriguez@email.com', 'CR67823333'), 
    ('Liam Walker', '789-34-4444', 'D789344', 'liamwalker@email.com', 'LW78934444'), 
    ('Chloe Harris', '890-45-5555', 'D890455', 'chloeharris@email.com', 'CH89045555'), 
    ('Aiden Anderson', '901-56-6666', 'D901566', 'aidenanderson@email.com', 'AA90156666'), 
    ('Harper Anderson', '012-67-7777', 'D012677', 'harperanderson@email.com', 'HA01267777');
    
INSERT INTO AccountSummary (account_nick_name, account_value, asset_manager_id, account_ssn, account_identifier) 
VALUES 
    ('JD_Account1', 20000.00, 'AM001', '123-45-6789', 'ACCJD20000'), 
    ('JD_Account2', 25000.00, 'AM001', '123-45-6789', 'ACCJD25000'), 
    ('JS_Account1', 25000.00, 'AM002', '987-65-4321', 'ACCJS25000'), 
    ('JS_Account2', 30000.00, 'AM002', '987-65-4321', 'ACCJS30000'), 
    ('CB_Account1', 30000.00, 'AM003', '456-78-9123', 'ACCCB30000'), 
    ('CB_Account2', 35000.00, 'AM003', '456-78-9123', 'ACCCB35000'), 
    ('ED_Account1', 35000.00, 'AM004', '111-22-3333', 'ACCED35000'), 
    ('ED_Account2', 20000.00, 'AM004', '111-22-3333', 'ACCED20000'), 
    ('OM_Account1', 25000.00, 'AM005', '444-55-6666', 'ACCOM25000'), 
    ('OM_Account2', 30000.00, 'AM005', '444-55-6666', 'ACCOM30000'), 
    ('AT_Account1', 20000.00, 'AM006', '777-88-9999', 'ACCAT20000'), 
    ('AT_Account2', 25000.00, 'AM006', '777-88-9999', 'ACCAT25000'),
    ('WA_Account1', 30000.00, 'AM007', '123-32-2123', 'ACCWA30000'),
    ('WA_Account2', 35000.00, 'AM007', '123-32-2123', 'ACCWA35000'),
    ('ST_Account1', 35000.00, 'AM008', '456-45-3434', 'ACCST35000'),
    ('ST_Account2', 20000.00, 'AM008', '456-45-3434', 'ACCST20000'),
    ('JJ_Account1', 20000.00, 'AM009', '789-56-4545', 'ACCJJ20000'),
    ('JJ_Account2', 25000.00, 'AM009', '789-56-4545', 'ACCJJ25000'),
    ('MW_Account1', 25000.00, 'AM010', '321-67-5656', 'ACCMW25000'),
    ('MW_Account2', 30000.00, 'AM010', '321-67-5656', 'ACCMW30000'),
    ('LH_Account1', 30000.00, 'AM011', '654-78-6767', 'ACCLH30000'),
    ('LH_Account2', 35000.00, 'AM011', '654-78-6767', 'ACCLH35000'),
    ('HT_Account1', 35000.00, 'AM012', '987-89-7878', 'ACCHT35000'),
    ('HT_Account2', 20000.00, 'AM012', '987-89-7878', 'ACCHT20000'),
    ('MM_Account1', 20000.00, 'AM013', '345-90-9090', 'ACCMM20000'),
    ('MM_Account2', 25000.00, 'AM013', '345-90-9090', 'ACCMM25000'),
    ('EG_Account1', 25000.00, 'AM014', '234-01-1111', 'ACCEG25000'),
    ('EG_Account2', 30000.00, 'AM014', '234-01-1111', 'ACCEG30000'),
    ('BC_Account1', 30000.00, 'AM015', '567-12-2222', 'ACCBC30000'),
    ('BC_Account2', 35000.00, 'AM015', '567-12-2222', 'ACCBC35000'),
    ('CR_Account1', 35000.00, 'AM016', '678-23-3333', 'ACCCR35000'),
    ('CR_Account2', 20000.00, 'AM016', '678-23-3333', 'ACCCR20000'),
    ('LW_Account1', 20000.00, 'AM017', '789-34-4444', 'ACCLW20000'),
    ('LW_Account2', 25000.00, 'AM017', '789-34-4444', 'ACCLW25000'),
    ('CH_Account1', 25000.00, 'AM018', '890-45-5555', 'ACCCH25000'),
    ('CH_Account2', 30000.00, 'AM018', '890-45-5555', 'ACCCH30000'),
    ('AA_Account1', 30000.00, 'AM019', '901-56-6666', 'ACCAA30000'),
    ('AA_Account2', 35000.00, 'AM019', '901-56-6666', 'ACCAA35000'),
    ('HA_Account1', 35000.00, 'AM020', '012-67-7777', 'ACCHA35000'),
    ('HA_Account2', 20000.00, 'AM020', '012-67-7777', 'ACCHA20000');

-- Grant VGS application privileges to table
GRANT ALL PRIVILEGES ON TABLE DEMO_DB.PUBLIC.AccountSummary TO APPLICATION VGS_VAULT_TOKENIZER;
GRANT ALL PRIVILEGES ON TABLE DEMO_DB.PUBLIC.Customers TO APPLICATION VGS_VAULT_TOKENIZER;
ALTER TABLE DEMO_DB.PUBLIC.AccountSummary SET CHANGE_TRACKING = TRUE;
ALTER TABLE DEMO_DB.PUBLIC.Customers SET CHANGE_TRACKING = TRUE;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN schema DEMO_DB.PUBLIC
TO APPLICATION VGS_VAULT_TOKENIZER;

-- Set up required tags on table so that the "reveal" functionality is allowed for privileged users.
ALTER TABLE DEMO_DB.public.Customers MODIFY COLUMN SSN SET TAG VGS_VAULT_TOKENIZER.admin.LEVEL_1_TAG = 'LEVEL_1';
ALTER TABLE DEMO_DB.public.Customers MODIFY COLUMN drivers_license_number SET TAG VGS_VAULT_TOKENIZER.admin.LEVEL_1_TAG = 'LEVEL_1';
ALTER TABLE DEMO_DB.public.Customers MODIFY COLUMN email_address SET TAG VGS_VAULT_TOKENIZER.admin.LEVEL_2_TAG = 'LEVEL_2';
ALTER TABLE DEMO_DB.public.AccountSummary MODIFY COLUMN account_ssn SET TAG VGS_VAULT_TOKENIZER.admin.LEVEL_1_TAG = 'LEVEL_1';
