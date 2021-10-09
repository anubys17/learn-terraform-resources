provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "web-sg" {
  name = "${random_pet.name.id}-sg"
  ingress {
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
}

provider "random" {}

resource "random_pet" "name" {}

resource "aws_instance" "web" {
  ami           = "ami-074cce78125f09d61"
  instance_type = "t3.micro"
  subnet_id = "subnet-0134c478d258d261f"
  user_data     = file("init-script.sh")
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  tags = {
    Name = random_pet.name.id
  }
}

