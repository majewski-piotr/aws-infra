provider "aws" {
  region = var.region

  default_tags {
    tags = merge(
      var.tags,
      { Service = "Security" }
    )
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.90.01"
    }
  }
}
