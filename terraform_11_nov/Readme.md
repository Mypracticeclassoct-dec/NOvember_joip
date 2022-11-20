### Perform the task given in the terraform _task_11 document
-------------------------------------------------------------
* we have to create a vpc and app-subnet .
* create two envirinments using wprkspace concept in terraform .
    1. dev 
    2. qa 
* In dev environment create 1 ec2 instance type t2.micro and with a "Public ip" enabled.
* In qa environmet create 2 ec2 instances type t2.micro with only "Private ip" enabled.
* use backend and provisioning service of terraform and install the "angular" in the ec2 instances.
---------------------------------------------------------------
* we can create a terraform new workspace by using the command "terraform workspace new < workspace name >"
* To create an "dev" environment use the command "terraform workspace new dev", similarly to create "qa" environment use the command "terraform workspace new qa".
* To check the list workspaces present use the command  "terraform workspace list" in the displayed list of workspaces the workspace which is indicated by a '*(star)' is our current workspace /environment. 
* To check only the active workspace / environment we are currently working use the command "terraform workspace show "
* To switch from one workspace to another use the command "terraform workspace select < workspace name >".
* In the s3 bucket after we create the resources using the different environments their create a folder ENV/ and in that our env folders are created which contains our key of our backend.
-----------------------------------------------------------------
