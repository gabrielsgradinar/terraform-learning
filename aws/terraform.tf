terraform {
  backend "s3" {
    bucket = "gabriel-terraform-state-bucket01"
    key    = "finance/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "state-locking" LockID
  }
}
