### variables

variable "aws_access_key" {}
variable "aws_secret_key" {}

###  AWS PROVIDER ###

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "us-east-2"
}

### EC2 SERVER ###

resource "aws_instance" "example" {
  ami                 = "ami-916f59f4"
  instance_type       = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

#  user_data = <<-EOF
#		#!/bin/bash
#		echo "Hello, World" > index.html
#		nohup busybox httpd -f -p "${var.server_port}"
#		EOF

  tags {
    Name = "terrform-example"
  }
}

### AWS SG ###

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


### VARIABLES ###

variable "server_port" {
	description = "The port that we will use for HTTP requests"
	default = "8080"
}

### OUTPUTS ###

output "public_ip" {
	value = "${aws_instance.example.public_ip}"
}
