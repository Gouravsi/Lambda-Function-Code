data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "secret_lambda_policy" {
  name   = "secret_lambda-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["secretsmanager:GetSecretValue"],
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda1_attach" {
  role       = aws_iam_role.secret_lambda.name
  policy_arn = aws_iam_policy.secret_lambda_policy.arn
}
