terraform {
  required_version = "~> 1.11.0" // terraform version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.96.0" // provider(aws) version
    }
  }
}