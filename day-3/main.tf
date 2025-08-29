resource "aws_instance" "abhishek" {
  ami = var.ami_id
    instance_type = var.type

    key_name = var.key
    tags = var.tags
}