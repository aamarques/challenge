resource "aws_elb" "challenge-elb" {
  name            = "challenge-elb"
  subnets         = [aws_subnet.public-a.id, aws_subnet.public-b.id]
  security_groups = [aws_security_group.elb-securitygroup.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.server[0].id}", "${aws_instance.server[1].id}"]
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "challenge-elb"
  }

}

resource "null_resource" "waiting_instances_became_ready" {
  provisioner "local-exec" {
    command = "sleep 120;export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ansible/hosts  --key-file keys/mykey -u ubuntu ansible/playbook.yml; rm -f ansible/hosts"
  }
}
