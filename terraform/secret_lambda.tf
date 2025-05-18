resource "aws_lambda_function" "secret_lambda" {
  function_name = "secret_lambda"
  handler       = "main.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda1_role.arn
  filename      = "${path.module}/../builds/secret_lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/../builds/secret_lambda.zip")

  environment {
    variables = {
      SECRET_NAME = "your-secret-id"
    }
  }
}
