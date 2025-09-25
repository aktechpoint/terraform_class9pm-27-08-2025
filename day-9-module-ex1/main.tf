resource "aws_instance" "abhihsek" {
  ami           = var.ami_id
  instance_type = var.type
  key_name      = var.key_name
  tags          = var.tags
}