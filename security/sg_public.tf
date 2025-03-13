resource "aws_security_group" "public" {
  name        = "public-sg"
  description = "Security group for public resources"
  vpc_id      = local.vpc_id_public
}

resource "aws_vpc_security_group_ingress_rule" "allow_80_from_everywhere" {
  security_group_id = aws_security_group.public.id
  ip_protocol       = "http"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "public_allow_80_to_edge" {
  security_group_id            = aws_security_group.public.id
  ip_protocol                  = "http"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.edge.id
}
