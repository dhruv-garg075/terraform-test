terraform {
  required_providers {
    aws = {
      version = "4.62.0"
      source  = "hashicorp/aws"
      configuration_aliases = [ aws.dev, aws.prod ]
    }
  }
}

