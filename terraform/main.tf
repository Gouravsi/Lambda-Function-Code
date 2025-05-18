provider "aws" {
  region = "us-east-1"
}

module "secret_lambda" {
  source = "./secret_lambda.tf"
}

module "email_template" {
  source = "./email_template.tf"
}
