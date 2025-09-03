terraform {
  backend "s3" {
    bucket = "ramlalsingh"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "ramlalsingh-lock-table"
    encrypt = true
    }
  }