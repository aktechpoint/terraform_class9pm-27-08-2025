vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
key_name             = "keys_23"
ami_id               = "ami-02d26659fd82cf299" # Amazon Linux 2 AMI (HVM), SSD Volume Type
instance_type        = "t3.micro"