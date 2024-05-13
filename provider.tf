terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state"
    key    = "aws-test/terraform.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region     = "eu-central-1"
}



