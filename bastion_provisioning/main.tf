module "vpc" {
  source = "terraform-aws-module/vpc/aws"
  name = "module_vpc"
  cidr= var.cidr_block
  azs = 
}