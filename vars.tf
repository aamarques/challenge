# default region if AWS_REGION. 
# The AMI ID is related to REGION. If you change it you should change rhe AMI ID too 
variable "AWS_REGION" {
  default = "eu-west-1"
}

# AMI to eu-west-1 selected from https://cloud-images.ubuntu.com/locator/ec2/
variable "AMI" {
  default = "ami-0a74b2559fb675b98"
}

variable "private_key" {
  default = "keys/mykey"
}

variable "public_key" {
  default = "keys/mykey.pub"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_count" {
  default = "2"
}
