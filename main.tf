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

module "platform" {
  source         = "./modules/platform"
  app_name       = var.app_name
  env            = var.env
  vpc_cidr       = var.vpc_cidr
  public_cidr_1  = var.public_cidr_1
  public_cidr_2  = var.public_cidr_2
  private_cidr_1 = var.private_cidr_1
  private_cidr_2 = var.private_cidr_2
}

module "service" {
  source             = "./modules/service"
  desired_tasks      = var.desired_tasks
  ecs_cluster        = module.platform.ecs_cluster
  public_cidr_1      = module.platform.public_cidr_1
  public_cidr_2      = module.platform.public_cidr_2
  target_group       = module.platform.target_group
  int_security_group = module.platform.int_security_group
}

output "URL_to_test" {
  value = module.platform.URL_to_test
}