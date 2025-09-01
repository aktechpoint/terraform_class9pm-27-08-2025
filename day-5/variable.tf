variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
    default     = "" # Example AMI ID, replace with a valid one for your region
  
}
variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t3.micro"
}
variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  default     = "" # Replace with your key pair name
  
}