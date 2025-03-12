resource "aws_vpc" "private" {
  cidr_block           = local.cidr.private.vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_vpc" "public" {
  cidr_block           = local.cidr.public.vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
}