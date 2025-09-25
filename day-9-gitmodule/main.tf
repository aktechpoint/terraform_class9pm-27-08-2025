provider "aws" {
  
}

module "dev" {
  source = "github.com/aktechpoint/terraform_class9pm-27-08-2025/day-9-module-ex1"
  ami_id   = "ami-02d26659fd82cf299"
    type     = "t3.micro"
    key_name = "keys_23"
    region   = "ap-south-2"
}