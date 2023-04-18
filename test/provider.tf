terraform {
  required_providers {
    aws = {
      version = "4.39.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "dev"
  assume_role {
    role_arn = "arn:aws:iam::${var.dev_account_id}:role/TerraformTestRole-Assume"
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "prod"
  assume_role {
    role_arn = "arn:aws:iam::${var.prod_account_id}:role/TerraformTestRole-Assume"

  }
}

