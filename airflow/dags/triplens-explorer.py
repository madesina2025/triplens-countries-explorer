from datetime import datetime, timedelta

from airflow import DAG
from airflow.providers.standard.operators.python import PythonOperator
from include.api.load_to_bucket import load_to_bucket
from include.api.load_to_snowflake import transfer_minio_json_to_snowflake
import os

from cosmos import DbtTaskGroup, ProjectConfig, ProfileConfig, ExecutionConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping 

DBT_PROJECT_PATH = f"{os.environ['AIRFLOW_HOME']}/dbt/dbt_triplens"
project_config = ProjectConfig(
    dbt_project_path=DBT_PROJECT_PATH,
    manifest_path=f"{DBT_PROJECT_PATH}/target/manifest.json"
)

# profile_config = ProfileConfig(
#     profile_name='dbt_triplens',
#     target_name='dev',
#     profile_mapping=SnowflakeUserPasswordProfileMapping,
#     profiles_args=['database', 'triplens','schema']
# )

profile_config = ProfileConfig(
    profile_name="dbt_triplens",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_conn"
    ),
)
#         profile_args={
#             "database": "TRIPLENS",
#             "schema": "BRONZE",
#             "warehouse": "COMPUTE_WH",
#             "role": "ACCOUNTADMIN",
#         },
#     ),
# )
default_args = {
    "owner": "Triplens",
    "start_date": datetime(2026, 1, 27),
    "retries": 1,
    "retry_delay": timedelta(minutes=1),
}


def extract_and_load_to_bucket():
    """
    Airflow runs this task with no arguments.
    We fetch API data, then pass it into existing load_to_bucket(data).
    """
    from include.api.extract import api_connect
    from include.api.load_to_bucket import load_to_bucket

    data = api_connect()
    load_to_bucket(data)


with DAG(
    dag_id="triplens-explorer",
    description="TripLens countries explorer",
    default_args=default_args,
    schedule="@daily",
    catchup=False,
    tags=["triplens-explorer", "tourism", "snowflake", "dbt"],
) as dag:

    extract_load_to_bucket = PythonOperator(
        task_id="extract_load_to_bucket",
        python_callable=extract_and_load_to_bucket,
    )

    load_to_snowflake = PythonOperator(
        task_id="load_to_snowflake",
        python_callable=transfer_minio_json_to_snowflake,
        op_kwargs={
            "bucket": "triplens-bucket",
            "file_key": "raw/countries_raw.json",
            "target_table": "TRIPLENS.RAW.COUNTRIES_RAW",
        },
    )

    extract_load_to_bucket >> load_to_snowflake