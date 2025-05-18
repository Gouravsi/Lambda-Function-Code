resource "aws_iam_role" "lambda3_role_alt" {
  name = "lambda3-role-alt"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow",
      Sid       = ""
    }]
  })
}