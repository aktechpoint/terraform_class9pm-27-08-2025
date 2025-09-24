provider "aws" {
  
}
resource "aws_instance" "dev" {
  ami           = "ami-0cf8ec67f4b13b491"
  instance_type = "t3.micro"
  key_name = "keys_23"

  tags = {
    Name = "TerraformExample"
  }
    # lifecycle {
    #   create_before_destroy = true
    # }
    # lifecycle {
    #     prevent_destroy = true
    # }
#   lifecycle {
#     ignore_changes = [tags]
#   }
}
# lifecycle {
#     create_before_destroy = true
#   }
# lifecycle{
#     prevent_destroy = true
# }
