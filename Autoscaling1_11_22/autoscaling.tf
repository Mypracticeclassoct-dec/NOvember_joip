// calling the data of the ami-image created in the aws ui console .

data "aws_ami" "amitf" {
  most_recent = true
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

// creating a aws launch template and specifying the details

resource "aws_launch_template" "ln_tmp" {
  name_prefix   = "web_config"
  image_id      = data.aws_ami.amitf.id
  instance_type = var.machine_type
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 20
    }
  }
  instance_initiated_shutdown_behavior = "terminate"

  network_interfaces {
    associate_public_ip_address = true
  }

  placement {
    availability_zone = var.subnet_az
  }
  vpc_security_group_ids = [aws_security_group.Autosg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Template_inst"
    }
  }
  tags = {
    "Name" = "Template_asg"
  }
}

// Creating the Autoscaling group:

resource "aws_autoscaling_group" "autosg" {
  availability_zones = var.subnet_az
  desired_capacity   = 1
  max_size           = 3
  min_size           = 1
  health_check_grace_period = 300
  health_check_type = "EC2"
  launch_template {
    id      = aws_launch_template.ln_tmp.id
    version = "$Default" //giving the default template version.
  }

}
