import boto3
from botocore.exceptions import ClientError
from include.api.config import url_endpoint, access_key, secret_key
import json

def load_to_bucket(data):
    bucket_name='triplens-bucket'
    folder_path='raw' 
    object_name=f'{folder_path}/countries_raw.json'


    client = boto3.client(
        's3',
        endpoint_url=url_endpoint,
        aws_access_key_id=secret_key,
        aws_secret_access_key=secret_key,
        config=boto3.session.config(signature_version='s3v4'),
        verify=False
    )

    try:
        client.head_bucket(Bucket=bucket_name)
        print(f'Bucket {bucket_name} already exists')
    except ClientError as e:
        if e.response['error']['code'] == '404':
            client.create_bucket(Bucket=bucket_name)
            print(f'{bucket_name} created')

    data = json.dumps(data, ensure_ascii=False).encode('utf-8')

    client.put_object(
        Bucket=bucket_name,
        Key=object_name,
        Body=data,
        ContentType='application/json'
    )

    print(f'data loaded into {bucket_name}')