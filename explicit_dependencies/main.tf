# ami-0389b2a3c4948b1a0
provider "aws" {
  profile    = "default"
  region     = "eu-west-2"
}

# New resource for the S3 bucket our application will use.
resource "aws_s3_bucket" "example" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "tess-terraform-getting-started"
  acl    = "private"
  tags = {"created-by"="tess"}
  force_destroy = "true"
}

resource "aws_iam_instance_profile" "tess_test_ec2_profile" {
  name = "tess_test_ec2_profile"
  role = "ec2-s3-readonly" # nasty and hardcoded
}

# Change the aws_instance we declared earlier to now include "depends_on"
resource "aws_instance" "tess-tut1" {
  ami           = "ami-0389b2a3c4948b1a0"
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.key_name
  security_groups = ["tess-sg-ec2ssh"] #nasty and hardcoded
  iam_instance_profile = aws_iam_instance_profile.tess_test_ec2_profile.name

  # Tells Terraform that this EC2 instance must be created only after the
  # S3 bucket has been created.
  depends_on = [aws_s3_bucket.example]
  tags = {"created-by"="tess"}
}

output "ip" {
    value = aws_instance.tess-tut1.public_ip
}