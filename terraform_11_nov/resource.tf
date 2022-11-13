// creating the vpc 
resource "aws_vpc" "appvpc" {
  cidr_block = var.cidr
  tags = {
    "Name" = "app_vpc"
  }
}
// creating  the subnet 
resource "aws_subnet" "appsub" {
  vpc_id     = aws_vpc.appvpc.id
  count      = length(var.subnet_az)
  cidr_block = cidrsubnet("var.cidr", 8, [count.index]) // This is the subnet function used to define the subnet cidr using the vpc cidr
  tags = {
    "Name" = var.subnet_name[count.index]
  }
  depends_on = [
    aws_vpc.appvpc
  ]
}
// creating the internet gateway
resource "aws_internet_gateway" "appint" {
  vpc_id = aws_vpc.appvpc.id
  type = {
    "Name" = "app_intgw"
  }
}
// Attaching internet gateway to the vpc
resource "aws_internet_gateway_attachment" "attint" {
  internet_gateway_id = aws_internet_gateway.appint.id
  vpc_id              = aws_vpc.appvpc.id

}
// creating  public route tables 
resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.appvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.appint.id
  }
  tags = {
    "Name" = "pub_rt"
  }
}
// Associating subnet to the routetable 
resource "aws_route_table_association" "assort" {
  count          = length(var.subnet_az)
  subnet_id      = aws_subnet.appsub[count.index].id
  route_table_id = aws_route_table.pubrt.id
  depends_on = [
    aws_subnet.appsub,
    aws_route_table.pubrt
  ]
}
// creating security group for the vpc
resource "aws_security_group" "appsg" {
  name        = "app_sg"
  description = "This is the security group for appvpc"
  vpc_id      = aws_vpc.appvpc.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "For ssh "
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "This is for http"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "This is for https"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "for angular app"
    protocol    = "tcp"
    from_port   = 4200
    to_port     = 4200
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "To allow all"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
  tags = {
    "Name" = "app_sg"
  }
}
// creating ec2 machines  with public_ip enabled 
resource "aws_instance" "dev" {
  count                       = 1
  ami                         = "ami-062df10d14676e201" // EC2 ubuntu machine in mumbai region
  subnet_id                   = aws_subnet.appsub[0].id
  availability_zone           = var.subnet_az[0]
  instance_type               = var.machine_type
  key_name                    = var.key_pair
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.appsg.id]
  root_block_device {
    volume_size = 8
  }
  tags = {
    "Name" = "env_ec2"
  }
}
// creating the ec2 machines without public_ip addresses
resource "aws_instance" "qa_env" {
  count                       = 2
  ami                         = "ami-062df10d14676e201" // EC2 ubuntu machine in mumbai region
  subnet_id                   = aws_subnet.appsub[0].id
  availability_zone           = var.subnet_az[0]
  instance_type               = var.machine_type
  key_name                    = var.key_pair
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.appsg.id]
  root_block_device {
    volume_size = 8
  }
  tags = {
    "Name" = var.qa[count.index]
  }
}
