resource "aws_iam_role" "secret_lambda_role" {
  name = "secret_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_lambda_function" "secret_lambda" {
  function_name = "secret_lambda"
  handler       = "main.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.secret_lambda_role.arn
  filename      = "${path.module}/../builds/secret_lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/../builds/secret_lambda.zip")
  environment {
    variables = {
      SECRET_NAME = "your-secret-id"
    }
  }
}
