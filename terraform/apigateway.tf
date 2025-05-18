resource "aws_api_gateway_rest_api" "api" {
  name        = "API"
  description = "API for Lambda functions"
}

resource "aws_api_gateway_resource" "email_template_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "email_template"
}

resource "aws_api_gateway_method" "email_template_get" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.email_template_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "email_template_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.email_template_resource.id
  http_method             = aws_api_gateway_method.email_template_get.http_method
  integration_http_method = "POST" # Required for AWS Lambda proxy integration
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.email_template.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.email_template_get_integration
    # Add other integrations here if needed
  ]

  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = timestamp()
  }
}

resource "aws_api_gateway_stage" "prod" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}
