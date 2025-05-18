import boto3
import json
import os

def lambda_handler(event, context):
    secret_name = os.environ.get("SECRET_NAME")
    region = os.environ.get("AWS_REGION", "us-east-1")
    client = boto3.client("secretsmanager", region_name=region)
    response = client.get_secret_value(SecretId=secret_name)
    return {
        "statusCode": 200,
        "body": json.dumps({"secret": response["SecretString"]})
    }