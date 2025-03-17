terraform {
  backend "s3" {
    bucket         = "terraform-state-6243253242"
    key            = "access_analyzer/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state"
    encrypt        = true
  }
}
