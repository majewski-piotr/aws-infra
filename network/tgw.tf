resource "aws_ec2_transit_gateway" "tgw" {
  security_group_referencing_support = "enable"
  default_route_table_propagation    = "disable"
  default_route_table_association    = "disable"
}

### PUBLIC VPC ATTACHMENT
resource "aws_ec2_transit_gateway_vpc_attachment" "public" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.public.id
  subnet_ids         = values(aws_subnet.public)[*].id
}

resource "aws_ec2_transit_gateway_route_table" "public" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_ec2_transit_gateway_route_table_association" "public" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.public.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.public.id
}

#   allows traffic from public vpc into private vpc edge subnets
resource "aws_ec2_transit_gateway_route" "public_to_edge" {
  destination_cidr_block         = local.cidr.private.vpc
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.public.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.public.id
}

### PRIVATE VPC ATTACHMENT
resource "aws_ec2_transit_gateway_vpc_attachment" "edge" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.private.id
  subnet_ids         = values(aws_subnet.edge)[*].id
}

resource "aws_ec2_transit_gateway_route_table" "edge" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_ec2_transit_gateway_route_table_association" "edge" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.edge.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.edge.id
}

#   allows traffic from private vpc into public vpc
resource "aws_ec2_transit_gateway_route" "edge_to_public" {
  destination_cidr_block         = local.cidr.public.vpc
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.edge.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.edge.id
}
