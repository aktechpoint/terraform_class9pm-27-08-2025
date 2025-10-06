#public ec2 instance
resource "aws_instance" "abhi_server" {
  count                       = length(var.public_subnet_cidrs)
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.public_subnets[count.index].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.public_sg.id]

  tags = {
    Name = "Abhi-Server-${count.index + 1}"
  }
}
#private ec2 instance
resource "aws_instance" "abhi_private_server" {
  count                       = length(var.private_subnet_cidrs)
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.private_subnets[count.index].id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.private_sg.id]

  user_data = templatefile("${path.module}/nginx-setup.sh", {
    server_index = count.index + 1
  })

  tags = {
    Name = "Abhi-Private-Server-${count.index + 1}"
  }
}