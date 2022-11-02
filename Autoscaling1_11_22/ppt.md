# Steps to create a AutoScaling group :
-------------------------------------------------------------------------
## step 1:
* create an ec2 instance with the required softwares preinstalled and make an AMI from the EC2 instance.
## step 2:
* create an vpc using terraform.
* create an subnet and an internet-gateway with an route-table and assign them to the vpc.
* Associate the subent to the route which have the internet access.
* create a security group and assign it to the vpc.
## step 3:
* create an autoscaling group, to create the autoscaling group first we  need an **AMI(amazon machine image)** to create the "Template".
* After creating the AMI using _Packer_ or through manual process.
* create the autoscaling group by refering the terraform document.
---------------------------------------------------------------------------------------------------------------
## Steps:
    * create  four **".tf"** file namely, autoscaling.tf,ext.tfvars,resource.tf,variables.tf
    * The autoscaling.tf file consistes of the autoscaling group configuration like autoscaling group resource, the variables.tf consists of the variables defined in the ext.tfvars file.
    * The resource.tf consists of the resource configuration like vpc,subnet,internet-gateway,securitygroup.
    -------
    * create a vpc .
    * create a subnet in the vpc .
    * create a interner-gateway and assign it to the vpc.
    * create a route-table and assign it to the vpc and assign a rout to internet-gateway.
    * Associate the subnet to the route-table.
    *  create the security group and specify the inbound and outbound rules.
    -------
    * After creating  the network, now we have to create  the launch template for the autoscaling group.
    * In the launch template,provide the AMI details like image.id and availability zone and key-pair and instance type according to the terraform-template.
    * After providing the details create the autoscaling group from terraform-template and give the details specified in the task.
    --------
    --------
    After creatinf the required .tf files go to "shell".The shell terminal should be launched in the folder where the terraform files are present, after  run the command **Terraform init**, and **Terraform validate**, if there are errors in the .tf files it will show in the terminal when we validate it and after rectifying the errors run the command **Terraform apply**, it will ask for the user confirmation and after confirming the resources will be created.
    