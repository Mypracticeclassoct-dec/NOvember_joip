// creating backend s3 

terraform {
  backend "s3" {
    bucket = "backendtfbuckets3"
    key = "pckey"
    region = "ap-south-1"
    dynamodb_table = "terraformbackendtbs3"

  }
}
/* create a new dbtable and new s3 bucket */