resource "aws_lambda_function" "email_template" {
  function_name = "email_template"
  handler       = "main.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda2_role.arn
  filename      = "${path.module}/../builds/email_template.zip"
  source_code_hash = filebase64sha256("${path.module}/../builds/email_template.zip")
}
