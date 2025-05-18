import json

def lambda_handler(event, context):
    print("Event received:", event)  # Logs the input event for debugging

    response = {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "message": "Hello from email_template Lambda!"
        })
    }
    return response
