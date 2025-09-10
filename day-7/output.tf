#public ip of ec2 instance
output "public_ip" {
  value = aws_instance.abhishek_ec2_public.public_ip
}
#private ip of ec2 instance
output "private_ip" {
  value = aws_instance.abhishek_ec2_private.private_ip
  sensitive = true
}