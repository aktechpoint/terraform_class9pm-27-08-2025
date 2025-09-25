module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"
  subnet_id = "subnet-06b04b99f63f84d58"
  instance_type = "t3.micro"
  key_name      = "keys_23"
  monitoring    = true
    ami           = "ami-02d26659fd82cf299"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}