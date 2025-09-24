resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "ramalalasingh112"
  force_destroy = true

  tags = {
    Name        = "LambdaFunctionsBucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "instancerun.zip"
  source = "./instancerun.zip"
  etag   = filemd5("./instancerun.zip")
}

# Lambda execution role
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Basic execution (logs)
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# EC2 permissions for Lambda
resource "aws_iam_policy" "lambda_ec2_policy" {
  name        = "lambda-ec2-policy"
  description = "Allow Lambda to launch EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ec2:RunInstances",
          "ec2:DescribeInstances",
          "ec2:CreateTags"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_ec2_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_ec2_policy.arn
}

# Lambda function
resource "aws_lambda_function" "instance_run" {
  function_name = "InstanceRunFunction"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "instancerun.lambda_handler"
  runtime       = "python3.13"
  s3_bucket     = aws_s3_bucket.lambda_bucket.id
  s3_key        = aws_s3_object.lambda_code.key
  timeout       = 100
  memory_size   = 128

  environment {
    variables = {
      ENV_VAR_KEY = "ENV_VAR_VALUE"
    }
  }

  tags = {
    Name        = "InstanceRunFunction"
    Environment = "Dev"
  }
}
