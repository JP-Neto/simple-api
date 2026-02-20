data "terraform_remote_state" "connectivity" {
  backend = "s3"
  config = {
    bucket = "jpn-tfstate-s3"
    key    = "jpn/connectivity/connectivity.tfstate"
    region = "us-east-1"
  }
}