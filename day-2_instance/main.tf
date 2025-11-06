resource "aws_instance" "devops" {
  ami           = "ami-0e6a50b0059fd2cc3"
  instance_type = "t3.micro"
  key_name = "sun"

  tags = {
    Name = "devops"
  }
  
}
