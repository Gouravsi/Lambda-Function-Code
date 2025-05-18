import json

def lambda_handler(event, context):
    try:
        return {
            "statusCode": 200,
            "body": json.dumps({"message": "ok"})
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
