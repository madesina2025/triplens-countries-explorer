from include.api.extract import api_connect
from include.api.load_to_bucket import load_to_bucket


def main():
    api_response = api_connect()
    load_to_bucket(api_response)

    return None
