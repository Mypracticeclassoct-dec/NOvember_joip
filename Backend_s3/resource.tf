// creating vpc 
resource "aws_vpc" "s3vpc" {
  cidr_block = var.cidr
  tags = {
    "Name" = "vpc_s3"
  }
}

// creating subnets for the vpc

resource "aws_subnet" "s3subnets" {
  count             = length(var.sub_cidr)
  vpc_id            = aws_vpc.s3vpc.id
  cidr_block        = var.sub_cidr[count.index]
  availability_zone = var.subnet_az[count.index]
  tags = {
    "Name" = var.subnet[count.index]
  }
}

//  creating aws internet gateway

resource "aws_internet_gateway" "s3intgt" {
  vpc_id = aws_vpc.s3vpc.id
  tags = {
    "Name" = "intgt_s3"
  }
}
// creating route-table
resource "aws_route_table" "s3routetb" {
  vpc_id = aws_vpc.s3vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.s3intgt.id
  }
  tags = {
    "Name" = "routetable_s3"
  }
}
// route table association the subnet

resource "aws_route_table_association" "ass_subnet" {
  route_table_id = aws_route_table.s3routetb.id
  count          = length(var.sub_cidr)
  subnet_id      = aws_subnet.s3subnets[count.index].id

}

// creating the security group

resource "aws_security_group" "s3secgp" {
  vpc_id      = aws_vpc.s3vpc.id
  description = "This is the security group for the s3 bucket"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "This is for ssh"
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
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "To allow all"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
  tags = {
    "Name" = "security_s3"
  }
}
// To create a ec2  instance first create a network interface 
/*resource "aws_network_interface" "s3netinf" {
  subnet_id = aws_subnet.s3subnets[0].id
  
  tags = {
    "Name" = "network_interface"
  }

}*/
// creating the EC2 instance 
resource "aws_instance" "s3instance" {
  ami                         = "ami-062df10d14676e201" // EC2 ubuntu machine in mumbai region
  subnet_id                   = aws_subnet.s3subnets[0].id
  availability_zone           = var.subnet_az[0]
  instance_type               = var.machine_type
  key_name                    = var.key_pair
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.s3secgp.id]
  //subnet_id = aws_subnet.s3subnets[0].id
  root_block_device {
    volume_size = 8
  }
  /* network_interface {
    network_interface_id = aws_network_interface.s3netinf.id
    device_index         = 0
  }*/
  tags = {
    "Name" = "s3ec2test"
  }
}
