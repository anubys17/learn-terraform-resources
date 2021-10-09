provider "aws" {
  region = "us-east-2"
}

provider "random" {}

resource "random_pet" "name" {}

resource "aws_instance" "web" {
  ami           = "ami-074cce78125f09d61"
  instance_type = "t3.micro"
  subnet_id = "subnet-0134c478d258d261f"
  user_data     = file("init-script.sh")

  tags = {
    Name = random_pet.name.id
  }
}
