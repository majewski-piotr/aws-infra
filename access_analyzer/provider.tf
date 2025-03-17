terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.90.01"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = "1.33.0"
    }
  }
}

provider "awscc" {
  region = var.region
}

provider "aws" {
  region = var.region

  default_tags {
    tags = merge(
      var.tags,
      { Service = "Network" }
    )
  }
}
