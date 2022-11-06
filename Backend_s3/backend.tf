// creating backend s3 

terraform {
  backend "s3" {
    bucket = "mys3bucketbackend"
    key = "<your key>"
    region = "ap-south-1"
    dynamodb_table = "terraforms3table"

  }
}
/* create a new dbtable and new s3 bucket */