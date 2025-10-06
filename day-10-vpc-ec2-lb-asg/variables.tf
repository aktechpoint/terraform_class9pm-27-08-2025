variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string

}
variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)

}
variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)

}
variable "instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string


}
variable "key_name" {
  description = "The name of the key pair to use for the EC2 instances"
  type        = string

}
variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string

}
