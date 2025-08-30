output "instance_id" {
  value = aws_instance.abhihsek.id
  
}
output "public_ip" {
  value = aws_instance.abhihsek.public_ip
  sensitive = false
}
output "private_ip" {
  value = aws_instance.abhihsek.private_ip
  sensitive = true
  
}
output "instance_name" {
  value = aws_instance.abhihsek.tags["Name"]
  
}
output "private_dns" {
  value = aws_instance.abhihsek.private_dns
  
}