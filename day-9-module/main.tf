module "dev" {
    source = "../day-9-module-ex1"
    ami_id   = "ami-02d26659fd82cf299"
    type     = "t3.micro"
    key_name = "keys_23"
    region   = "ap-south-2"
    
}