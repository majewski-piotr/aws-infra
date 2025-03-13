resource "aws_security_group" "compute" {
  name        = "public-sg"
  description = "Security group for compute resources"
  vpc_id      = local.vpc_id_private
}

resource "aws_vpc_security_group_ingress_rule" "compute_allow_from_edge" {
  security_group_id            = aws_security_group.public.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.edge.id
}