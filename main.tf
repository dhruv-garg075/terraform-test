provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "dev"
  assume_role {
    role_arn     = "arn:aws:iam::122838670202:role/TerraformTestRole-Assume"
  }
}

terraform {
  required_providers {
    aws = {
      version = "4.39.0"
      source  = "hashicorp/aws"
    }
  }
}

module "iam_role" {
  source = "./modules/iam_role"
  account_id = 122838670202
  providers = {
    aws.dev = aws.dev
  }
}
