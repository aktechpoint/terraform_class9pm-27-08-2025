resource "aws_vpc" "abhishek_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "abhishek_vpc"
  }

}
data "aws_availability_zones" "available" {}


resource "aws_internet_gateway" "abhishek_igw" {
  vpc_id = aws_vpc.abhishek_vpc.id
  tags = {
    Name = "abhishek_igw"
  }

}
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.abhishek_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "public_subnet_${count.index + 1}"
  }

}
# resource "aws_subnet" "private_subnets" {
#   count                   = length(var.private_subnet_cidrs)
#   vpc_id                  = aws_vpc.abhishek_vpc.id
#   cidr_block              = var.private_subnet_cidrs[count.index]
#   map_public_ip_on_launch = false
#   availability_zone       = element(data.aws_availability_zones.available.names, count.index)
#   tags = {
#     Name = "private_subnet_${count.index + 1}"
#   }

# }
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.abhishek_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.abhishek_igw.id
  }
  tags = {
    Name = "public_rt"
  }

}
resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}
# resource "aws_eip" "nat_eip" {
#   domain = "vpc"
#   tags = {
#     Name = "nat_eip"
#   }

# }
# resource "aws_nat_gateway" "nat_gw" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.public_subnets[0].id
#   tags = {
#     Name = "nat_gw"
#   }
#   depends_on = [aws_internet_gateway.abhishek_igw]

# }
# resource "aws_route_table" "private_rt" {
#   vpc_id = aws_vpc.abhishek_vpc.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat_gw.id
#   }
#   tags = {
#     Name = "private_rt"
#   }
# }
# resource "aws_route_table_association" "private_rt_assoc" {
#   count          = length(aws_subnet.private_subnets)
#   subnet_id      = aws_subnet.private_subnets[count.index].id
#   route_table_id = aws_route_table.private_rt.id
# }

resource "aws_security_group" "public_sg" {
  vpc_id      = aws_vpc.abhishek_vpc.id
  name        = "public_sg"
  description = "Allow HTTP and SSH inbound traffic"
  ingress = [
    for port in [22, 80, 3306] : {
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      self             = false
      prefix_list_ids  = []
      ipv6_cidr_blocks = []
      security_groups  = []
      description      = "Allow inbound traffic on port ${port}"
    }
  ]
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_db_subnet_group" "publicsubg" {
  name       = "publicsubg"
  subnet_ids = aws_subnet.public_subnets[*].id
  tags = {
    Name = "publicsubg"
  }
  
}
# resource "aws_security_group" "private_sg" {
#   vpc_id      = aws_vpc.abhishek_vpc.id
#   name        = "private_sg"
#   description = "Allow HTTP and SSH inbound traffic from public_sg"
#   ingress = [
#     for port in [22, 80, 3306, 8000, 8080] : {
#       from_port        = port
#       to_port          = port
#       protocol         = "tcp"
#       cidr_blocks      = []
#       self             = false
#       prefix_list_ids  = []
#       ipv6_cidr_blocks = []
#       security_groups  = [aws_security_group.public_sg.id]
#       description      = "Allow inbound traffic on port ${port} from public_sg"
#     }
#   ]
#   egress {
#   from_port   = 0
#   to_port     = 0
#   protocol    = "-1"
#   cidr_blocks = ["0.0.0.0/0"]
# }

# }