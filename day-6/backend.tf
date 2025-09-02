terraform {
  backend "s3" {
    bucket = "ramlalsingh"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    
  }
}