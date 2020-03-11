resource "aws_key_pair" "deployer" {
  key_name   = ""
  public_key = ""
  tags = {"created-by"=var.creator}
}