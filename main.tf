terraform {
  backend "s3" {
    bucket         = "jh2020-terraform"
    key            = "l-case-study.tfstate"
    dynamodb_table = "jh2020-terraform"
    region         = "eu-west-2"
  }
}

provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-2"
}