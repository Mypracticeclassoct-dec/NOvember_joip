terraform {
  backend "s3" {
    bucket         = ""           // enter the s3 bucket created in the aws in required region 
    key            = "envkey"     // name as per the user.
    dynamodb_table = ""           // enter the dynamodb_table name created in the same region as the s3 bucket with partition key named "LockID" with type of "String" in dynamodb settings.
    region         = "ap-south-1" // mumbai region. 
  }
}
// Before running the script create the s3 bucket and a dynamodb_table and enter their names. 