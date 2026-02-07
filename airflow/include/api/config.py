from pathlib import Path
import os
from dotenv import load_dotenv

urls = {
    "url_1" : "https://restcountries.com/v3.1/all?fields=name,independent,unNumber,startofWeek,currencies,idd,region,subregion,language",
    "url_2" : "https://restcountries.com/v3.1/all?fields=area,population,continents"
}

parent_dir = Path(__file__).resolve().parent
data_dir =parent_dir / "data_bank"
data_dir.mkdir(parents=True, exist_ok=True)


# minIO endpoints
url_endpoint = os.getenv('MINIO_ENDPOINT', 'http://localhost:29001')
access_key = os.getenv('MINIO_ROOT_USER')
secret_key = os.getenv('MINIO_ROOT_PASSWORD')