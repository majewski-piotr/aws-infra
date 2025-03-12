resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/25"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = false

   tags = {
    Name = "private-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.128/25"
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = false

   tags = {
    Name = "private-b"
  }
}