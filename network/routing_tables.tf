# Private VPC Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.private.id

  tags = {
    Name = "private-route-table"
  }
}

# Public VPC Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.public.id

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "private_subnets" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_subnets" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "private_to_public" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = local.cidr.public.vpc
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "public_to_private" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = local.cidr.private.vpc
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}