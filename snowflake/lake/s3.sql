
create storage integration :s3_integration
    type = external_stage
    storage_provider = s3
    storage_aws_role_arn = 'arn:aws:iam::606262941110:role/snowflake'
    enabled = true
    storage_allowed_locations = ( '*' )
    -- storage_blocked_locations = ( 's3://<location1>', 's3://<location2>' )
    -- comment = '<comment>'
    ;
DESC INTEGRATION :s3_integration;


CREATE STAGE SNOWFLAKE_LEARNING_DB.public.s3_stage
  STORAGE_INTEGRATION = :s3_integration
  URL = 's3://s3-sg-davidkhala-data/snowflake/'
  ;

-- validate
SHOW STORAGE INTEGRATIONS;

SELECT SYSTEM$VALIDATE_STORAGE_INTEGRATION(
  'S3_INTEGRATION', -- Snowflake will auto uppercase this name
  's3://s3-sg-davidkhala-data/snowflake/',
  'healthcheck',
  'all'
);

-- create a volume
CREATE OR REPLACE VOLUME s3_volume
EXTERNAL_STAGE_TYPE = 'S3'
TYPE = ICEBERG -- ICEBERG table only supported from Snowflake EE
URL = 's3://s3-sg-davidkhala-data/snowflake/'
STORAGE_INTEGRATION = s3_integration;
