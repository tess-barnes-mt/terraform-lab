# ami-0389b2a3c4948b1a0
provider "aws" {
  profile    = "default"
  region     = "eu-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0389b2a3c4948b1a0"
  instance_type = "t2.micro"
  # vpc_security_group_ids = ["sg-0077..."]
  # subnet_id = "subnet-923a..."
}