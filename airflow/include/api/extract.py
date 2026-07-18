import requests
from include.api.config import urls , data_dir
import time
from requests.exceptions import HTTPError
import json


import os
import requests


import os
import requests

from include.api.config import urls


def api_connect() -> list[dict]:
    """Extract all country records from the REST Countries v5 API."""

    api_key = os.getenv("REST_COUNTRIES_API_KEY")

    if not api_key:
        raise RuntimeError(
            "REST_COUNTRIES_API_KEY is missing from the Airflow environment."
        )

    headers = {
        "Authorization": f"Bearer {api_key}",
        "Accept": "application/json",
    }

    all_countries = []
    limit = 100
    offset = 0

    try:
        while True:
            response = requests.get(
                urls["url_1"],
                headers=headers,
                params={
                    "limit": limit,
                    "offset": offset,
                },
                timeout=30,
            )
            response.raise_for_status()

            payload = response.json()

            if not isinstance(payload, dict):
                raise RuntimeError(
                    f"Unexpected API response type: "
                    f"{type(payload).__name__}"
                )

            if payload.get("errors"):
                raise RuntimeError(
                    f"REST Countries returned an API error: "
                    f"{payload['errors']}"
                )

            data_section = payload.get("data")

            if not isinstance(data_section, dict):
                raise RuntimeError(
                    "REST Countries response is missing the data object."
                )

            country_records = data_section.get("objects")

            if not isinstance(country_records, list):
                raise RuntimeError(
                    "REST Countries response did not contain "
                    "data.objects as a list."
                )

            all_countries.extend(country_records)

            meta = data_section.get("meta", {})
            total = meta.get("total")

            print(
                f"Extracted {len(country_records)} countries "
                f"from offset {offset}."
            )

            offset += limit

            if not country_records:
                break

            if isinstance(total, int) and offset >= total:
                break

            if len(country_records) < limit:
                break

    except requests.RequestException as err:
        raise RuntimeError(
            f"REST Countries request failed: {err}"
        ) from err

    if not all_countries:
        raise RuntimeError(
            "REST Countries returned zero country records."
        )

    print(
        f"Successfully extracted {len(all_countries)} "
        "country records in total."
    )

    return all_countries





# def api_connect():

#     try:
#         response = requests.get(urls['url_1'])
#         response.raise_for_status()

#         data_1 = response.json()

#         time.sleep(2)

#         response = requests.get(urls['url_2'])
#         response.raise_for_status()

#         data_2 = response.json()

#         print(type(data_1))
#         print(data_1)

#         print(type(data_2))
#         print(data_2)

#         # print(data_2)

#     except HTTPError as err:
#         raise RuntimeError(f"API request failed: {err}") from err

#     complete_data = []

#     for response_1, response_2 in zip(data_1, data_2):
#         if isinstance(response_1, dict) and isinstance(response_2, dict):
#             complete_data.append({**response_1, **response_2})
#         else:
#             complete_data.append(
#                 {
#                     "country_data": response_1,
#                     "additional_data": response_2,
#                 }
#             )

#     return complete_data

