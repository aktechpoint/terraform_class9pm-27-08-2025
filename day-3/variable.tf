variable "ami_id" {
  description = "value of ami id"
  type = string
    default = "ami-02d26659fd82cf299"
  
}
variable "type" {
  description = "value of instance type"
  type = string
  default = "t3.small"
  
}
variable "key" {
  description = "value of key name"
  type = string
  default = "sun"
  
}
variable "tags" {
  description = "value of tags"
  type = map(string)
  default = {
    Name = "abhishek-ec2"
  }
}