module "vpc" {
  source = "terraform-aws-module/vpc/aws"
  name = "module_vpc"
  cidr= var.cidr_block
  azs = var.av_zs
  private_subnets = var.priv_sub
  public_subnets = var.pub_sub
  enable_nat_gateway = false
  enable_vpn_gateway = false
  tags ={
    Name = "vpc_module"
  }
}