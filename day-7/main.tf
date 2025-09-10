#vpc creation
resource "aws_vpc" "abhishek_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "abhishek_vpc"
  }
  
}
#internet gateway creation
resource "aws_internet_gateway" "abhishek_igw" {
  vpc_id = aws_vpc.abhishek_vpc.id
  tags = {
    Name = "abhishek_igw"
  }
  
}
#subnet creation public
resource "aws_subnet" "abhishek_subnet_public_01" {
  vpc_id            = aws_vpc.abhishek_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "abhishek_subnet_public_01"
  }
  
}

resource "aws_subnet" "abhishek_subnet_public_02" {
  vpc_id            = aws_vpc.abhishek_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1c"
  tags = {
    Name = "abhishek_subnet_public_02"
  }
  
}

#subnet creation private
resource "aws_subnet" "abhishek_subnet_private_01" {
  vpc_id            = aws_vpc.abhishek_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
    tags = {
        Name = "abhishek_subnet_private_01"
    }       
}
resource "aws_subnet" "abhishek_subnet_private_02" {
  vpc_id            = aws_vpc.abhishek_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1b"
    tags = {
        Name = "abhishek_subnet_private_02"
    }   
}

#route table creation public
resource "aws_route_table" "abhishek_route_table_public" {
  vpc_id = aws_vpc.abhishek_vpc.id
    tags = {
        Name = "abhishek_route_table_public"
    }   
}

#route creation public
resource "aws_route" "abhishek_route_public" {
  route_table_id         = aws_route_table.abhishek_route_table_public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.abhishek_igw.id
    depends_on             = [aws_internet_gateway.abhishek_igw]
}
#subnet association public
# Public route table associations
resource "aws_route_table_association" "abhishek_route_table_association_public_01" {
  subnet_id      = aws_subnet.abhishek_subnet_public_01.id
  route_table_id = aws_route_table.abhishek_route_table_public.id
}

resource "aws_route_table_association" "abhishek_route_table_association_public_02" {
  subnet_id      = aws_subnet.abhishek_subnet_public_02.id
  route_table_id = aws_route_table.abhishek_route_table_public.id
}
#eip creation
resource "aws_eip" "abhishek_eip" {
    domain = "vpc"
    tags = {
        Name = "abhishek_eip"
    }   
}
#nat gateway creation
resource "aws_nat_gateway" "abhishek_nat_gw" {
  allocation_id = aws_eip.abhishek_eip.id
  subnet_id     = aws_subnet.abhishek_subnet_public_02.id
    tags = {
        Name = "abhishek_nat_gw"
    }   
  depends_on = [aws_internet_gateway.abhishek_igw]
}

#route table creation private
resource "aws_route_table" "abhishek_route_table_private" {
  vpc_id = aws_vpc.abhishek_vpc.id
    tags = {
        Name = "abhishek_route_table_private"
    }   
}
#route creation private
resource "aws_route" "abhishek_route_private" {
  route_table_id         = aws_route_table.abhishek_route_table_private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.abhishek_nat_gw.id
    depends_on             = [aws_nat_gateway.abhishek_nat_gw]
}
# Private route table associations
resource "aws_route_table_association" "abhishek_route_table_association_private_01" {
  subnet_id      = aws_subnet.abhishek_subnet_private_01.id
  route_table_id = aws_route_table.abhishek_route_table_private.id
}

resource "aws_route_table_association" "abhishek_route_table_association_private_02" {
  subnet_id      = aws_subnet.abhishek_subnet_private_02.id
  route_table_id = aws_route_table.abhishek_route_table_private.id
}

#security group creation
resource "aws_security_group" "abhishek_sg" {
  name        = "abhishek_sg"
  description = "Security group for abhishek"
  vpc_id      = aws_vpc.abhishek_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  
}
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "abhishek_sg"
    }
}

#key pair creation
resource "aws_key_pair" "abhishek" {
  key_name   = "abhishek_key"
  public_key = file("~/.ssh/abhishek.pub")
  tags = {
    Name = "abhishek"
  } 
}

#ec2 instance creation public
resource "aws_instance" "abhishek_ec2_public" {
  ami                         = "ami-02d26659fd82cf299" #Amazon Linux 2 AMI (HVM), SSD Volume Type - ap-south-1
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.abhishek_subnet_public_01.id
  vpc_security_group_ids      = [aws_security_group.abhishek_sg.id]
  key_name                    = aws_key_pair.abhishek.key_name
  associate_public_ip_address = true
  tags = {
    Name = "abhishek_ec2_public"
  } 
}
#ec2 instance creation private
resource "aws_instance" "abhishek_ec2_private" {    
  ami                    = "ami-02d26659fd82cf299" #Amazon Linux 2 AMI (HVM), SSD Volume Type - ap-south-1
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.abhishek_subnet_private_01.id
  vpc_security_group_ids = [aws_security_group.abhishek_sg.id]
  key_name               = aws_key_pair.abhishek.key_name
  tags = {
    Name = "abhishek_ec2_private"
  } 
}

