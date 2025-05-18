import boto3
import json

def lambda_handler(event, context):
    client = boto3.client("ses", region_name="us-east-1")
    response = client.get_template(TemplateName="YourTemplateName")
    return {
        "statusCode": 200,
        "body": json.dumps(response)
    }
