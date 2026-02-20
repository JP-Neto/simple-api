data "terraform_remote_state" "connectivity" {
  backend = "s3"
  config = {
    bucket = "jpn-tfstate-s3"
    key    = "jpn/development/connectivity.tfstate"
    region = "us-east-1"
  }
}
data "terraform_remote_state" "security" {
  backend = "s3"
  config = {
    bucket = "jpn-tfstate-s3"
    key    = "jpn/development/security.tfstate"
    region = "us-east-1"
  }
}