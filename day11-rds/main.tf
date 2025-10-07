resource "aws_db_instance" "rds_mydb" {
    engine = "mysql"
    instance_class = "db.t3.micro"
    allocated_storage = 20
    username = "admin"
    password = "Abhi$#123"
    db_subnet_group_name = aws_db_subnet_group.publicsubg.name
    vpc_security_group_ids = [aws_security_group.public_sg.id]
    skip_final_snapshot = true
    publicly_accessible = true
    tags = {
      Name = "rds_mydb"
    }
}