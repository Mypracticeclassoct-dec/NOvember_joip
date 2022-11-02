resource "aws_vpc" "vpc_auto" {
  cidr_block = var.cidr
  tags = {
    Name = "vpc_Autosg"
  }
  //"This is the vpc for autoscaling group"
}
resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.vpc_auto.id
  cidr_block = var.sub_cidr
  tags = {
    "Name" = "subnet_Autosg"
  }
  depends_on = [
    aws_vpc.vpc_auto
  ]
  // This is the subnet for the vpc_Auto   
}
resource "aws_internet_gateway" "au_gw" {
  vpc_id = aws_vpc.vpc_auto.id
  tags = {
    "Name" = "Auto_int_gw"
  }
  depends_on = [
    aws_subnet.sub1
  ]
} // creating a internet-gateway.

/*Attaching internet gateway to vpc
resource "aws_internet_gateway_attachment" "Attach_gw" {
  internet_gateway_id = aws_internet_gateway.au_gw.id
  vpc_id              = aws_vpc.vpc_auto.id
} */ 

resource "aws_route_table" "Auto_route" {
  vpc_id = aws_vpc.vpc_auto.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.au_gw.id
  }
} // creating a route table and attaching it to vpc

resource "aws_route_table_association" "Associ_rt" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.Auto_route.id
  //gateway_id = aws_internet_gateway.au_gw.id
} // associating subnet to the route-table.  

// Creating the security group :

resource "aws_security_group" "Autosg" {
  description = " This is the security group for the autoscaling group"
  vpc_id      = aws_vpc.vpc_auto.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "for the http"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    }
   ingress {
      cidr_blocks = ["0.0.0.0/0"]
      description = "for the https"
      from_port   = 443
      protocol    = "tcp"
      to_port     = 443

    }
    ingress {
      cidr_blocks = ["0.0.0.0/0"]
      description = "for the ssh"
      from_port   = 22
      protocol    = "tcp"
      to_port     = 22
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Autosg-security"
  }
}
