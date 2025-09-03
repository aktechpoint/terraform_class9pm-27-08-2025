provider "aws" {

}
resource "aws_s3_bucket" "name" {

  bucket = "ramlalsingh"
}

resource "aws_dynamodb_table" "ramlalsingh-lock-table" {
  name = "ramlalsingh-lock-table"

  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

}