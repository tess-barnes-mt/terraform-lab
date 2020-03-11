# Terraform labs
Example scripts from my terraform labs
## teraform and git ignore
There are some override files which are expected to be in the folders but will not be checked into git. These contain public keys and some variables which would be expected to be specific to the user (static pre existing roles etc).

Format: `*_override.tf`

## file naming conventions
All files in a folder are picked up by terraform. files matching the following examples are expected to be local overrides:
- variables_override.tf
- keypair_override.tf
### expected keypair syntax
```
resource "aws_key_pair" "deployer" {
  key_name   = "tess.ec2.key"
  public_key = "your public key here"
  tags = {"created-by"=var.creator}
}
```
### expected override variables
```
variable "creator" {
  default = "your name here"
}
```
