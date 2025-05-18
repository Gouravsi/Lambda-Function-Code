resource "aws_iam_role" "lambda1_role" {
  name = "lambda1-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}

resource "aws_iam_role" "lambda2_role" {
  name = "lambda2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}
# secret_lambda needs access to Secrets Manager
resource "aws_iam_role_policy_attachment" "lambda1_secrets" {
  role       = aws_iam_role.lambda1_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

# email_template needs access to SES GetTemplate
resource "aws_iam_policy" "ses_get_template" {
  name        = "LambdaEmailGetTemplate"
  description = "Allows GetTemplate on SES"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ses:GetTemplate"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda2_ses_template" {
  role       = aws_iam_role.lambda2_role.name
  policy_arn = aws_iam_policy.ses_get_template.arn
}
