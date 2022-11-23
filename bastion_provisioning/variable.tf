variable "region" {
  type = string
  default = "us-east-1"
}
variable "cidr_block"{
  type= string
  default = "192.168.0.0/16"
}
variable "av_zs" {
   type=list
  description = "This is the availability zones "
}
variable "priv_sub" {
  type=list
  description = "this is the private subnet"
}
variable "pub_sub" {
  type = list
  description = "This is the public subnets"
}