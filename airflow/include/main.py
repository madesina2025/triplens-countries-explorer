from include.api.extract import api_connect
from include.api.load_to_bucket import load_to_bucket

# from include.api.load_to_snowflake import transfer_data_to_snowflake
from include.api.load_to_snowflake import transfer_minio_json_to_snowflake as transfer_data_to_snowflake

def main():
    api_response = api_connect()
    load_to_bucket(api_response)

    transfer_data_to_snowflake(
        bucket='triplens-bucket',
        file_key='raw/countries_raw.json',
        target_table='TRIPLENS.RAW.COUNTRIES_RAW'
    )

    return None
