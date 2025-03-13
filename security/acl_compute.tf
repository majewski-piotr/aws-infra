resource "aws_network_acl" "compute" {
  vpc_id = local.vpc_id_private

  subnet_ids = local.subnet_ids_compute
}

# Outbound rules

# Allow HTTP (ephemeral) to edge
resource "aws_network_acl_rule" "outbound_allow_ephemeral" {
  count          = length(local.subnet_cidrs_edge)
  network_acl_id = aws_network_acl.compute.id
  rule_number    = 100 + count.index
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.subnet_cidrs_edge[count.index]
  from_port      = 1024
  to_port        = 65535
}

#  Deny all other outbound traffic
resource "aws_network_acl_rule" "outbound_deny_all" {
  network_acl_id = aws_network_acl.compute.id
  rule_number    = 200
  egress         = true
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}


# Allow HTTP (port 80) traffic from edge
resource "aws_network_acl_rule" "inbound_allow_http" {
  count          = length(local.subnet_cidrs_edge)
  network_acl_id = aws_network_acl.compute.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.subnet_cidrs_edge[count.index]
  from_port      = 80
  to_port        = 80
}

# Deny all other inbound traffic
resource "aws_network_acl_rule" "inbound_deny_all" {
  network_acl_id = aws_network_acl.compute.id
  rule_number    = 200
  egress         = false
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}
