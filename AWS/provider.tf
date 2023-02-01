provider "aws" {
  region                  = var.aws_region
  profile                 = var.aws_profile_name
  shared_credentials_files = ["$HOME/.aws/credentials"]
}
