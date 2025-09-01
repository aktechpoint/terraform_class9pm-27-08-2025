terraform {
  backend "s3" {
    bucket = "ramalalsingh"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    
  }
}