variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = ""

}
variable "type" {
  description = "The type of instance to use"
  type        = string
  default     = ""
}
variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = ""
}
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = ""

}
variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default = {
    Name = "MyInstance"
  }
}