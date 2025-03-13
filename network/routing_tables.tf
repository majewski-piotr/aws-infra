resource "aws_route_table" "edge" {
  vpc_id = aws_vpc.private.id

  tags = {
    Name = "edge-route-table"
  }
}

resource "aws_route_table" "compute" {
  vpc_id = aws_vpc.private.id

  tags = {
    Name = "compute-route-table"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.public.id

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "compute" {
  for_each       = aws_subnet.compute
  subnet_id      = each.value.id
  route_table_id = aws_route_table.compute.id
}

resource "aws_route_table_association" "edge" {
  for_each       = aws_subnet.edge
  subnet_id      = each.value.id
  route_table_id = aws_route_table.edge.id
}

resource "aws_route_table_association" "public_subnets" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "edge_to_public" {
  route_table_id         = aws_route_table.edge.id
  destination_cidr_block = local.cidr.public.vpc
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "public_to_edge" {
  for_each               = local.cidr.private.subnet.edge
  route_table_id         = aws_route_table.public
  destination_cidr_block = each.value
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "public_to_igw" {
  route_table_id         = aws_route_table.public
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
