# Steps to create a AutoScaling group :
-------------------------------------------------------------------------
## step 1:
* create an ec2 instance with the required softwares preinstalled and make an AMI from the EC2 instance.
## step 2:
* create an vpc using terraform :
* create an subnet and an internet-gateway with an route-table and assign them to the vpc.
* Associate the subent to the route which have the internet access.
* create a security group and assign it to the vpc.
## step 3:
