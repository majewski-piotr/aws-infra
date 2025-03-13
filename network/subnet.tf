resource "aws_subnet" "compute" {
  for_each = local.availability_zones
  vpc_id                  = aws_vpc.private.id
  cidr_block              = local.cidr.private.subnet.compute[each.value]
  availability_zone       = "${var.region}${each.value}"
  map_public_ip_on_launch = false

  tags = {
    Name = "compute-${each.value}"
  }
}

resource "aws_subnet" "edge" {
  for_each = local.availability_zones
  vpc_id                  = aws_vpc.private.id
  cidr_block              = local.cidr.private.subnet.edge[each.value]
  availability_zone       = "${var.region}${each.value}"
  map_public_ip_on_launch = false

  tags = {
    Name = "edge-${each.value}"
  }
}

resource "aws_subnet" "public" {
  for_each = local.availability_zones
  vpc_id                  = aws_vpc.public.id
  cidr_block              = local.cidr.public.subnet[each.value]
  availability_zone       = "${var.region}${each.value}"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${each.value}"
  }
}
