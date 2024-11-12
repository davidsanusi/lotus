provider "aws" {
  region = var.region  # Replace with your desired region
}

# Retrieve the latest Ubuntu 24.04 LTS AMI
data "aws_ami" "ubuntu_24_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }  

  owners = ["099720109477"]  # Canonical's AWS account ID
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu_24_04.id
  instance_type = "t2.micro"  # Replace with desired instance type

  tags = {
    Name = "webserver-${var.region}"
  }
}
