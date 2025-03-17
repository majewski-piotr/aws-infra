data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = var.state.bucket
    key    = var.state.keys.network
    region = var.region
  }
}

data "aws_s3_object" "security_state" {
  bucket        = var.state.bucket
  key           = var.state.keys.security
  checksum_mode = "ENABLED"
}

data "aws_s3_object" "network_state" {
  bucket        = var.state.bucket
  key           = var.state.keys.network
  checksum_mode = "ENABLED"
}

resource "null_resource" "remote_state_trigger" {
  triggers = {
    security_state_etag = data.aws_s3_object.security_state.etag
    network_state_etag  = data.aws_s3_object.network_state.etag
  }
}

locals {
  vpc_id_private       = data.terraform_remote_state.network.outputs.vpc_id_private
  vpc_id_public        = data.terraform_remote_state.network.outputs.vpc_id_public
  subnet_cidrs_compute = data.terraform_remote_state.network.outputs.subnet_cidrs_compute
  subnet_cidrs_public  = data.terraform_remote_state.network.outputs.subnet_cidrs_public
  subnet_cidrs_edge    = data.terraform_remote_state.network.outputs.subnet_cidrs_edge
  subnet_ids_compute   = data.terraform_remote_state.network.outputs.subnet_ids_compute
  subnet_ids_edge      = data.terraform_remote_state.network.outputs.subnet_ids_edge
  subnet_ids_public    = data.terraform_remote_state.network.outputs.subnet_ids_public
  vpc_cidr_private     = data.terraform_remote_state.network.outputs.vpc_cidr_private
  vpc_cidr_public      = data.terraform_remote_state.network.outputs.vpc_cidr_public
}
