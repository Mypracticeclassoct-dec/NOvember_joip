variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "This is the vpc"
}
variable "subnet_az" {
  type        = string
  default     = "ap-south-1a"
  description = "This is the subnet availability zone "
}
variable "cidr" {
  type        = string
  default     = "10.10.0.0/16"
  description = "THis is the vpc cidr"
}
variable "sub_cidr" {
  type        = string
  default     = "10.10.0.0/24"
  description = "THis is the subnet cidr range"
}
/*variable "image" {
  type        = string
  description = "This is the ami image"
}*/
variable "machine_type" {
  type        = string
  description = "This is aws instance type to be buit  in the autoscaling group"
  default     = "t2.micro"
}
variable "key_pair" {
  type=string
  default="pckey"
  description = "This is the sshkey"
}