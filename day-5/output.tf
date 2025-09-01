output "public_ip" {
  value = aws_instance.abhishek.public_ip
  
}
output "private_ip" {
  value = aws_instance.abhishek.private_ip
  sensitive = true
  
}