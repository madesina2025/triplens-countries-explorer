
import snowflake.connector
from .config import url_endpoint, access_key, secret_key
from dotenv import load_dotenv
import boto3
import os   


ctx = snowflake.connector.connect(
    user=os.getenv("SNOWFLAKE_USER"),
    password=os.getenv("SNOWFLAKE_PASSWORD"),
    account=os.getenv("SNOWFLAKE_ACCOUNT"),
    warehouse='COMPUTE_WH',
    database='TRIPLENS',
    schema='RAW'
)

cs = ctx.cursor()

client = boto3.client(
      's3',
      endpoint_url=url_endpoint, # MinIO endpoint
      aws_access_key_id=access_key, # Minio access key
      aws_secret_access_key=secret_key, # Minio secret key
      config=boto3.session.Config(signature_version='s3v4'),
      verify=False # Set to False if using HTTP
    )


def transfer_minio_json_to_snowflake(bucket: str, file_key: str, target_table: str) -> None:

    # Keep just the filename for the local temp path (avoid nested dirs under /tmp)
    filename = os.path.basename(file_key)
    local_temp_path = f"/tmp/{filename}"

    # Download from MinIO -> local temp storage
    client.download_file(bucket, file_key, local_temp_path)

    try:
        # Create file format + internal stage
        cs.execute("USE SCHEMA TRIPLENS.RAW")
        cs.execute("CREATE OR REPLACE FILE FORMAT TRIPLENS.RAW.JSON_FF TYPE = JSON;")
        cs.execute("CREATE OR REPLACE STAGE TRIPLENS.RAW.TRIPLENS_INT_STAGE FILE_FORMAT = TRIPLENS.RAW.JSON_FF;")

        cs.execute("""
            CREATE OR REPLACE TABLE TRIPLENS.RAW.COUNTRIES_RAW (
                ingestion_ts TIMESTAMP_NTZ,
                src_file STRING,
                payload VARIANT
            );
        """)
        # PUT the local file into the Snowflake internal stage
        # AUTO_COMPRESS can be TRUE (Snowflake will gzip it automatically)
        # cs.execute(f"PUT file://{local_temp_path} @TRIPLENS_STAGE AUTO_COMPRESS=TRUE OVERWRITE=TRUE")
        cs.execute(f"PUT file://{local_temp_path} @TRIPLENS_INT_STAGE AUTO_COMPRESS=TRUE OVERWRITE=TRUE")

        # COPY JSON from stage into target table
        # Loads JSON into a VARIANT column via $1; also captures filename + ingestion time
        #cs.execute(f"TRUNCATE TABLE {target_table};")
        cs.execute(f"""
            COPY INTO {target_table} (ingestion_ts, src_file, payload)
            FROM (
              SELECT CURRENT_TIMESTAMP(), METADATA$FILENAME, $1
              FROM @TRIPLENS_INT_STAGE
            )
            FILE_FORMAT = (TYPE = JSON)
            ON_ERROR = 'ABORT_STATEMENT'
        """)

        print(f"Successfully loaded {file_key} into {target_table}")

    finally:
        # Cleanup local file
        if os.path.exists(local_temp_path):
            os.remove(local_temp_path)





















# import snowflake.connector
# import boto3
# import os
# from include.api.config import url_endpoint, access_key, secret_key
# from botocore.config import Config
# from pathlib import Path
# from dotenv import load_dotenv
# load_dotenv(dotenv_path=Path(__file__).resolve().parents[2] / ".env", override=True)

# # conn = snowflake.connector.connect( 
# #     user='xxx',
# #     password='xxx',  
# #     account='xxx',  
# #     warehouse='COMPUTE_WH', 
# #     database='TRIPLENS',
# #     schema='TRIPLENS.RAW'
# # )

# load_dotenv()

# ctx = snowflake.connector.connect(
#     user=os.getenv("SNOWFLAKE_USER"),
#     password=os.getenv("SNOWFLAKE_PASSWORD"),
#     account=os.getenv("SNOWFLAKE_ACCOUNT"),
#     warehouse="COMPUTE_WH",
#     database="TRIPLENS",
#     schema="TRIPLENS.RAW"
# )

# cs = ctx.cursor()

# s3_config = Config(
#     signature_version="s3v4",
#     s3={"addressing_style": "path"},
# )

# client = boto3.client(
#     "s3",
#     endpoint_url=url_endpoint,
#     aws_access_key_id=access_key,          # ✅ correct
#     aws_secret_access_key=secret_key,      # ✅ correct
#     config=s3_config,                      # ✅ correct (not boto3.session.config)
#     region_name="us-east-1",
#     verify=False # set to off if using HTT
# )

# SNOWFLAKE_OONN_ID="snowflake_conn"
# STAGE="TRIPLENS.RAW.TRIPLENS_INT_STAGE"
# TABLE="TRIPLENS.RAW.COUNTRIES_RAW"


# def transfer_data_to_snowflakes(bucket, file_key,   target_table):
#     filename=os.path(file_key)
#     local_temp_path = f'/tmp/{filename}'

#     client.download(bucket, file_key, local_temp_path)

#     try:
#         cs.execute("USE SCHEMA TRIPLENS.RAW")
#         cs.execute("CREATE OR REPLACE FILE FORMAT TRIPLENS.RAW.JSON_FF TYPE = JSON;")
#         cs.execute("CREATE OR REPLACE STAGE TRIPLENS.RAW.TRIPLENS_INT_STAGE FILE_FORMAT = TRIPLENS.RAW.JSON_FF;")

#         cs.execute(f"""PUT file://{local_temp_path} 
#                         @TRIPLENS_INT_STAGE AUTO_COMPRESS=TRUE OVERWRITE=TRUE """)

#         cs.execute(f""" 
#             COPY INTO {target_table} (ingestion_ts, src_file, payload)
#             FROM (
#                 SELECT CURRENT_TIMESTAMP(), METADATA$FILENAME, $1 
#                 FROM @TRIPLENS_INT_STAGE
#                 ) FILE_FORMAT = (TYPE=JSON)
#                 ON_ERROR = 'ABORT_STATEMET'
#             """)