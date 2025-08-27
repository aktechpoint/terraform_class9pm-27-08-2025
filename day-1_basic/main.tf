provider "aws" {
  region = "ap-south-1"
  
}

resource "aws_instance" "abhishek" {
    ami = "ami-02d26659fd82cf299"
    instance_type = "t3.micro"
    key_name = "sun"
    tags = {
      Name = "abhishek-instance"
    }
  
}

resource "aws_s3_bucket" "abhishek-bucket" {
  bucket = "ramalalasingh"
  
}