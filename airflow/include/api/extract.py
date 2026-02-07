import requests
from include.api.config import urls , data_dir
import time
from requests.exceptions import HTTPError
import json

def api_connect():

    try:
        response = requests.get(urls['url_1'])
        response.raise_for_status()

        data_1 = response.json()

        time.sleep(2)

        response = requests.get(urls['url_2'])
        response.raise_for_status()

        data_2 = response.json()

        # print(data_2)

    except HTTPError as err:
        print(err)

    complete_data = []
    for response_1, response_2 in zip(data_1, data_2):
        complete_data.append({**response_1,**response_2})

    return complete_data 
    # # print(complete_data)
    # with open(f'{data_dir}/ountries_raw.json','w', encoding='utf-8') as file:
    #     json.dump(complete_data, file, ensure_ascii=False, indent=2)

# api_connect()