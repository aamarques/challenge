# default region if AWS_REGION was not exported 
variable "AWS_REGION" {
  default = "eu-west-1"
}

# AMI selected from https://cloud-images.ubuntu.com/locator/ec2/
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
