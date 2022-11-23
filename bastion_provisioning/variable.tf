variable "region" {
  type        = string
  description = "This is the region of the vpc"
}
variable "cidr" {
  type        = string
  description = "This is the cidr range of the vpc"
}
variable "subnet_az" {
  type        = list(string)
  description = "This is the availability zone of the subnet"
}
variable "subnet_name" {
  type        = list(string)
  description = "This is the name of the subnets"
}
variable "machine_type" {
  type        = string
  description = "This is the type of the ec2 machine created "
  default     = "t2.micro"
}
variable "key_pair" {
  type        = string
  default     = "pckey"
  description = "This is the ssh key "
}
variable "qa" {
  type        = list(string)
  description = "This is the name of the qa ec2 machines "

}
