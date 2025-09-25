provider "aws" {
  
}
resource "aws_instance" "abhishek" {
    ami = "ami-02d26659fd82cf299"
    instance_type = "t3.micro"
    key_name = "keys_23"
    tags = {
      Name = "abhishek-instance"
    }
  
}

resource "aws_s3_bucket" "abhishek-bucket" {
  bucket = "ramalalasingh1111"
  
}