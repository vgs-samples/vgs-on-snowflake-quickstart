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
## Granting Access to the Application
The application is designed to be configured solely by a user with a higher system role or privileges. The application uses roles based access to reveal the untokenized values for the fields that are tokenized to authorized users, the application will need to be granted access to every database, schema, and table that contains data to be tokenized, and the application needs to be granted access to the integration that you have produced as well as to other areas of snowflake. The installing and configuring  user needs to have the AccountAdmin role.

The following commands set the appropriate level of account access to the application (including to the integration you set up in the previous step)

```sql
-- Enable integration on application
GRANT USAGE ON INTEGRATION VGS_APP_INTEGRATION to application VGS_VAULT_TOKENIZER;
GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE TO APPLICATION VGS_VAULT_TOKENIZER; 

-- Allow the VGS app to execute tasks
-- grants the application the ability to execute its tasks on your account - note - change the name of the WH to whichever one you want the app to run on
GRANT EXECUTE TASK ON ACCOUNT TO APPLICATION VGS_VAULT_TOKENIZER;

GRANT OPERATE ON WAREHOUSE ANALYST_WH TO APPLICATION VGS_VAULT_TOKENIZER;
GRANT USAGE ON WAREHOUSE ANALYST_WH TO APPLICATION VGS_VAULT_TOKENIZER;
GRANT MODIFY ON WAREHOUSE ANALYST_WH TO APPLICATION VGS_VAULT_TOKENIZER;
-- Grant VGS application privileges to table
GRANT ALL PRIVILEGES ON TABLE DEMO_DB.PUBLIC.AccountSummary TO APPLICATION VGS_VAULT_TOKENIZER;
GRANT ALL PRIVILEGES ON TABLE DEMO_DB.PUBLIC.Customers TO APPLICATION VGS_VAULT_TOKENIZER;
ALTER TABLE DEMO_DB.PUBLIC.AccountSummary SET CHANGE_TRACKING = TRUE;
ALTER TABLE DEMO_DB.PUBLIC.Customers SET CHANGE_TRACKING = TRUE;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN schema DEMO_DB.PUBLIC
TO APPLICATION VGS_VAULT_TOKENIZER;
```
## Configure the VGS Vault Tokenizer Connection
To connect with your VGS vault you will need to create a set of credentials ( client id and secret) for the vault you intend to connect to. To do so follow the following steps.

1. Log into your VGS account and navigate to the vault using the organization and vault selector in the top menu. We recommend creating a separate vault for your data warehouse tokenization.

<p align="center"><img src="https://lh5.googleusercontent.com/3VMLDi14IXfFcNLZObosBiCzL3nDxwg6gn4KRD1YnudfEwGkAciOfQFIxjf89Tiyi2IecLN2no4RdEX5wKiMNvAHUbmcWSCwk3Ii17NBk_NCXqXCrLSINzfmJFZNqdtyOsK39dju0A9o-orrwZcLEH8" alt="Snowflake with VGS Vault Tokenizer app installed"></a></p>

2. Using the side menu navigate to “Vault Settings” under the Administration group.

<p align="center"><img src="https://lh3.googleusercontent.com/i2z9Vly-TkwCV2pD_wWBV0s64auAMdom-fDrRV_h2akx9r9AUv6XZkTExGWZysk9KSVT73myCRi9q6HwPXqTNNT6B9gqfDdjdo0yS7A80S98NuudMS4PVCDdRGyrWAHYYZHXd6jLdIXzWRlLdIhKLM4" alt="Snowflake with VGS Vault Tokenizer app installed"></a></p>

3. Next choose “Access Credentials” and then “Generate Credentials”

<p align="center"><img src="https://lh4.googleusercontent.com/eZTp91n9t5ghMsNdmpSkwZiP2jLEvhmUt_IO6m04lHcxPZrHksRCpkCFtQIquZopniJl9UJWj4Kczeaso1btKtl0dxQbK8Ajb4LVKf_SfbMMuyyfSI7xwbbV17BaYhfzhc_I9_BTrlDMMP1InB6Z4J8" alt="Snowflake with VGS Vault Tokenizer app installed"></a></p>

4. Copy down your Username and Password (client id and secret). You will use these credentials in your VGS Vault Tokenizer app in Snowflake.

<p align="center"><img src="https://lh3.googleusercontent.com/h-BFFVXqHbiWz9fi-IIlJ2u5nSIZblnOBuXLdNIK13Be6t6-OhtTF9yXsFd2CNBCJvwKGkMALbzx3iCkGsx2F2cEQk2QMzvfjyO14TSvpWH0fBfcOd78zDGWcApA1njaGx6KBcITuU90NIBigFEIoAk" alt="Snowflake with VGS Vault Tokenizer app installed"></a></p>

5. You will also need your organization and vault ids. You can get your org id by selecting your org from the top and then clicking “Manage”

<p align="center"><img src="https://lh3.googleusercontent.com/_GrTl0GUJIXIXQP9iEfvnjlYf9g52qsDx1OFh7azEB_OImACSu5jkw9RR7gN16OO_vBvbas9Y5PvO1KbUNTg9pjoQVf8uOoCzOkgtBE7LQyOGsJcjgOCOtc9KLXM8Qvnnz-ifytc1RQtVOl_uM7VSTA" alt="Snowflake with VGS Vault Tokenizer app installed"></a></p>

6. Your vault id is located in the upper left corner of the side menu.
<p align="center"><img src="https://lh4.googleusercontent.com/NKqeGVzrrL9QMan3tX8O4rs-qyRhHwN1qq1L-T612FwHje07KtRT0lDKU6uP7tGs4aWyvDd_-YXps8dNJTjOVDETc8a70U_YfRE0qbTY8NZ-ATdxLhWDe0nV6T3En9-2GHxHkXSq4EgyGudGOUEU3os" alt="Snowflake with VGS Vault Tokenizer app installed"></a></p>

7. Start the VGS Vault Tokenizer in Snowflake the opening screen and enter the corresponding values (note: ClientID and Secret are the same as Username and Password from vault credentials respectively) and hit Connect.
<p align="center"><img src="https://lh5.googleusercontent.com/7OibGQ6KwiVup0Ss0E66NcTYwwDVbQF7ztuB7APm8SYZpBsnCwk3ERIjg2TEmxbmYvW8yzMEJ9Ul9dUgvnYykRMRLQJ1y8MxA7tS1RDDBgIfw6CY8Dyd3YRuu-yVO-nFhqNAa2OwBEjl1nIZ3nWL5Wg" alt="Snowflake with VGS Vault Tokenizer app installed"></a></p>

