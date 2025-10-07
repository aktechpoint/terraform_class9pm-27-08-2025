# output "rds_endpoint" {
#   value = aws_db_instance.mysql_public.endpoint
# }
output "rds_endpoint" {
  value = aws_db_instance.rds_mydb.endpoint
}