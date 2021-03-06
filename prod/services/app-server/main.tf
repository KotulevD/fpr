provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_key_pair" "prodapp" {
  key_name   = "ubuntu"
  public_key = file("ftask.pub")
}

resource "aws_security_group" "prodapp" {
  name        = "prod-security-group"
  description = "Allow HTTP, HTTPS and SSH traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prodapp"
  }
}


resource "aws_instance" "prodapp" {
  key_name      = aws_key_pair.prodapp.key_name
  ami           = "ami-05f7491af5eef733a"
  instance_type = "t2.micro"

  tags = {
    Name = "prodapp"
  }

  vpc_security_group_ids = [
    aws_security_group.prodapp.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
    host        = self.public_ip
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 20
  }
}

resource "aws_eip" "prodapp" {
  vpc      = true
  instance = aws_instance.prodapp.id
}


terraform {
  backend "s3" {
    bucket         = "my-tfstate-store11223344"
    key            = "global/stage/services/app-server/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-backend-state-locks11223344"
    encrypt        = true
  }
}
