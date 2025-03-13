resource "aws_network_acl" "edge" {
  vpc_id = local.vpc_id_private

  subnet_ids = local.subnet_ids_edge
}

# Outbound rules

# Allow HTTP (port 80) to public
resource "aws_network_acl_rule" "edge_outbound_allow_http_to_public" {
  count          = length(local.subnet_cidrs_public)
  network_acl_id = aws_network_acl.edge.id
  rule_number    = 100 + count.index
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.subnet_cidrs_public[count.index]
  from_port      = 80
  to_port        = 80
}

# Allow HTTP (port 80) to compute
resource "aws_network_acl_rule" "edge_outbound_allow_http_to_compute" {
  count          = length(local.subnet_cidrs_compute)
  network_acl_id = aws_network_acl.edge.id
  rule_number    = 200 + count.index
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.subnet_cidrs_compute[count.index]
  from_port      = 80
  to_port        = 80
}

#  Deny all other outbound traffic
resource "aws_network_acl_rule" "edge_outbound_deny_all" {
  network_acl_id = aws_network_acl.compute.id
  rule_number    = 300
  egress         = true
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

# Inbound rules

# Allow HTTP (port 80) from public
resource "aws_network_acl_rule" "edge_inbound_allow_http_from_public" {
  count          = length(local.subnet_cidrs_public)
  network_acl_id = aws_network_acl.compute.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.subnet_cidrs_public[count.index]
  from_port      = 80
  to_port        = 80
}

# Allow HTTP (ephemeral) from compute
resource "aws_network_acl_rule" "edge_inbound_allow_http_from_compute" {
  count          = length(local.subnet_cidrs_compute)
  network_acl_id = aws_network_acl.compute.id
  rule_number    = 100 + count.index
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.subnet_cidrs_compute[count.index]
  from_port      = 1024
  to_port        = 65535
}

# Deny all other inbound traffic
resource "aws_network_acl_rule" "edge_inbound_deny_all" {
  network_acl_id = aws_network_acl.compute.id
  rule_number    = 200
  egress         = false
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}
