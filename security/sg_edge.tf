resource "aws_security_group" "edge" {
  name        = "edge-sg"
  description = "Security group for edge resources"
  vpc_id      = local.vpc_id_private
}

resource "aws_vpc_security_group_ingress_rule" "edge_allow_80_from_public" {
  security_group_id            = aws_security_group.public.id
  ip_protocol                  = "http"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.public.id
}

resource "aws_vpc_security_group_egress_rule" "edge_allow_80_to_compute" {
  security_group_id            = aws_security_group.public.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.compute
}
