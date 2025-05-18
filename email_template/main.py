import boto3
import json
import os

def lambda_handler(event, context):
    method = event.get("httpMethod", "")
    if method != "GET":
        return {
            "statusCode": 405,
            "body": json.dumps({"error": "Method not allowed"})
        }

    secret_name = os.environ.get("SECRET_NAME")
    region = os.environ.get("AWS_REGION", "us-east-1")
    client = boto3.client("secretsmanager", region_name=region)

    try:
        response = client.get_secret_value(SecretId=secret_name)
        secret_value = response.get("SecretString", "")
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }

    return {
        "statusCode": 200,
        "body": json.dumps({"secret": secret_value})
    }
