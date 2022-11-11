### Perform the task given in the terraform _task_11 document
-------------------------------------------------------------
* we have to create a vpc and app-subnet .
* create two envirinments:
    1. dev 
    2. qa 
* In dev environment create 1 ec2 instance type t2.micro and with a "Public ip" enabled.
* In qa environmet create 2 ec2 instances type t2.micro with only "Private ip" enabled.
* use backend and provisioning service of terraform and install the "angular" in the ec2 instances.