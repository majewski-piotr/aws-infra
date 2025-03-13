
resource "aws_network_acl" "public" {
  vpc_id     = local.vpc_id_public
  subnet_ids = local.subnet_ids_public
}

# Inbound rules

# Allow HTTP (port 80) from everywhere
resource "aws_network_acl_rule" "public_inbound_allow_http" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

# Deny all other inbound traffic
resource "aws_network_acl_rule" "public_inbound_deny_all" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 200
  egress         = false
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

# Outbound rules

# Allow ephemeral ports (1024-65535) to everywhere
resource "aws_network_acl_rule" "public_outbound_allow_ephemeral" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

# Allow HTTP (port 80) to a edge
resource "aws_network_acl_rule" "public_outbound_allow_http_to_edge" {
  count          = length(local.subnet_cidrs_edge)
  network_acl_id = aws_network_acl.public.id
  rule_number    = 110 + count.index
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.subnet_cidrs_edge[count.index]
  from_port      = 80
  to_port        = 80
}

# Deny all other outbound traffic
resource "aws_network_acl_rule" "public_outbound_deny_all" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 200
  egress         = true
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}
