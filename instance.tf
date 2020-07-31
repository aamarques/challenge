resource "aws_instance" "example" {
  ami           = var.AMI
  instance_type = "t2.micro"
}

