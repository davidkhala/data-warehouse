
-- Enable Cortex for cross-region access
-- https://docs.snowflake.com/en/user-guide/snowflake-cortex/cross-region-inference
ALTER ACCOUNT SET CORTEX_ENABLED_CROSS_REGION = 'ANY_REGION';