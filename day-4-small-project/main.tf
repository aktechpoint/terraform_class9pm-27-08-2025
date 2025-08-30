provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "abhishek" {
  ami           = "ami-02d26659fd82cf299"
  instance_type = "t3.micro"
  key_name      = "sun"

  # safer: encodes script into base64
  user_data_base64 = filebase64("${path.module}/user_data.sh")

  tags = {
    Name = "abhishek-instance"
  }
}

output "public_ip" {
  value = aws_instance.abhishek.public_ip
}
