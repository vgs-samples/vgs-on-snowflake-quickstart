<p align="center"><a href="https://www.verygoodsecurity.com/"><img src="https://avatars0.githubusercontent.com/u/17788525" width="128" alt="VGS Logo"></a></p>
<p align="center"><b>vgs-on-snowflake-quickstart</b></p>
<p align="center"><i>Commands and walkthrough for VGS Vault Tokenizer</i></p>

# Instructions for using this Repo
This repo contains Snowflake SQL commands for setting up a demonstration database, roles, and integration with VGS so you can use the VGS Vault Tokenizer. 

## Requirements
- VGS [account](https://dashboard.verygoodsecurity.com/)
- Snowflake [account](https://signup.snowflake.com/) with "Business Critical" configuration running as Account Admin or a role with similar privileges.

# Quickstart

As with any app downloaded from the Snowflake marketplace, it requires a compute warehouse, The examples in this repo use the name ANALYST_WH. But you can use any name you'd like. We do not have minimum requirements for the compute warehouse.

## Download and install the VGS Vault Tokenizer App on your Snowflake account

After you make the  request through the Snowflake App Marketplace, we will contact you and let you know that your VGS Vault Tokenizer application is ready to be installed on your snowflake account. Go to your “Apps” Tab and you will find it in the “Recently shared with you” section of the page. Hit the “Get” button and wait for the application to install.

<p align="center"><a href="https://www.verygoodsecurity.com/"><img src="https://lh6.googleusercontent.com/tcT7pZ7sO0l7anJu08wC4xAVOOEizYx1rJfEmIFo8Vz25JMTkBpkALMBU8IUPK05LT1MySmcBmW0iUJ2TMkNhk2yIJ2uKMaRJl159vj14cpYFX_rmftz1csLB2WvTnEzEPERwhdaRs6j9XCsNsNNlpQ" alt="Snowflake with VGS Vault Tokenizer app tile"></a></p>

Once installed the application will be runnable under the “Installed Apps” section. You will be able to run the application, however you will need to set up your integration with your VGS Vault before you can operate the app.

<p align="center"><a href="https://www.verygoodsecurity.com/"><img src="https://lh5.googleusercontent.com/GVyQRTf8lw_RvDKlHmoM4f3gMAdDO_rVUxB0FZCvxl67viayi74DZ_H7ZCAplCd_Jbhm-q-mzOUjlQqrD2NqWWzQuynl_4qgNm8xBKow9_zhJCX6VAbB__M1Kktq97EKf9DEV22VMCSWp4XtA6WayGk" alt="Snowflake with VGS Vault Tokenizer app installed"></a></p>


## Integrating your VGS Vault with the VGS Vault Tokenizer
You will need to create an integration on your Snowflake account that will allow it to connect to your VGS Vault. You need to enter the following command to create an integration named `VGS_APP_INTEGRATION`.

```sql
CREATE OR REPLACE API INTEGRATION vgs_app_integration
 api_provider = aws_private_api_gateway
 api_aws_role_arn = 'arn:aws:iam::293664699268:role/snowflake-private'
 api_allowed_prefixes = ('https://ys8ux7iwbg.execute-api.us-west-2.amazonaws.com/snowflake/')
 enabled = true;


SELECT SYSTEM$GET_SNOWFLAKE_PLATFORM_INFO();
```
Cut and paste both the outputs in an email to  support@verygoodsecurity.com with the subject line “Enable my VGS vault to use the VGS Vault Tokenizer’’. Once you receive a response you will be able to use the VGS Vault Tokenizer. You can still continue with the setup of the application while you wait.

## Create your Demo Database and data

These commands will create a database named DEMO_DB and add some data to it
```sql
CREATE DATABASE DEMO_DB;


USE DATABASE DEMO_DB;


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
...
   
INSERT INTO AccountSummary (account_nick_name, account_value, asset_manager_id, account_ssn, account_identifier)
VALUES 
   ('JD_Account1', 20000.00, 'AM001', '123-45-6789', 'ACCJD20000'),
   ('JD_Account2', 25000.00, 'AM001', '123-45-6789', 'ACCJD25000'),
   ('JS_Account1', 25000.00, 'AM002', '987-65-4321', 'ACCJS25000'),
   ('JS_Account2', 30000.00, 'AM002', '987-65-4321', 'ACCJS30000'),
   ('CB_Account1', 30000.00, 'AM003', '456-78-9123', 'ACCCB30000'),
...
```
the rest of the insert rows for the demo can be found [here](demo_data_setup.sql)

## Create Some Roles and grant them access
These commands will create some new roles on your snowflake account. Grant access to the new  DEMO_DB you created and to the application.

```sql
 -- Used to create different role levels for data reveal
CREATE ROLE SENIOR_ANALYST;
CREATE ROLE ANALYST;
CREATE ROLE DATA_OWNER;

GRANT USAGE ON DATABASE DEMO_DB TO ROLE SENIOR_ANALYST;
GRANT USAGE ON SCHEMA DEMO_DB.PUBLIC TO ROLE SENIOR_ANALYST;
GRANT SELECT ON ALL TABLES IN SCHEMA DEMO_DB.PUBLIC TO ROLE SENIOR_ANALYST;
GRANT SELECT ON FUTURE TABLES IN SCHEMA DEMO_DB.PUBLIC TO ROLE SENIOR_ANALYST;
GRANT USAGE ON WAREHOUSE ANALYST_WH TO ROLE SENIOR_ANALYST;

GRANT USAGE ON DATABASE DEMO_DB TO ROLE ANALYST;
GRANT USAGE ON SCHEMA DEMO_DB.PUBLIC TO ROLE ANALYST;
GRANT SELECT ON ALL TABLES IN SCHEMA DEMO_DB.PUBLIC TO ROLE ANALYST;
GRANT SELECT ON FUTURE TABLES IN SCHEMA DEMO_DB.PUBLIC TO ROLE ANALYST;
GRANT USAGE ON WAREHOUSE ANALYST_WH TO ROLE ANALYST;

GRANT USAGE ON DATABASE DEMO_DB TO ROLE DATA_OWNER;
GRANT USAGE ON SCHEMA DEMO_DB.PUBLIC TO ROLE DATA_OWNER;
GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB.PUBLIC TO ROLE DATA_OWNER;
GRANT ALL ON FUTURE TABLES IN SCHEMA DEMO_DB.PUBLIC TO ROLE DATA_OWNER;
GRANT USAGE ON WAREHOUSE ANALYST_WH TO ROLE DATA_OWNER;

GRANT APPLICATION ROLE VGS_VAULT_TOKENIZER.VGS_APP_PUBLIC TO ROLE ANALYST;
GRANT APPLICATION ROLE VGS_VAULT_TOKENIZER.VGS_APP_PUBLIC TO ROLE DATA_OWNER;
GRANT APPLICATION ROLE VGS_VAULT_TOKENIZER.VGS_APP_PUBLIC TO ROLE SENIOR_ANALYST;
```