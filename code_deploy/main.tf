# ami-0389b2a3c4948b1a0
provider "aws" {
  profile    = var.profile
  region     = var.region
}

# New resource for the S3 bucket our application will use.
resource "aws_s3_bucket" "example" {
  bucket = "mt-tess-code-deploy-test"
  acl    = "private"
  tags = {"created-by"=var.creator}
  force_destroy = "true"
}

resource "aws_iam_instance_profile" "tess_test_ec2_profile" {
  name = "tess_test_ec2_profile"
  role = var.ec2-role
}

# Change the aws_instance we declared earlier to now include "depends_on"
resource "aws_instance" "tess-tut1" {
  ami           = "ami-0389b2a3c4948b1a0"
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.key_name
  security_groups = ["tess-sg-ec2ssh", "TessWebDMZ"] #nasty and hardcoded
  iam_instance_profile = aws_iam_instance_profile.tess_test_ec2_profile.name
  user_data = file("install_cd_agent.sh")
  depends_on = [aws_s3_bucket.example]
  tags = {"created-by"=var.creator, "Environment"="Dev"}
}

output "ip" {
    value = aws_instance.tess-tut1.public_ip
}