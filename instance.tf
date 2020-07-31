# Prego-way to create 2 (or more) instances in different subnets
locals {
  subnet = concat([aws_subnet.public-a.id], [aws_subnet.public-b.id])
}

resource "aws_instance" "server" {
  ami           = var.AMI
  instance_type = var.instance_type

  # the counter for instances
  count = var.instance_count

  # the VPC subnet
  subnet_id = element(local.subnet, count.index)

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-challenge.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  # Name of Server using the index count
  tags = {
    Name = "Server ${count.index}"
  }
}
