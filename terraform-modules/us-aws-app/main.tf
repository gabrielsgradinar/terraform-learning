module "us_aws_app" {
  source     = "../aws-app"
  app_region = "us-east-1"
  ami        = "ami-0b5eea76982371e91"
}
