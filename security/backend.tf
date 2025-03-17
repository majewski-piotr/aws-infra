terraform {
  backend "s3" {
    bucket         = "terraform-state-6243253242"
    key            = "security/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state"
    encrypt        = true
  }
}
