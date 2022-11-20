region       = "ap-south-1"
cidr         = "10.10.1.0/16" // here we changed the cidr range of vpc to change from dev to qa environment.
subnet_az    = ["ap-south-1a"]
subnet_name  = ["appsubnet"]
machine_type = "t2.micro"
key_pair     = "pckey"
qa           = ["qa1", "qa2"]
