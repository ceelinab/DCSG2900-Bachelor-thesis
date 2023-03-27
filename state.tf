terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }

    snyk{
      source = "snyk/snyk"
      version = ">= 1.0.0"
    }
    */
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  profile = "default"
  region  = "eu-north-1"
}

/**

/**
provider "snyk" {
  # Enter your Snyk API token here
  token = "your-snyk-api-token"
}
*/