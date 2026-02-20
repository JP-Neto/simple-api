terraform {
  required_version = ">= 1.14.3"

  backend "s3" {
   bucket  = "jpn-tfstate-s3"
    key     = "application/application.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}