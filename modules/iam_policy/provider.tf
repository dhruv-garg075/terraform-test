terraform {
  required_providers {
    aws = {
      version = "4.62.0"
      source  = "hashicorp/aws"
      configuration_aliases = [ aws.dev ]
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
