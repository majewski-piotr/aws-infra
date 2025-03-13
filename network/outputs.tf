output "subnet_cidrs_compute" {
  value = [for cidr in local.cidr.private.subnet.compute : cidr]
}

output "subnet_cidrs_edge" {
  value = [for cidr in local.cidr.private.subnet.edge : cidr]
}

output "subnet_cidrs_public" {
  value = [for cidr in local.cidr.public.subnet : cidr]
}

output "subnet_ids_compute" {
  value = values(aws_subnet.compute)[*].id
}

output "subnet_ids_edge" {
  value = values(aws_subnet.edge)[*].id
}

output "subnet_ids_public" {
  value = values(aws_subnet.public)[*].id
}

output "vpc_cidr_private" {
  value = local.cidr.private.vpc
}

output "vpc_cidr_public" {
  value = local.cidr.public.vpc
}

output "vpc_id_private" {
  value = aws_vpc.private.id
}

output "vpc_id_public" {
  value = aws_vpc.public.id
}
