#terraform {
#  required_version = ">= 0.12, < 0.13"
#}

provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket         = "my-tfstate-store11223344"
    key            = "global/stage/jenkins/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-backend-state-locks11223344"
    encrypt        = true
  }
}


resource "aws_instance" "jenkins" {
  ami                    = "ami-024a9ad5cfafbee73"
  instance_type          = "t2.micro"
  key_name = "epam-lab-ec2"
  vpc_security_group_ids = [aws_security_group.instance.id]

  #user_data = <<-EOF
  #            #!/bin/bash
  #            echo "Hello, World" > index.html
  #            nohup busybox httpd -f -p ${var.server_port} &
  #            EOF

  tags = {
    Name = "terraform-jenkins"
  }
}

resource "aws_security_group" "instance" {

  name = var.security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

